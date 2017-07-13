require('capybara/rspec')
  require('./app')
  Capybara.app = Sinatra::Application
  set(:show_exceptions, false)

  describe('adding a new salon', {:type => :feature}) do
    it('allows a user to click a salon to see the clients and details for it') do
      visit('/salons/new')
      # click_button('Add New Salon')
      fill_in('name', :with =>'Adrian Cole')
      click_button('Add')
      expect(page).to have_content('Success!')
    end
  end

  describe('viewing all of the salons', {:type => :feature}) do
    it('allows a user to see all of the salons that have been created') do
      salon = Salon.new({:name => 'Dan Nathan', :id => nil})
      salon.save()
      visit('/')
      click_link('Salonists')
      expect(page).to have_content(salon.name)
    end
  end

  describe('seeing details for a single salon', {:type => :feature}) do
    it('allows a user to click a salon to see the clients and details for it') do
      test_salon = Salon.new({:name => 'Jane Njoki', :id => nil})
      test_salon.save()
      test_client = Client.new({:description => "Mary Kimani", :salon_id => test_salon.id()})
      test_client.save()
      visit('/salons')
      click_link(test_salon.name())
      expect(page).to have_content(test_client.description())
    end
  end

  describe('adding clients to a salon', {:type => :feature}) do
    it('allows a user to add a client to a salon') do
      test_salon = Salon.new({:name => 'Jane Njoki', :id => nil})
      test_salon.save()
      visit("/add")
      fill_in("Client", {:with => "Kimani Njoki"})
      click_button("Add Client")
      expect(page).to have_content("Success!")
    end
  end