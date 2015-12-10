namespace :dashboard do
  desc "Rake task to init dashboard cumulative and daily stats"
  task :stats => :environment do
    ebrs_hq_cumulative_stats = SETTINGS[:ebrs_hq_cumulative_stats]
    ebrs_hq_daily_stats = SETTINGS[:ebrs_hq_daily_stats]

    url =  ebrs_hq_cumulative_stats[:protocol]
    url+=  '://' + ebrs_hq_cumulative_stats[:host]
    url+=  ':' + ebrs_hq_cumulative_stats[:port]
    path = ebrs_hq_cumulative_stats[:url]

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      district_codes = row[0]
     `curl -kv #{url}/#{path}/#{district_codes}`
    end

    url =  ebrs_hq_daily_stats[:protocol]
    url+=  '://' + ebrs_hq_daily_stats[:host]
    url+=  ':' + ebrs_hq_daily_stats[:port]
    path = ebrs_hq_daily_stats[:url]

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      district_codes = row[0]
      init_start_date = "2015-08-01".to_date
      end_date = Date.today
      while init_start_date <= end_date
        `curl -kv #{url}/#{path}/#{end_date}/#{district_codes}`
        end_date -= 1.day
      end 
    end

    puts "#{Time.now} - Success!"
  end
  desc "Rake that gets stats to file"
  task :dashboard_files => :environment do
      cycles = [0,1,2,3,4]
      for cycle in cycles
        case cycle
          when 0
          start_date = Date.today - 6.day
          end_date = Date.today
          type = "last 7 days"
          data_file = "weekly.json"
          when 1
            start_date = Date.today.beginning_of_month
            end_date = Date.today.end_of_month
            type = "monthly"
           data_file = "monthly.json"
          when 2
            start_date,end_date = get_quarter_dates(Date.today)
            type = "quarterly"
            data_file = "quarterly.json"
          when 3
            start_date = Date.today - 12.month
            end_date = Date.today
            type = "last 12 months"
            data_file = "last_12_months.json"
          when 4
            start_date = Date.today
            end_date = Date.today
            type = "today"
            data_file = "today.json"
          
        end
      
          results = []
          data = Statistic.by_date_doc_created.startkey(start_date.strftime("%Y-%m-%d 00:00:00").to_time).endkey(end_date.strftime("%Y-%m-%d 23:59:59").to_time).each rescue []
          #render :text => [].to_json if data.blank?

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

          average_dis_hours = (average/60).to_i
          average_dis_mins = average % 60
          
          if average_dis_hours < 24
              average_dis = "#{average_dis_hours}h #{average_dis_mins}m"
          elsif average_dis_hours >= 24
              average_dis = "#{(average_dis_hours/24)}d #{average_dis_hours % 24}h"  
          end


          results << {
              "district" => district,
              "reported" => reported,
              "registered" => registered,
              "duration"=> average_dis
            }
          end
          case type
          when 'today'
            reg_date = "#{start_date.strftime('%d, %b %y')}"
          when 'last 7 days'
            reg_date = "#{start_date.strftime('%d, %b')} <=> #{end_date.strftime('%d, %b')}"
          when 'monthly'
            reg_date = start_date.strftime('%B %Y')
          when 'quarterly'
           case start_date.month
             when 1
               reg_date = "Quarter 1 #{start_date.strftime('%Y')}"
             when 4
               reg_date = "Quarter 2 #{start_date.strftime('%Y')}"
             when 7
               reg_date = "Quarter 3 #{start_date.strftime('%Y')}"
             when 10
               reg_date = "Quarter 4 #{start_date.strftime('%Y')}"
           end
          when 'last 12 months'
            reg_date = "#{start_date.strftime('%d, %b %y')} - #{end_date.strftime('%d, %b %y')}"
        end

        month = Date.today
        total_average = total_duration/total_registered rescue 0
        
        avg_hours = (total_average/60).to_i
        avg_mins  = total_average % 60
        if avg_hours < 24
          avg = "#{avg_hours}h #{avg_mins}m"
        elsif avg_hours >= 24
          avg = "#{(avg_hours/24)}d #{avg_hours % 24}h"  
        end
          output = "{\"results\"=>#{results},\"total_registered\"=> #{total_reported},\"total_approved\" => #{total_registered},\"reg_date\" => \"#{reg_date}\",\"total_duration\" => \"#{avg}\",\"current_year\" => #{get_data('cumulative')},\"current_month\" => #{get_data('monthly')},\"pie_chart_data\" => #{get_records_for_pie_chart},\"Report_freq\" => \"#{type.titleize}\"}"
        newfile = File.new("#{Rails.root}/app/assets/data/#{data_file}", "w+")
        if newfile
            newfile.syswrite(output.to_json)
        else
           puts "Unable to open file!"
        end
        puts "#{data_file} \t #{Time.now}"
    end

  end
