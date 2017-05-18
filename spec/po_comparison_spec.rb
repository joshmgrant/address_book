require "spec_helper"

describe "Test in Parallel" do

  it 'deletes address from list' do
    AddressBook.new.log_in_user
    2.times { AddressBook.new.create_address }
    address = AddressBook.new.create_address
    2.times { AddressBook.new.create_address }
    Addresses::List.visit.destroy(address)
    expect(Addresses::List.new.destroyed_message?).to eq true
    expect(AddressBook.new.address_present?(address)).to eq false
  end

end