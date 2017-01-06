require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do
let(:my_user) { create(:user) }
let(:wiki) { create(:wikis, user_id: my_user.id) }

  before do
    sign_in my_user
  end
  
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "charging customer" do
    it "creates a customer" do
      customer = Stripe::Customer.create({
        email: my_user.email,
        card: stripe_helper.generate_card_token
      })

      expect(customer.email).to eq(my_user.email)
      expect(customer.card).to be_truthy
    end

    it "creates and has successful charge" do
      customer = Stripe::Customer.create({
        email: my_user.email,
        card: stripe_helper.generate_card_token
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: Amount.default,
        currency: 'usd'
      })

      expect(charge.paid).to eq(true)
    end

    it "rejects a bad card" do
      StripeMock.prepare_card_error(:card_declined)

      customer = Stripe::Customer.create({
        email: my_user.email,
        card: stripe_helper.generate_card_token
      })

      expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
        expect(e).to be_a Stripe::CardError
        expect(e.http_status).to eq(402)
        expect(e.code).to eq('card_declined')
        expect(e.message).to eq("The card was declined")
      }
    end
  end
  
  describe "downgrade_account" do
    before do
      my_user.premium!
      wiki = FactoryGirl.create(:wiki, user_id: my_user.id, private: true) 
    end
    
    it "wikis belonging to user become public when downgrading account" do
      post :downgrade_account
      expect(my_user.wikis.first.private).to be(false) 
    end
  end

  # describe "GET create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
