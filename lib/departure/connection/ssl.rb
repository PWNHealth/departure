module Departure
  module Connection
    class Ssl
      ENABLED_MODES = %i[preferred required verify_ca verify_identity].freeze

      def initialize(connection_data)
        @connection_data = connection_data
      end

      def ssl_arguments
        return '' unless ssl_mode_enabled?

        ssl = ';mysql_ssl=1'
        ssl += ";mysql_ssl_client_ca=#{ssl_ca}" if ssl_ca.present?

        ssl
      end

      private

      attr_reader :connection_data

      def ssl_mode_enabled?
        ENABLED_MODES.include? ssl_mode
      end

      # Returns the database' SSL mode.
      #
      # @return [String]
      def ssl_mode
        connection_data.fetch(:ssl_mode, :disable)
      end

      # Returns the database' SSL CA certificate.
      #
      # @return [String]
      def ssl_ca
        connection_data.fetch(:sslca, nil)
      end
    end
  end
end
