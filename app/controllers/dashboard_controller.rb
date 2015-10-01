class DashboardController < ApplicationController
  def index
     start_date = 3.months.ago.to_date.strftime("%Y-%m-%d")
     end_date =  Date.today.strftime("%Y-%m-%d")
     @dc = Dc.by_date_created_range.startkey(start_date).endkey(end_date).each
     @hq = Hq.all.each
  end

  def map_dashboard
      @url = "http://#{MAP_CONFIG['user']}:#{MAP_CONFIG['password']}@#{MAP_CONFIG['host']}#{MAP_CONFIG['url']}scaling_factor=#{MAP_CONFIG['scaling_factor']}&scroll=#{MAP_CONFIG['scroll']}"
  end

end
