# frozen_string_literal: true

require 'ssl_expiry/errors'
require 'ssl_expiry/version'

require 'net/http'
require 'openssl'

#
# Docs to follow
#
module SSLExpiry
    #
    # Docs to follow
    #
    class SSLExpiry
        def self.get_cert(domain_name, supplied_port = nil, verify = false)
            begin
                cert = nil

                uri = URI::HTTPS.build(host: domain_name)

                port = if supplied_port.nil?
                           uri.port
                       else
                           supplied_port
                       end

                http = Net::HTTP.new(uri.host, port)

                http.use_ssl = true
                http.verify_mode = verify ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
                http.open_timeout = 5
                http.read_timeout = 5
                http.ssl_timeout  = 5

                http.start do |h|
                    cert = h.peer_cert
                end

                cert
            rescue SocketError, SystemCallError => e
                raise SSLError.new "Bad URL? #{e.message}"
            rescue Net::OpenTimeout
                raise SSLError.new 'Timed out. Is the site up?'
            rescue OpenSSL::SSL::SSLError => e
                raise SSLError.new "We're trying to validate your certificate using TLSv1 It looks like your server doesn't accept it: [#{$ERROR_INFO.message}]" if e.message =~ /sslv3.+tlsv1 alert/i
            end
        end

        def self.check_certificates(domains, date_format = '%d %b %Y')
            results = {}

            domains = domains.split(',') unless domains.is_a?(Array)

            domains.each do |domain|
                begin
                    parts = domain.split(':')

                    cert = if parts.length == 2
                               get_cert(parts[0], parts[1])
                           else
                               get_cert(parts[0])
                           end
                rescue SSLError => e
                    results[domain] = { 'status' => 400, 'error' => e.message }
                    next
                end

                begin
                    common_name = cert.subject.to_a.select { |name, _data, _type| name == 'CN' }.first[1]
                    issuer = cert.issuer.to_a.select { |name, _data, _type| name == 'O' }.first[1]
                    expires_on = cert.not_after
                    num_days = ((expires_on - Time.now) / 864_00).to_i

                    results[domain] = { 'status' => 200, 'expires_on' => expires_on.strftime(date_format), 'expires_in' => num_days, 'common_name' => common_name, 'issuer' => issuer }
                rescue StandardError
                    results[domain] = { 'status' => 400, 'error' => 'Parsing error' }
                end
            end
            results.sort
        end

        def self.display_results(results, width = 120)
            delim = '-' * width

            puts(delim)
            printf(" %-30<header1>s | %<header2>s\n", header1: 'Domain', header2: 'Status')
            puts(delim)
            results.each do |domain, details|
                status = if details['status'] == 400
                             details['error']
                         else
                             format('expires on %<expires_in>s (in %<expires_on>s days) [CN=%<common_name>s]', expires_in: details['expires_on'], expires_on: details['expires_in'], common_name: details['common_name'])
                         end
                printf(" %-30<domain>s | %<status>s\n", domain: domain, status: status)
            end
            puts(delim)
        end
    end
end
