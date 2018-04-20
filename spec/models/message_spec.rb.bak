require 'rails_helper' 
 
describe "Message" do 
    before(:each) do 
        @msg = FactoryGirl.build(:message) 
    end 
 
    context "Validation" do 
        it "has a valid factory" do 
 
            # puts ("@msg.name: #{@msg.name}") 
            # puts ("@msg.email: #{@msg.email}") 
            # puts ("@msg.subject: #{@msg.subject}") 
            # puts ("@msg.message: #{@msg.message}") 
 
            expect(@msg.valid?).to eq(true) 
        end 
 
        it "is invalid without a name" do 
            expect(@msg.name).not_to be_empty 
        end 
 
        it "is invalid if the name is too long" do 
            @msg.name = "a" * 51 
                expect(@msg).not_to be_valid 
        end 
 
        it "is invalid without an email" do 
            expect(@msg.email).not_to be_empty 
        end 
         
        it "is invalid if the email is too long" do 
            @msg.email = ("a" * 245) + "@domain.com" 
                expect(@msg).not_to be_valid 
        end 
 
        it "is invalid with an invalid email address" do 
            addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com] 
 
            addresses.each do |invalid_address| 
                @msg.email = invalid_address 
                expect(@msg).not_to be_valid 
            end 
        end 
 
        it "is valid with a valid email address" do 
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn] 
 
            addresses.each do |valid_address| 
                @msg.email = valid_address 
                expect(@msg).to be_valid 
            end 
        end 
 
        it "is invalid without a subject" do 
            expect(@msg.subject).not_to be_empty 
        end 
 
        it "is invalid if the subject is too long" do 
            @msg.subject = "a" * 101 
                expect(@msg).not_to be_valid 
        end 
 
        it "is invalid without a message body" do 
            expect(@msg.message).not_to be_empty 
        end 
    end 
end
