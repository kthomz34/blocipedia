require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { create(:wiki) }
  let(:user) { create(:user) }
  
  it { is_expected.to belong_to(:user) }
  
  describe "attributes" do
    it "has title, body attributes and user attribute" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: wiki.user)
    end
  end
end
