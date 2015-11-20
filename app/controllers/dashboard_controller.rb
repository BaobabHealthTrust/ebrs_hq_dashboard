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
    end_date = Date.today
    start_date = end_date - 1.month
    type = "weekly"

    data = Statistic.by_date_doc_created.startkey(start_date.strftime("%Y-%m-%d 00:00:00")).endkey(end_date.strftime("%Y-%m-%d 23:59:59"))

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      site_code = row[0]
      district = row[1]

        dt = breakdown(type, site_code, start_date, end_date, data)
        reported = dt.collect{|a, b, c| a}
        registered = dt.collect{|a, b, c| b}
        duration = dt.collect{|a, b, c| c}
        average = duration.sum/registered.sum rescue 0

        results << {
            "district" => district,
            "reported" => reported,
            "registered" => registered,
            "printed" => 250,
            "verified" => 230,
            "re_printed" => 220,
            "incomplete" => 150,
            "supected_duplicates" => 20,
            "amendement_request" => 10,
            "duration"=> average
          }
    end

    render :text => results.to_json
  end

  def map_dashboard
      @url = "http://#{MAP_CONFIG['user']}:#{MAP_CONFIG['password']}@#{MAP_CONFIG['host']}#{MAP_CONFIG['url']}scaling_factor=#{MAP_CONFIG['scaling_factor']}&scroll=#{MAP_CONFIG['scroll']}"
  end

  private

  def breakdown(type, district_code, start_date, end_date,  data)
    result = [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0]]
    (data || []).each do |d|
      next unless d.site_code.upcase.strip == district_code.upcase.strip
      case type
        when "weekly"
          if(d.date_doc_created >= start_date and (d.date_doc_created) <= (start_date + 1.week))
            result[0][0] += 1
            result[0][1] += 1 unless d.date_doc_approved.blank?
            result[0][2] += ((d.date_doc_approved - d.date_doc_created)/60).round unless d.date_doc_approved.blank?
          elsif(d.date_doc_created > start_date + 1.week and (d.date_doc_created) <= (start_date + 2.weeks))
            result[1][0] += 1
            result[1][1] += 1 unless d.date_doc_approved.blank?
            result[1][2] += ((d.date_doc_approved - d.date_doc_created)/60).round unless d.date_doc_approved.blank?
          elsif(d.date_doc_created > start_date + 2.week and (d.date_doc_created) <= (start_date + 3.weeks))
            result[2][0] += 1
            result[2][1] += 1 unless d.date_doc_approved.blank?
            result[2][2] += ((d.date_doc_approved - d.date_doc_created)/60).round unless d.date_doc_approved.blank?
          elsif(d.date_doc_created > start_date + 3.weeks and (d.date_doc_created) <= (start_date + 4.weeks))
            result[3][0] += 1
            result[3][1] += 1 unless d.date_doc_approved.blank?
            result[3][2] += ((d.date_doc_approved - d.date_doc_created)/60).round unless d.date_doc_approved.blank?
          elsif(d.date_doc_created > start_date + 4.weeks and (d.date_doc_created) <= end_date)
            result[4][0] += 1
            result[4][1] += 1 unless d.date_doc_approved.blank?
            result[4][2] += ((d.date_doc_approved - d.date_doc_created)/60).round unless d.date_doc_approved.blank?
          end
      end
    end

    return result
  end
end
