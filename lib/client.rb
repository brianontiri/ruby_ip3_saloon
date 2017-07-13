class Client
    attr_reader(:name, :salon_id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @salon_id = attributes.fetch(:salon_id)
    end

    define_singleton_method(:all) do
      returned_clients = DB.exec("SELECT * FROM clients;")
      clients = []
      returned_clients.each() do |client|
        name = client.fetch("name")
        salon_id = client.fetch("salon_id").to_i() # The information comes out of the database as a string.
        clients.push(Client.new({:name => name, :salon_id => salon_id}))
      end
      clients
    end

    define_method(:save) do
      DB.exec("INSERT INTO clients (name, salon_id) VALUES ('#{@name}', #{@salon_id});")
    end

    def delete
      DB.exec("DELETE FROM clients WHERE salon_id = salon_id");
    end
end
