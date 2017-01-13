require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
let(:my_user) { create(:user) }
let(:my_wiki) { create(:wiki, user_id: my_user.id, private: true) }
let(:my_collaborator) { create(:collaborator) }



  before do
    sign_in my_user
    my_user.premium!
  end
  
  describe "POST create" do
    it "increases the number of collaborators by 1" do
      expect{ post :create, wiki_id: my_wiki.id, collaborator: {user: my_user.id}}.to change(Collaborator,:count).by(1)
    end
    
    it "redirects to the wiki show view" do
      post :create, wiki_id: my_wiki.id, collaborator: {user: my_user.id}
      expect(response).to redirect_to(my_wiki)
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the collaborator" do
      delete :destroy, wiki_id: my_wiki.id, id: my_collaborator.id
      count = Collaborator.where({id: my_collaborator.id}).count
      expect(count).to eq 0
    end

    it "redirects to the wiki show view" do
      delete :destroy, wiki_id: my_wiki.id, id: my_collaborator.id
      expect(response).to redirect_to(my_wiki)
    end
  end
end
