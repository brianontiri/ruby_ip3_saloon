require('rspec')
  require('pg')
  require('spec_helper')

  describe(Client) do
    describe(".all") do
      it("is empty at first") do
        expect(Client.all()).to(eq([]))
      end
    end

    describe("#save") do
      it("adds a client to the array of saved clients") do
        test_client = Client.new({:description => "learn SQL", :salon_id => 1})
        test_client.save()
        expect(Client.all()).==([test_client])
      end
    end

    describe("#description") do
      it("lets you read the description out") do
        test_client = Client.new({:description => "learn SQL", :salon_id => 1})
        expect(test_client.description()).==("learn SQL")
      end
    end

    describe("#salon_id") do
      it("lets you read the salon ID out") do
        test_client = Client.new({:description => "learn SQL", :salon_id => 1})
        expect(test_client.salon_id()).==(1)
      end
    end

    describe("#==") do
      it("is the same client if it has the same description and salon ID") do
        client1 = Client.new({:description => "learn SQL", :salon_id => 1})
        client2 = Client.new({:description => "learn SQL", :salon_id => 1})
        expect(client1).==(client2)
      end
    end
  end

  describe(".find") do
      it("returns a salon by its ID") do
        test_salon = Salon.new({:name => "Moringaschool stuff", :id => nil})
        test_salon.save()
        test_salon2 = Salon.new({:name => "Home stuff", :id => nil})
        test_salon2.save()
        expect(Salon.find(test_salon2.id())).to(eq(test_salon2))
      end
    end

    describe("#clients") do
      it("returns an array of clients for that salon") do
        test_salon = Salon.new({:name => "Moringaschool stuff", :id => nil})
        test_salon.save()
        test_client = Client.new({:description => "Learn SQL", :salon_id => test_salon.id()})
        test_client.save()
        test_client2 = Client.new({:description => "Review Ruby", :salon_id => test_salon.id()})
        test_client2.save()
        expect(test_salon.clients()).==([test_client, test_client2])
      end
    end

    describe("#update") do
      it("lets you update salons in the database") do
        salon = Salon.new({:name => "Moringa School stuff", :id => nil})
        salon.save()
        salon.update({:name => "Homework stuff"})
        expect(salon.name()).to(eq("Homework stuff"))
      end
    end

    describe("#delete") do
      it("lets you delete a salon from the database") do
        salon = Salon.new({:name => "Moringa School stuff", :id => nil})
        salon.save()
        salon2 = Salon.new({:name => "House stuff", :id => nil})
        salon2.save()
        salon.delete()
        expect(Salon.all()).to(eq([salon2]))
      end
      
      it("deletes a salon's clients from the database") do
        salon = Salon.new({:name => "Moringa School stuff", :id => nil})
        salon.save()
        client = Client.new({:description => "learn SQL", :salon_id => salon.id()})
        client.save()
        client2 = Client.new({:description => "Review Ruby", :salon_id => salon.id()})
        client2.save()
        salon.delete()
        expect(Client.all()).to(eq([]))
      end
    end