end
def breakdown(type, district_code, s_date, e_date,  data)
    e_date = e_date.to_time.strftime("%Y-%m-%d 23:59:59").to_time
    s_date = s_date.to_time.strftime("%Y-%m-%d 00:00:00").to_time

    result = get_results_breakdown(type) # [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0]]
    (data || []).each do |d|
      date_doc_created = d.date_doc_created.to_time
      date_doc_approved = d.date_doc_approved.to_time rescue nil

      next unless d.site_code.upcase.strip == district_code.upcase.strip 
      case type
        when "today"
          result[0][0] += 1
          result[0][1] += 1 unless date_doc_approved.blank?
          result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
        when "last 7 days"
          if date_doc_created.to_date == s_date.to_date
            result[0][0] += 1
            result[0][1] += 1 unless date_doc_approved.blank?
            result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == (s_date + 1.day).to_date 
            result[1][0] += 1
            result[1][1] += 1 unless date_doc_approved.blank?
            result[1][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == (s_date + 2.day).to_date 
            result[2][0] += 1
            result[2][1] += 1 unless date_doc_approved.blank?
            result[2][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == (s_date + 3.day).to_date 
            result[3][0] += 1
            result[3][1] += 1 unless date_doc_approved.blank?
            result[3][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == (s_date + 4.day).to_date
            result[4][0] += 1
            result[4][1] += 1 unless date_doc_approved.blank?
            result[4][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == (s_date + 5.day).to_date 
            result[5][0] += 1
            result[5][1] += 1 unless date_doc_approved.blank?
            result[5][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date == e_date.to_date
            result[6][0] += 1
            result[6][1] += 1 unless date_doc_approved.blank?
            result[6][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          end
        when "monthly"
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
        when "quarterly"
          if date_doc_created.to_date >= s_date.to_date and date_doc_created.to_date <= ((s_date + 1.month) - 1.day).to_date
            result[0][0] += 1
            result[0][1] += 1 unless date_doc_approved.blank?
            result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= (s_date + 1.month).to_date and date_doc_created.to_date <= ((s_date + 2.month) - 1.day).to_date
            result[1][0] += 1
            result[1][1] += 1 unless date_doc_approved.blank?
            result[1][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= (s_date + 2.month).to_date and date_doc_created.to_date <= ((s_date + 3.month) - 1.day).to_date
            result[2][0] += 1
            result[2][1] += 1 unless date_doc_approved.blank?
            result[2][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          end
        when "last 12 months"
          if date_doc_created.month == 1
            result[0][0] += 1
            result[0][1] += 1 unless date_doc_approved.blank?
            result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 2
            result[1][0] += 1
            result[1][1] += 1 unless date_doc_approved.blank?
            result[1][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 3
            result[2][0] += 1
            result[2][1] += 1 unless date_doc_approved.blank?
            result[2][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 4
            result[3][0] += 1
            result[3][1] += 1 unless date_doc_approved.blank?
            result[3][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 5
            result[4][0] += 1
            result[4][1] += 1 unless date_doc_approved.blank?
            result[4][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 6
            result[5][0] += 1
            result[5][1] += 1 unless date_doc_approved.blank?
            result[5][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 7
            result[6][0] += 1
            result[6][1] += 1 unless date_doc_approved.blank?
            result[6][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 8
            result[7][0] += 1
            result[7][1] += 1 unless date_doc_approved.blank?
            result[7][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 9
            result[8][0] += 1
            result[8][1] += 1 unless date_doc_approved.blank?
            result[8][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 10
            result[9][0] += 1
            result[9][1] += 1 unless date_doc_approved.blank?
            result[9][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 11
            result[10][0] += 1
            result[10][1] += 1 unless date_doc_approved.blank?
            result[10][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.month == 12
            result[11][0] += 1
            result[11][1] += 1 unless date_doc_approved.blank?
            result[11][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          end
      end
    end
    return result
  end
  
  def get_quarter_dates(date)
    if date.month >= 1 and date.month <= 3
      return [date.beginning_of_year, (date.beginning_of_year + 3.month - 1.day)]
    elsif date.month > 3 and date.month <= 6
      return [date.beginning_of_year + 3.month, (date.beginning_of_year + 6.month - 1.day)]
    elsif date.month > 6 and date.month <= 9
      return [date.beginning_of_year + 6.month, (date.beginning_of_year + 9.month - 1.day)]
    elsif date.month > 9 
      return [date.beginning_of_year + 9.month, (date.beginning_of_year + 12.month - 1.day)]
    end
  end

  def get_dates(type)
    date = Date.today
    if type == "last 7 days"
      return [(date - 6.day), date]
    elsif type == "monthly"
      return [date.beginning_of_month, date.end_of_month]
    elsif type == "quarterly"
      return get_quarter_dates(date)
    elsif type == "last 12 months"
      return [date.beginning_of_year, date.end_of_year]
    elsif type == "today"
      return [date, date]
    elsif type == "cumulative"
      return ['2015-01-01'.to_date, date]
    end
  end

  def get_results_breakdown(type)
    case type
      when 'last 7 days'
        result = [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0],[0,0,0],[0,0,0]]
      when 'monthly'
        result = [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0]]
      when 'quarterly'
        result = [[0,0, 0], [0,0, 0], [0,0, 0]]
      when 'last 12 months'
        result = [[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0],[0,0, 0], [0,0, 0], [0,0, 0],[0,0, 0],[0, 0, 0],[0,0,0],[0,0,0]]
      when 'today'
        result = [[0,0, 0]]
    end
    return result
  end
 def get_data(type)
    start_date, end_date = get_dates(type)

    reported = Statistic.by_date_doc_created.startkey(start_date.strftime("%Y-%m-%d 00:00:00").to_time).endkey(end_date.strftime("%Y-%m-%d 23:59:59").to_time).count
    data = HQStatistic.by_reported_date.startkey(start_date).endkey(end_date).each
    r = {"reported"=> reported, "printed"=>0, "reprinted"=>0, "incompleted"=>0, 
         "suspected_duplicates"=>0, "amendements_requests"=>0, "verified"=> 0 }

    (data || []).map do |d|
      r["printed"] += d.printed
      r["reprinted"] += d.reprinted
      r["incompleted"] += d.incomplete
      r["suspected_duplicates"] += d.suspectd_duplicates
      r["amendements_requests"] += d.amendements_requests 
      r["verified"] += d.approved
    end
    return r
  end
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
