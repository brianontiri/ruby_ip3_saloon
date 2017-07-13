class Salon
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_salons = DB.exec("SELECT * FROM salons;")
      salons = []
      returned_salons.each() do |salon|
        name = salon.fetch("name")
        id = salon.fetch("id").to_i()
        salons.push(Salon.new({:name => name, :id => id}))
      end
      salons
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO salons (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_salon|
      self.name().==(another_salon.name()).&(self.id().==(another_salon.id()))
    end

    define_singleton_method(:find) do |id|
      found_salon = nil
      Salon.all().each() do |salon|
        if salon.id().==(id)
          found_salon = salon
        end
      end
      found_salon
    end

    define_method(:clients) do
      salon_clients = []
      clients = DB.exec("SELECT * FROM clients WHERE salon_id = #{self.id()};")
      clients.each() do |client|
        name = client.fetch("name")
        salon_id = client.fetch("salon_id").to_i()
        salon_clients.push(Client.new({:name => name, :salon_id => salon_id}))
      end
      salon_clients
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name)
      @id = self.id()
      DB.exec("UPDATE salons SET name = '#{@name}' WHERE id = #{@id};")
    end

    define_method(:delete) do
      DB.exec("DELETE FROM salons WHERE id = #{self.id()};")
      DB.exec("DELETE FROM clients WHERE salon_id = #{self.id()};")
    end
  end
