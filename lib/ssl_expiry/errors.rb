class SSLExpiry
    #
    # Catch all - something bad happened but we don't know what
    #
    class UnknownError < StandardError
        def initialize(msg = 'Something bad happen!')
            super
        end
    end

    #
    # User supplied an invalid token (instead of a missing token)
    #
    class SSLError < StandardError
        def initialize(msg = 'SSL Error')
            super
        end
    end
end
