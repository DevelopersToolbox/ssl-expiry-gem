# frozen_string_literal: true

require 'ssl_expiry'

RSpec.describe SSLExpiry do
    it 'has a version number' do
        expect(SSLExpiry::VERSION).not_to be nil
    end
end
