# frozen_string_literal: true

module Monitoring
  module Scenarios
    describe StartIpObserving do
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
        let(:found_ip_address) { build(:ip_address, :stub, ip: ip, observable: false) }

        before do
          allow(fake_repo).to receive(:find_by_ip).and_return(found_ip_address)
          allow(fake_repo).to receive(:save).and_return(found_ip_address)
        end

        it 'makes ip address observable' do
          expect { call! }.to change(found_ip_address, :observable).from(false).to(true)
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
        let(:created_ip_address) { build(:ip_address, :stub, **expected_attrs) }
        let(:expected_attrs) do
          {
            ip: IPAddr.new(ip),
            observable: true
          }
        end

        before do
          allow(fake_repo).to receive(:find_by_ip).and_return(nil)
          allow(fake_repo).to receive(:create).and_return(created_ip_address)
        end

        it 'creates new ip address' do
          call!
          expect(fake_repo).to have_received(:create)
            .with have_attributes(expected_attrs)
        end

        it 'returns ip address' do
          expect(call!).to eq(created_ip_address)
        end
      end
    end
  end
end
