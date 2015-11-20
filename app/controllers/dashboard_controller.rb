class DashboardController < ApplicationController
  def index
=begin
     start_date = 3.months.ago.to_date.strftime("%Y-%m-%d")
     end_date =  Date.today.strftime("%Y-%m-%d")
     @dc = Dc.by_date_created_range.startkey(start_date).endkey(end_date).each
     @hq = Hq.all.each
=end


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

  def get_records
    results = []
    data = CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      site_code = row[0]
      district = row[1]

        results << {
            "district" => district,
            "reported" => [80,50, 60,40,79],
            "registered" => [10,30, 13,30,10],
            "printed" => 250,
            "verified" => 230,
            "re_printed" => 220,
            "incomplete" => 150,
            "supected_duplicates" => 20,
            "amendement_request" => 10,
            "duration"=>
            [
              {
                  "report_time"=>"Wed Mar 25 2015 09:56:24",
                  "register_time"=>"Wed Mar 25 2015 10:20:15"
              },
                  {
                  "report_time"=>"Wed Mar 25 2015 10:15:24",
                  "register_time"=>"Wed Mar 25 2015 10:22:15"
              },
                  {
                  "report_time"=>"Wed Mar 25 2015 10:20:24",
                  "register_time"=>"Wed Mar 25 2015 10:29:15"
              },
                  {
                  "report_time"=>"Wed Mar 25 2015 09:56:24",
                  "register_time"=>"Wed Mar 25 2015 10:20:15"
              }
          ]
          }
    end

    render :text => results.to_json
  end

  def map_dashboard
      @url = "http://#{MAP_CONFIG['user']}:#{MAP_CONFIG['password']}@#{MAP_CONFIG['host']}#{MAP_CONFIG['url']}scaling_factor=#{MAP_CONFIG['scaling_factor']}&scroll=#{MAP_CONFIG['scroll']}"
  end

end
