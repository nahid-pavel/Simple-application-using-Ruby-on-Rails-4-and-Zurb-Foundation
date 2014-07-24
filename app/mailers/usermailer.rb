class Usermailer < ActionMailer::Base
  default from: "from@example.com"
  
  def contact_mail(contact)
    
	@contact = contact
    
	mail(from:@contact.email, to: ENV["OWNER_EMAIL"],:subject => @contact.name)
   
  end
  
end
