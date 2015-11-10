class DashboardController < ApplicationController
  def index
     start_date = 3.months.ago.to_date.strftime("%Y-%m-%d")
     end_date =  Date.today.strftime("%Y-%m-%d")
     @dc = Dc.by_date_created_range.startkey(start_date).endkey(end_date).each
     @hq = Hq.all.each
  end
  
  def get_data
  
  file_name = Rails.root.join('docs', 'statistics.txt')
  file = YAML.load_file(file_name)
  scores = {}

  (file || []).each do |district, statistics|
    scores[district]= {}
    (statistics || []).each do |type, statistic|
      scores[district][type] = statistic
    end
  end

  render :text => scores.to_json
     
  end
  def map_dashboard
      @url = "http://#{MAP_CONFIG['user']}:#{MAP_CONFIG['password']}@#{MAP_CONFIG['host']}#{MAP_CONFIG['url']}scaling_factor=#{MAP_CONFIG['scaling_factor']}&scroll=#{MAP_CONFIG['scroll']}"
  end

end
