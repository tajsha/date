class ContactMailer < ActionMailer::Base
  default :from => "noreply@domain.com"
    default :to => "myemail@email.com"

    def new_contact(contat)
      @message = message
    end

  end