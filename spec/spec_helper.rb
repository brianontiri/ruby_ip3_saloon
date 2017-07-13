require("rspec")
  require("pg")
  require("salon")
  require('client')

  DB = PG.connect({:dbname => "saloon_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM salons *;")
      DB.exec("DELETE FROM clients *;")
    end
  end
