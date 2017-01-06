class ChargesController < ApplicationController
  
  after_action :upgrade_account, only: [:create]

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    # Create a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    
    # Where charging magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, #Not user_id in app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to wikis_path(@wikis)
    
    #Stripe will send back CardErrors, with friendly messages
    
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
  
  
  def downgrade_account
    current_user.update!(role: "standard")
    current_user.wikis.update_all(private: false)
    
    flash[:notice] = "Your account has been successfully downgraded to standard."
    redirect_to edit_user_registration_path
  end
  
  private 
  
  def upgrade_account
    current_user.update!(role: "premium")
  end
end
