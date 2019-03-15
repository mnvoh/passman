require "rails_helper"

RSpec.describe PasswordsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/passwords").to route_to("passwords#index")
    end

    it "routes to #new" do
      expect(:get => "/passwords/new").to route_to("passwords#new")
    end

    it "routes to #unlock" do
      expect(:get => "/passwords/1").to route_to("passwords#unlock", :id => "1")
    end

    it "routes to #show" do
      expect(:post => "/passwords/1").to route_to("passwords#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/passwords/1/edit").to route_to("passwords#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/passwords").to route_to("passwords#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/passwords/1").to route_to("passwords#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/passwords/1").to route_to("passwords#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/passwords/1").to route_to("passwords#destroy", :id => "1")
    end
  end
end
