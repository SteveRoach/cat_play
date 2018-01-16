require "rails_helper"  
 
RSpec.describe MessageMailer, :type => :mailer do  
 
  describe "notify" do  
    msg = FactoryGirl.build(:message) 
 
    # puts ("msg.name: #{msg.name}") 
    # puts ("msg.email: #{msg.email}") 
    # puts ("msg.subject: #{msg.subject}") 
    # puts ("msg.message: #{msg.message}") 
 
    mail = MessageMailer.message_me(msg) 
 
    # puts ("mail.inspect: #{mail.inspect}") 
    # puts ("mail.subject: #{mail.subject}") 
 
    it "renders the header subject" do  
        expect(mail.subject).to eq(msg.subject)  
    end  
 
    it "renders the header to" do  
        expect(mail.to).to eq(["steve_roach@hotmail.com"])  
    end  
 
    it "renders the header from" do  
        expect(mail.from).to eq([msg.email])  
    end  
 
    it "renders the body" do  
      expect(mail.body.encoded).to match(msg.message)  
    end  
  end  
end
