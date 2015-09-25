class DashboardController < ApplicationController
  def index
     start_date = 3.months.ago.to_date.strftime("%Y-%m-%d")
     end_date =  Date.today.strftime("%Y-%m-%d")
     @dc = Dc.by_date_created_range.startkey(start_date).endkey(endkey).each
     @hq = Hq.all.each
  end
end
