class DashboardController < ApplicationController
    def index
    @data = {
        "2020-01-01" => 5,
        "2020-02-01" => 10,
        "2020-03-01" => 7,
        "2020-04-01" => 15
      }
      
    end
end


