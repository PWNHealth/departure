require 'spec_helper'

describe Departure::Connection::Ssl do
  let(:ssl_connection) { described_class.new(connection_data) }

  describe '#ssl_arguments' do
    subject { ssl_connection.ssl_arguments }

    context 'when the ssl_mode is not set' do
      let(:connection_data) { {} }
      it { is_expected.to match('') }
    end

    context 'when the ssl_mode is disable' do
      context 'without other ssl configuration' do
        let(:connection_data) { { ssl_mode: :disabled } }

        it { is_expected.to match('') }
      end

      context 'with ssl configuration' do
        let(:connection_data) { { ssl_mode: :disabled, sslca: '~/test.pem' } }

        it { is_expected.to match('') }
      end
    end

    context 'when the ssl_mode is enabled' do
      context 'without other ssl configuration' do
        let(:connection_data) { { ssl_mode: :required } }

        it { is_expected.to match(';mysql_ssl=1') }
      end

      context 'with ssl configuration' do
        let(:connection_data) { { ssl_mode: :required, sslca: '~/test.pem' } }

        it { is_expected.to match(';mysql_ssl=1;mysql_ssl_client_ca=~/test.pem') }
      end
    end
  end
end
