require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki) }
  let(:possible_collaborator) { create(:collaborator) }
  

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
  
  # describe Collaborator do
  #   it "calls available collaborators" do
  #     Collaborator.available(wiki, user)
      
  #   end
  # end
end
