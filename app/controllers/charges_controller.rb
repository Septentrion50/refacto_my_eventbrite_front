class ChargesController < ApplicationController
  def new
    @user = current_user
    @event = Event.where(:id == params[:id])[0]
    @amount = @event.price.to_i
  end

  def create
    # Amount in cents
    @user = current_user
    @event = Event.where(:id == params[:id])[0]
    @amount = @event.price.to_i * 100

  begin
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  end
end
