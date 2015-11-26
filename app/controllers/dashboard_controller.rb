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

    data = Statistic.by_date_doc_created.startkey(start_date.strftime("%Y-%m-%d 00:00:00").to_time).endkey(end_date.strftime("%Y-%m-%d 23:59:59").to_time).each rescue []
    render :text => [].to_json if data.blank?

    total_duration = 0
    total_registered = 0
    total_reported = 0

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      site_code = row[0]
      district = row[1]

      dt = breakdown(type, site_code, start_date, end_date, data)
      reported = dt.collect{|a, b, c| a}
      registered = dt.collect{|a, b, c| b}
      duration = dt.collect{|a, b, c| c}

      total_reported += reported.sum
      total_registered += registered.sum
      total_duration += duration.sum
      average = duration.sum/registered.sum rescue 0

      results << {
          "district" => district,
          "reported" => reported,
          "registered" => registered,
          "duration"=> "#{(average/60).to_i}h #{average % 60}m"
        }
    end
    month = Date.today
    total_average = total_duration/total_registered rescue 0
    avg = "#{(total_average/60).to_i}h #{total_average % 60}m"
    render :text => {"results" => results,
                     "total_registered" => total_reported,
                    "total_approved" => total_registered,
                    "reg_date" => "#{month.strftime('%B %Y')}",
                    "total_duration" => avg, "current_year" => get_data('year'),
                    "current_month" => get_data('monthly'),
                    "pie_chart_data" => get_records_for_pie_chart
                   }.to_json
  end


  def map_dashboard
      @url = "http://#{MAP_CONFIG['user']}:#{MAP_CONFIG['password']}@#{MAP_CONFIG['host']}#{MAP_CONFIG['url']}scaling_factor=#{MAP_CONFIG['scaling_factor']}&scroll=#{MAP_CONFIG['scroll']}"
  end


  private

  def get_records_for_pie_chart
    results = []
    start_date = Date.today.beginning_of_year
    end_date = Date.today

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      site_code = row[0]
      district = row[1]
      reported = Statistic.by_site_code_and_date_doc_created.startkey([site_code,start_date.strftime("%Y-%m-%d 00:00:00").to_time]).endkey([site_code,end_date.strftime("%Y-%m-%d 23:59:59").to_time]).count

      results << { "district" => district, "reported" => reported, "site_code" => site_code }
    end
    
    return results
  end

  def get_data(type)
    if type == 'monthly'
      start_date = Date.today.beginning_of_month
      end_date = start_date.end_of_month
    else
      start_date = Date.today.beginning_of_year
      end_date = start_date.end_of_year
    end

    reported = Statistic.by_date_doc_created.startkey(start_date.strftime("%Y-%m-%d 00:00:00").to_time).endkey(end_date.strftime("%Y-%m-%d 23:59:59").to_time).count
    data = HQStatistic.by_reported_date.startkey(start_date).endkey(end_date).each
    r = {:reported=> reported, :printed=>0, :reprinted=>0, :incompleted=>0, 
         :suspected_duplicates=>0, :amendements_requests=>0, :verified=> 0 }

    (data || []).map do |d|
      r[:printed] += d.printed
      r[:reprinted] += d.reprinted
      r[:incompleted] += d.incomplete
      r[:suspected_duplicates] += d.suspectd_duplicates
      r[:amendements_requests] += d.amendements_requests 
      r[:verified] += d.approved
    end
    return r
  end

  def breakdown(type, district_code, s_date, e_date,  data)
    e_date = e_date.to_time.strftime("%Y-%m-%d 23:59:59").to_time
    s_date = s_date.to_time.strftime("%Y-%m-%d 00:00:00").to_time

    result = [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0]]
    (data || []).each do |d|
      date_doc_created = d.date_doc_created.to_time
      date_doc_approved = d.date_doc_approved.to_time rescue nil

      next unless d.site_code.upcase.strip == district_code.upcase.strip 
      case type
        when "weekly"
          if(date_doc_created >= s_date and (date_doc_created) <= (s_date + 1.week))
            result[0][0] += 1
            result[0][1] += 1 unless date_doc_approved.blank?
            result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif(date_doc_created > s_date + 1.week and (date_doc_created) <= (s_date + 2.weeks))
            result[1][0] += 1
            result[1][1] += 1 unless date_doc_approved.blank?
            result[1][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif(date_doc_created > s_date + 2.week and (date_doc_created) <= (s_date + 3.weeks))
            result[2][0] += 1
            result[2][1] += 1 unless date_doc_approved.blank?
            result[2][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif(date_doc_created > s_date + 3.weeks and (date_doc_created) <= (s_date + 4.weeks))
            result[3][0] += 1
            result[3][1] += 1 unless date_doc_approved.blank?
            result[3][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif(date_doc_created > s_date + 4.weeks and (date_doc_created) <= e_date)
            result[4][0] += 1
            result[4][1] += 1 unless date_doc_approved.blank?
            result[4][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          end
      end
    end
    return result
  end
end
