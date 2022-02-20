# frozen_string_literal: true

module Monitoring
  module Scenarios
    describe StopIpObserving do
      subject(:call!) do
        scenario = described_class.new(ip: ip)
        scenario.dependencies = dependencies
        scenario.call!
      end

      let(:fake_repo) { instance_double(Repositories::IpAddress) }
      let(:dependencies) do
        { repo: -> { fake_repo }}
      end

      let(:ip) { Faker::Internet.ip_v4_address }

      context 'when ip address exists' do
        let(:found_ip_address) { build(:ip_address, :stub, ip: ip, observable: true) }

        before do
          allow(fake_repo).to receive(:find_by_ip!).and_return(found_ip_address)
          allow(fake_repo).to receive(:save).and_return(found_ip_address)
        end

        it 'makes ip address unobservable' do
          expect { call! }.to change(found_ip_address, :observable).from(true).to(false)
        end

        it 'saves ip address' do
          call!
          expect(fake_repo).to have_received(:save).with(found_ip_address)
        end

        it 'returns ip address' do
          expect(call!).to eq(found_ip_address)
        end
      end

      context 'when ip address does not exist' do
        before do
          allow(fake_repo).to receive(:find_by_ip!).and_raise(Common::Errors::NotFound)
        end

        it 'raises error' do
          expect { call! }.to raise_error(Common::Errors::NotFound)
        end
      end
    end
  end
end
