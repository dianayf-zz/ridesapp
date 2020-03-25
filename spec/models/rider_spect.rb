require 'spec_helper'
require './models/driver.rb'

RSpec.describe Driver, type: :model do
  context 'validations' do
    context 'name' do
      it 'when is nil' do
        driver = Driver.new(name: nil, last_name: "perez", email: "perez@mail.com", phone: "3128909899")
        expect(driver.valid?).to eq false
        expect(driver.errors).to eq( {:name=>["is not present"]} )
      end
    end
    context 'last_name' do
      it 'when is nil' do
        driver = Driver.new(name:  "juan", last_name: nil, email: "perez@mail.com", phone: "3128909899")
        expect(driver.valid?).to eq false
        expect(driver.errors).to eq( {:last_name=>["is not present"]} )
      end
    end
    context 'email' do
      it 'when is nil' do
        driver = Driver.new(name:  "juan", last_name: "rondon", email: nil, phone: "3128909899")
        expect(driver.valid?).to eq false
        expect(driver.errors).to eq({:email=>["is not present", "is not a valid email, please verify"]})
      end
      it 'when is empty string' do
        driver = Driver.new(name:  "juan", last_name: "rondon", email: " ", phone: "3128909899")
        expect(driver.valid?).to eq false
        expect(driver.errors).to eq({:email=>["is not a valid email, please verify"]})
      end
      it 'invalid format' do
        driver = Driver.new(name:  "juan", last_name: "rondon", email: "juan", phone: "3128909899")
        expect(driver.valid?).to eq false
        expect(driver.errors).to eq( {:email =>["is not a valid email, please verify"]} )
      end
    end
  end
end
