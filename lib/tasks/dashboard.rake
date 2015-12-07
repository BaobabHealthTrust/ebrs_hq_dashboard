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
end

