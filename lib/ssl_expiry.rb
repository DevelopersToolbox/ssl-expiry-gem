#
# Stuff to go here
#

require 'net/http'
require 'openssl'

require 'ssl_expiry/errors'
require 'ssl_expiry/version'

#
# Docs to follow
#
class SSLExpiry
    #
    # Stuff
    #

    class << self
        # This method smells of :reek:NilCheck, :reek:UncommunicativeVariableName, :reek:DuplicateMethodCall
        def get_cert(domain_name, supplied_port = 443)
            cert = nil

            uri = URI::HTTPS.build(host: domain_name)
            http = Net::HTTP.new(uri.host, supplied_port)

            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER
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

        def process_certificate(cert, date_format)
            ssl_common_name = cert.subject.to_a.select { |name, _data, _type| name == 'CN' }.first[1]
            issuer_name = cert.issuer.to_a.select { |name, _data, _type| name == 'O' }.first[1]
            expires_on = cert.not_after
            num_days = ((expires_on - Time.now) / 864_00).to_i

            { 'status' => 200, 'expires_on' => expires_on.strftime(date_format), 'expires_in' => num_days, 'common_name' => ssl_common_name, 'issuer' => issuer_name }
        rescue StandardError
            { 'status' => 400, 'error' => 'Parsing error' }
        end

        # This method smells of :reek:DuplicateMethodCall, :reek:UncommunicativeVariableName
        def check_certificates(domains, date_format = '%d %b %Y')
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

                results[domain] = process_certificate(cert, date_format)
            end
            results.sort
        end

        # This method smells of :reek:DuplicateMethodCall
        def display_results(results, width = 120)
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
                printf(" %-30<domain_name>s | %<ssl_status>s\n", domain_name: domain, ssl_status: status)
            end
            puts(delim)
        end
    end
end
