class UserMailer < ApplicationMailer
  default from: 'robert.michalon@yopmail.com'

  def welcome_email(user)
    @user = user
    @url = 'http://my-enventbrite.com'
    mail(to: @user.email, subject: "Bienvenue sur cette contrefaçon Hong Kongaise d'eventbrite !")
  end

  def event_inscription_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Voici votre réservation !")
  end
end
