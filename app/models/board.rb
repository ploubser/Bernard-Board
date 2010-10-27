class Board < ActiveRecord::Base
    cattr_reader :per_page
    @@per_page = 5
end
