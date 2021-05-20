class ChargesController < ApplicationController
  def new
    @user = current_user
    @event = Event.where(:id == params[:id])[0]
    @amount = @event.price.to_i
  end

  def create
    # Amount in cents
    @user = current_user
    @event = Event.find(params[:event_id])
    @amount = @event.price

  begin
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount * 100,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    @attendance = Attendance.new(
      stripe_customer_id: charge.customer,
      user: @user,
      event: @event
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  if @attendance.save
    redirect_to event_path(params[:event_id]), notice: "Réservation enregistrée !"
  else
    flash.now[:alert] = "Problème lors de l'enregistrement"
    render :new
  end
  end
end
