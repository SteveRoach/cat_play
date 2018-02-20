require 'rails_helper'

RSpec.describe User, type: :model do
	subject {
		described_class.new(email: "test_name@domain.com",	user_type: "admin",
      password: "foobar", password_confirmation: "foobar")
	}

  it "is valid with valid attributes" do
  	expect(subject).to be_valid
  end

  it "is not valid without an email" do
  	subject.email = nil
  	expect(subject).to_not be_valid
  end
  
  it "is not valid if the email > 255 characters" do
  	subject.email = ("a" * 244) + "@example.com"
  	expect(subject).to_not be_valid
  end
  
  it "is valid if the email address has the right format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      subject.email = valid_address
	  expect(subject).to be_valid
    end
  end
  
  it "is not valid if the email address has the incorrect format" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      subject.email = invalid_address
	  expect(subject).to_not be_valid
    end
  end

  it "is not valid if the email address is a duplicate" do
    subject.save
    duplicate_subject = subject.dup
    duplicate_subject.email = subject.email.upcase
    expect(duplicate_subject).to_not be_valid
  end
  
  it "is not valid if the email address is not saved in lower case" do
    mixed_case_email = "Foo@ExAmPlE.cOm"
    subject.email = mixed_case_email
    subject.save
    expect(mixed_case_email).to_not eq(subject.reload.email)
  end
  
  it "is not valid without a user_type" do
  	subject.user_type = nil
  	expect(subject).to_not be_valid
  end
  
  it "is not valid if the user_type > 20 characters" do
  	subject.user_type = "a" * 21
  	expect(subject).to_not be_valid
  end

  it "is not valid if the password is blank" do
    subject.password = subject.password = " " * 6
    expect(subject).to_not be_valid
  end
  
  it "is not valid if the password is < 6 characters" do
    subject.password = subject.password = "a" * 5
    expect(subject).to_not be_valid
  end
  
end
