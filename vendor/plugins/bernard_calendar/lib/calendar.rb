module Calendar
    require 'gcal4ruby'

    def calendar(username, password)

        begin
            service = GCal4Ruby::Service.new
            service.authenticate(username, password)
            return service.events
        rescue Exception => e
            return "error"
        end
    end
end
