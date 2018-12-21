require "rails_helper"

RSpec.describe SecureNotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/secure_notes").to route_to("secure_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/secure_notes/new").to route_to("secure_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/secure_notes/1").to route_to("secure_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/secure_notes/1/edit").to route_to("secure_notes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/secure_notes").to route_to("secure_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/secure_notes/1").to route_to("secure_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/secure_notes/1").to route_to("secure_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/secure_notes/1").to route_to("secure_notes#destroy", :id => "1")
    end
  end
end
