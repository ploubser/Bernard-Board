module Calendar
    require 'gcal4ruby'

    def calendar(username, password)
        service = GCal4Ruby::Service.new
        service.authenticate(username, password)
        return service.events
    end
end
