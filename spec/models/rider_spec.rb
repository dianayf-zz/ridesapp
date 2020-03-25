require 'spec_helper'
require './models/rider.rb'

RSpec.describe Rider, type: :model do
  context 'validations' do
    context 'name' do
      it 'when is nil' do
        rider = Rider.new(name: nil, last_name: "sanchez", email: "sanchez@mail.com", phone: "3908999899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq( {:name=>["is not present"]} )
      end
      it 'when is empty string' do
        rider = Rider.new(name: " ", last_name: "sanchez", email: "sanchez@email.com", phone: "3128909899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq({:name=>["is not present"]})
      end
    end
    context 'last_name' do
      it 'when is nil' do
        rider = Rider.new(name:  "juan", last_name: nil, email: "juanito@mail.com", phone: "3899909899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq( {:last_name=>["is not present"]} )
      end
      it 'when is empty string' do
        rider = Rider.new(name: "juaco", last_name: " ", email: "sanchez@email.com", phone: "3128909899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq({:last_name=>["is not present"]})
      end
    end
    context 'email' do
      it 'when is nil' do
        rider = Rider.new(name: "caro", last_name: "jimenez", email: nil, phone: "3128909009")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq({:email=>["is not present", "is not a valid email, please verify"]})
      end
      it 'when is empty string' do
        rider = Rider.new(name: "caro", last_name: "jimenez", email: " ", phone: "3128909899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq({:email=>["is not present", "is not a valid email, please verify"]})
      end
      it 'invalid format' do
        rider = Rider.new(name: "caro", last_name: "jimenez", email: "caritee", phone: "3128909899")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq( {:email =>["is not a valid email, please verify"]} )
      end
    end
    context 'phone' do
      it 'when is nil' do
        rider = Rider.new(name: "caro", last_name: "jimenez", email: "carito@email.com", phone: "31289090055555559")
        expect(rider.valid?).to eq false
        expect(rider.errors).to eq({:phone=>["is longer than 10 characters"]})
      end
    end
  end
end
