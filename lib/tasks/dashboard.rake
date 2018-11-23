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

=begin      hash = {}
      s_date = "01/01/#{(Date.today - 12.months).year}".to_date
      e_date = "31/12/#{Date.today.year}".to_date

      while (s_date < e_date)
        hash[s_date.month] = [s_date.beginning_of_month, s_date.end_of_month]
        s_date += 1.month
      end
=end
      districts = {}
      ActiveRecord::Base.connection.select_all("
          SELECT l.location_id, l.name FROM location l
          INNER JOIN location_tag_map m ON l.location_id = m.location_id
          INNER JOIN location_tag t ON t.location_tag_id = m.location_tag_id AND t.name = 'District'
      ").each{|l| districts[l['name']] = l['location_id'].to_i}

      facility_tag_id = ActiveRecord::Base.connection.select_all("
          SELECT location_tag_id FROM location_tag WHERE name = 'Health Facility'
      ")[0]['location_tag_id'].to_i

      cycles = [0,1,2,3,4]
      for cycle in cycles
        case cycle
          when 0
            start_date = Date.today.beginning_of_day
            end_date = Date.today.end_of_day
            type = "today"
            data_file = "today.json"
          when 1
            start_date = (Date.today - 6.days).beginning_of_day
            end_date = Date.today.end_of_day
            type = "last 7 days"
            data_file = "weekly.json"
          when 2
            start_date = Date.today.beginning_of_month
            end_date = Date.today.end_of_month
            type = "monthly"
           data_file = "monthly.json"
          when 3
            start_date = Date.today.beginning_of_quarter
            end_date = Date.today.end_of_quarter
            type = "quarterly"
            data_file = "quarterly.json"
          when 4
            start_date = Date.today.beginning_of_year
            end_date = Date.today.end_of_year
            type = "last 12 months"
            data_file = "last_12_months.json"
          end

          results = []

          total_duration = 0
          total_registered = 0
          total_reported = 0


          CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
            site_code = row[0]
            district = row[1]

            district_id = districts[district]
            locations = [district_id]
            (reported = ActiveRecord::Base.connection.select_all("SELECT l.location_id FROM location l
                            INNER JOIN location_tag_map m ON l.location_id = m.location_id AND m.location_tag_id = #{facility_tag_id}
                          WHERE l.parent_location = #{district_id} ") || []).each {|l|
              locations << l['location_id']
            }

            #break_down = date_margins(start_date, end_date)

            reported = ActiveRecord::Base.connection.select_all("
              SELECT COUNT(*) AS total FROM person_birth_details pbd
                INNER JOIN person_record_statuses prs ON prs.person_id = pbd.person_id AND prs.voided = 0
                WHERE prs.created_at BETWEEN '#{start_date.to_s(:db)}' AND '#{end_date.to_s(:db)}'
                  AND pbd.location_created_at IN (#{locations.join(', ')})
              ")[0]['total'].to_i

            registered =  ActiveRecord::Base.connection.select_all("
              SELECT COUNT(*) AS total FROM person_birth_details pbd
                WHERE pbd.district_id_number IS NOT NULL
                  AND pbd.date_registered BETWEEN '#{start_date.to_s(:db)}' AND '#{end_date.to_s(:db)}'
                  AND pbd.location_created_at IN (#{locations.join(', ')})
              ")[0]['total'].to_i

            puts "Registered # #{registered}, Reported # #{reported}"

            average = ActiveRecord::Base.connection.select_all(
                "SELECT AVG(TIMESTAMPDIFF(MINUTE, pbd.date_reported, pbd.date_registered)) AS time
                 FROM person_birth_details pbd
                  WHERE pbd.date_registered BETWEEN '#{start_date.to_s(:db)}' AND '#{end_date.to_s(:db)}'
                    AND pbd.location_created_at IN (#{locations.join(', ')});")[0]['time'].to_i

            average_dis_mins = average
            average_dis_hours = (average/60).to_i
            average_dis_days = (average/(60*24)).to_i

            if average_dis_hours < 24
              average_dis = "#{average_dis_hours}h #{average_dis_mins % 60}m"
            elsif average_dis_days >= 30
              average_dis = "#{average_dis_days/30}mn #{(average_dis_days % 30)}d #{average_dis_hours % 60}h"
            elsif average_dis_hours >= 24
              average_dis = "#{(average_dis_hours/24)}d #{average_dis_hours % 24}h"
            end

            results << {
                "district" => district,
                "reported" => reported,
                "registered" => registered,
                "time" => average,
                "duration"=> average_dis
            }
          end

      total_reported = results.collect{|a| a['reported'] }.sum
      total_registered = results.collect{|a| a['registered'] }.sum
      total_duration = results.collect{|a| a['time'] }.sum

      average_by_query = ActiveRecord::Base.connection.select_all(
          "SELECT AVG(TIMESTAMPDIFF(MINUTE, pbd.date_reported, pbd.date_registered)) AS time
                 FROM person_birth_details pbd
                  WHERE pbd.date_registered BETWEEN '#{start_date.to_s(:db)}' AND '#{end_date.to_s(:db)}' ")[0]['time'].to_i

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

      total_average = average_by_query
      avg_hours = (total_average/60).to_i
      avg_mins  = total_average
      avg_days =  (total_average/(60*24))
      if avg_hours < 24
        avg = "#{avg_hours}h #{avg_mins % 60}m"
      elsif avg_days >= 30
        avg = "#{(avg_days/30)}mn  #{avg_days % 30}d #{avg_hours % 24}h"
      elsif avg_hours >= 24
        avg = "#{avg_days % 30}d #{avg_hours % 60}"
      end

      output = {
          "results"          => results,
          "total_registered" => total_reported,
          "total_approved"   => total_registered,
          "reg_date"         => reg_date,
          "total_duration"   => avg,
          "current_year"     => get_data("cumulative"),
          "current_month"    => get_data("monthly"),
          "pie_chart_data"   => get_records_for_pie_chart(districts, facility_tag_id),
          "Report_freq"      => type.titleize
      }

      puts "Writing to file"

      File.open("#{Rails.root}/app/assets/data/#{data_file}" , "w"){|f|
        f.write(output.to_json)
      }
  end
  end
end

def date_margins(start_date, end_date)
  months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  quarters = months.in_groups_of(3)

  range = []
  while start_date <= end_date

    m = start_date.month
    quarters.each{|a|
      range << a if a.include?(m)
    }

    start_date += 3.months

  end

  range = range.uniq.compact
  range
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
          month_break_down = get_month_break_down
          if date_doc_created.to_date >= month_break_down[0][0] and date_doc_created.to_date <= month_break_down[0][1]
            result[0][0] += 1
            result[0][1] += 1 unless date_doc_approved.blank?
            result[0][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[1][0] and date_doc_created.to_date <= month_break_down[1][1]
            result[1][0] += 1
            result[1][1] += 1 unless date_doc_approved.blank?
            result[1][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[2][0] and date_doc_created.to_date <= month_break_down[2][1]
            result[2][0] += 1
            result[2][1] += 1 unless date_doc_approved.blank?
            result[2][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[3][0] and date_doc_created.to_date <= month_break_down[3][1]
            result[3][0] += 1
            result[3][1] += 1 unless date_doc_approved.blank?
            result[3][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[4][0] and date_doc_created.to_date <= month_break_down[4][1]
            result[4][0] += 1
            result[4][1] += 1 unless date_doc_approved.blank?
            result[4][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[5][0] and date_doc_created.to_date <= month_break_down[5][1]
            result[5][0] += 1
            result[5][1] += 1 unless date_doc_approved.blank?
            result[5][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[6][0] and date_doc_created.to_date <= month_break_down[6][1]
            result[6][0] += 1
            result[6][1] += 1 unless date_doc_approved.blank?
            result[6][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[7][0] and date_doc_created.to_date <= month_break_down[7][1]
            result[7][0] += 1
            result[7][1] += 1 unless date_doc_approved.blank?
            result[7][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[8][0] and date_doc_created.to_date <= month_break_down[8][1]
            result[8][0] += 1
            result[8][1] += 1 unless date_doc_approved.blank?
            result[8][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[9][0] and date_doc_created.to_date <= month_break_down[9][1]
            result[9][0] += 1
            result[9][1] += 1 unless date_doc_approved.blank?
            result[9][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[10][0] and date_doc_created.to_date <= month_break_down[10][1]
            result[10][0] += 1
            result[10][1] += 1 unless date_doc_approved.blank?
            result[10][2] += ((date_doc_approved - date_doc_created)/60).round unless date_doc_approved.blank?
          elsif date_doc_created.to_date >= month_break_down[11][0] and date_doc_created.to_date <= month_break_down[11][1]
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
      return [date - 12.months, date]
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

  def had_state(start_date, end_date, states)
    states = "'" + states.join("', '") + "'"
    status_ids = ActiveRecord::Base.connection.select_all("
      SELECT status_id FROM statuses WHERE name IN (#{states})
    ").collect{|s| s['status_id'].to_i}

    total = ActiveRecord::Base.connection.select_all("
      SELECT COUNT(DISTINCT(person_id)) total FROM person_record_statuses prs
        WHERE prs.status_id IN (#{status_ids.join(", ")})
          AND prs.created_at BETWEEN '#{start_date}' AND '#{end_date}'
    ")[0]['total']

    total
  end

  def has_state(start_date, end_date, states)
    states = "'" + states.join("', '") + "'"
    status_ids = ActiveRecord::Base.connection.select_all("
        SELECT status_id FROM statuses WHERE name IN (#{states})
      ").collect{|s| s['status_id'].to_i}

    total = ActiveRecord::Base.connection.select_all("
        SELECT COUNT(DISTINCT(person_id)) total FROM person_record_statuses prs
          WHERE prs.voided = 0 AND prs.status_id IN (#{status_ids.join(", ")})
            AND prs.created_at BETWEEN '#{start_date}' AND '#{end_date}'
      ")[0]['total']

    total
  end

  def get_data(type)
    start_date, end_date = get_dates(type)
    r = {}

    r["reported"] = ActiveRecord::Base.connection.select_all("
        SELECT COUNT(*) AS total FROM person_birth_details
        WHERE date_reported IS NOT NULL AND date_reported BETWEEN '#{start_date}' AND '#{end_date}'
      ")[0]['total'].to_i

    r["registered"] = ActiveRecord::Base.connection.select_all("
        SELECT COUNT(*) AS total FROM person_birth_details
        WHERE date_registered IS NOT NULL AND date_registered BETWEEN '#{start_date}' AND '#{end_date}'
      ")[0]['total'].to_i

    r["printed"] = had_state(start_date, end_date, ["HQ-PRINTED", "HQ-DISPATCHED", "HQ-AMEND", "HQ-AMEND-REJECTED", "HQ-AMEND-GRANTED", "HQ-AMEND-REJECTED-TBA", " HQ-CAN-REPRINT-AMEND"])
    r["reprinted"] = had_state(start_date, end_date, ["HQ-RE-PRINT", "HQ-CAN-RE-PRINT", " HQ-CAN-REPRINT-AMEND"])
    r["incompleted"] = had_state(start_date, end_date, ["HQ-INCOMPLETE", "HQ-INCOMPLETE-TBA"])
    r["suspected_duplicates"] = had_state(start_date, end_date, ["HQ-POTENTIAL DUPLICATE", "HQ-POTENTIAL DUPLICATE-TBA", "HQ-CONFLICT-DUPLICATE", "HQ-DUPLICATE", "HQ-VOIDED DUPLICATE",
                                          "HQ-EXACT DUPLICATE", "HQ-NOT DUPLICATE-TBA", "HQ-NOT DUPLICATE"])
    r["amendements_requests"] = had_state(start_date, end_date, ["HQ-AMEND", "HQ-AMEND-REJECTED", "HQ-AMEND-GRANTED", "HQ-AMEND-REJECTED-TBA", " HQ-CAN-REPRINT-AMEND"])
    r["verified"] = had_state(start_date, end_date, ["HQ-COMPLETE", "HQ-PRINTED", "HQ-DISPATCHED", "HQ-RE-PRINT", "HQ-CAN-RE-PRINT", " HQ-CAN-REPRINT-AMEND",
                              "HQ-AMEND", "HQ-AMEND-REJECTED", "HQ-AMEND-GRANTED", "HQ-AMEND-REJECTED-TBA", " HQ-CAN-REPRINT-AMEND"])

    r
  end
  
  def get_records_for_pie_chart(districts, facility_tag_id)
    results = []
    start_date = Date.today.beginning_of_year
    end_date = Date.today.end_of_day

    CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
      site_code = row[0]
      district = row[1]

      district_id = districts[district]
      locations = [district_id]
      (reported = ActiveRecord::Base.connection.select_all("SELECT l.location_id FROM location l
                            INNER JOIN location_tag_map m ON l.location_id = m.location_id AND m.location_tag_id = #{facility_tag_id}
                          WHERE l.parent_location = #{district_id} ") || []).each {|l|
        locations << l['location_id']
      }

      reported = ActiveRecord::Base.connection.select_all("
              SELECT COUNT(*) AS total FROM person_birth_details pbd
                WHERE pbd.date_reported BETWEEN '#{start_date.to_s(:db)}' AND '#{end_date.to_s(:db)}'
                  AND pbd.location_created_at IN (#{locations.join(', ')})
              ")[0]['total'].to_i

      results << { "district" => district, "reported" => reported, "site_code" => site_code }
    end
    
    results
  end

  def get_month_break_down
    end_date = Date.today ; col_months = [] 
    11.downto(1).each do |m|
      curr_month = end_date - m.month
      col_months << [curr_month.beginning_of_month, curr_month.end_of_month]
    end
    return col_months << [end_date.beginning_of_month, end_date.end_of_month] 
  end
