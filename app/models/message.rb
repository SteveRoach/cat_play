class Message   
  include ActiveModel::Model  
 
  attr_accessor :name, :email, :subject, :message   
 
  validates :name,  
      presence: { message: "can't be blank" },  
      length: { maximum: 50, too_long: "%{count} characters is the maximum allowed" }   
 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i   
 
  validates :email,  
      presence: { message: "can't be blank" },  
      length: { maximum: 255, too_long: "%{count} characters is the maximum allowed" },  
      format: { with: VALID_EMAIL_REGEX, message: "format is invalid" }   
    
  validates :subject,  
      presence: { message: "can't be blank" },  
      length: { maximum: 100, too_long: "%{count} characters is the maximum allowed" }   
  validates :message,  
      presence: { message: "can't be blank" }   
end  
