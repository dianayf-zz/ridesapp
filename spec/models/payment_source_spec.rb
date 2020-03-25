require 'spec_helper'
require './models/payment_source.rb'
require './models/rider.rb'

RSpec.describe PaymentSource, type: :model do
  context 'validations' do
    context 'rider_id' do
      it 'when is nil' do
        source = PaymentSource.new(rider_id: nil, reference: "34", token: "test_card_1123")
        expect(source.valid?).to eq false
        expect(source.errors).to eq( {:rider_id=>["is not present"]} )
      end
    end
    context 'reference' do
      it 'when is nil' do
        rider = Rider.create(name: "caro", last_name: "jimenez", email: "carito@email.com", phone: "3193333333")
        source = PaymentSource.new(rider_id: rider.id, reference: nil, token: "test_card_1123")
        expect(source.valid?).to eq false
        expect(source.errors).to eq( {:reference=>["is not present"]} )
      end
    end
    context 'token' do
      it 'when is nil' do
        rider = Rider.create(name: "caro", last_name: "jimenez", email: "carito@email.com", phone: "3193333333")
        source = PaymentSource.new(rider_id: rider.id, reference: "34", token: " ")
        expect(source.valid?).to eq false
        expect(source.errors).to eq({:token=>["is not present"]})
      end
    end
  end
end
