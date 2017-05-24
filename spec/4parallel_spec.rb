require "spec_helper"

describe "Test in Parallel" do

  let(:user) { AddressBook::Data::User.new }
  let(:address) { AddressBook::Data::Address.new }

  it 'signup' do
    SignUp.visit.submit_form(user)
    expect(Home.new.signed_in_user).to eq user.email_address
  end

  it 'login' do
    SignUp.visit.submit_form(user)
    Home.new.sign_out_user

    SignIn.visit.submit_form(user)
    expect(Home.new.logged_in?).to eq true
  end

  it 'logout' do
    SignUp.visit.submit_form(user)
    Home.new.sign_out_user
    expect(Home.new.logged_in?).to eq false
  end

  it 'creates' do
    SignUp.visit.submit_form
    AddressBook::Address::New.visit.submit_form(address)
    expect(AddressBook::Address::Show.new.created_message?).to eq true
    expect(AddressBook::Address::List.visit.present?(address)).to eq true
  end

  it 'shows' do
    SignUp.visit.submit_form
    AddressBook::Address::New.visit.submit_form(address)
    expect(AddressBook::Address::Show.new.address?(address)).to eq true
  end

  it 'lists' do
    SignUp.visit.submit_form
    AddressBook::Address::New.visit.submit_form(address)
    expect(AddressBook::Address::List.visit.present?(address)).to eq true
  end

  it 'edits' do
    SignUp.visit.submit_form
    AddressBook::Address::New.visit.submit_form(address)
    AddressBook::Address::Show.new.follow_edit
    edited_address = AddressBook::Address::Edit.new.submit_form
    expect(AddressBook::Address::Show.new.updated_message?).to eq true
    expect(AddressBook::Address::Show.new.address?(edited_address)).to eq true
  end

  it 'deletes' do
    SignUp.visit.submit_form
    AddressBook::Address::New.visit.submit_form(address)
    AddressBook::Address::List.visit.destroy(address)
    expect(AddressBook::Address::List.new.destroyed_message?).to eq true
    expect(AddressBook::Address::List.new.present?(address)).to eq false
  end

end
