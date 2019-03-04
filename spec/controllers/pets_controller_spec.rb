require 'spec_helper'

describe "Pets Controller" do
  describe "new action" do

    it "can visit '/pets/new'" do
      get '/pets/new'
      expect(last_response.status).to eq(200)
    end

    it " loads form to create a new pet" do
      visit '/pets/new'
      expect(page).to have_field('pet_name')
    end


    it "has a field for creating a new owner" do
      visit '/pets/new'
      expect(page).to have_field(:owner_name)
    end

    it "redirects to '/pets/:id' after form submissions" do
      @owner1 = Owner.create(:name => "Kristi")
      @owner2 = Owner.create(:name => "Kaitlin")
      visit '/pets/new'
      fill_in "pet_name", :with => "Joeseph"
      check(@owner2.id)
      click_button "Create Pet"
      @pet= Pet.last
      expect(page.current_path).to eq("/pets/#{@pet.id}")
    end
  end

  describe "edit action" do
    before(:each) do
      @owner = Owner.create(:name => "Carla")
      @pet = Pet.create(:name => "Chewie", :owner_id => @owner.id)
    end

    it "can visit '/owners/:id/edit' " do
      get "/owners/#{@owner.id}/edit"
      expect(last_response.status).to eq(200)
    end

    it " loads form to edit a pet and his owner" do
      visit "/pets/#{@pet.id}/edit"
      expect(page).to have_field('pet_name')
      expect(page.has_checked_field?(@owner.id)).to eq(true)
      expect(page).to have_field('owner[name]')
    end


  end

end
