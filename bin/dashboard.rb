ebrs_hq_cumulative_stats = SETTINGS[:ebrs_hq_cumulative_stats]
ebrs_hq_daily_stats = SETTINGS[:ebrs_hq_daily_stats]

url =  ebrs_hq_cumulative_stats[:protocol]
url+=  '://' + ebrs_hq_cumulative_stats[:host]
url+=  ':' + ebrs_hq_cumulative_stats[:port]
path = ebrs_hq_cumulative_stats[:url]

District.all.each do |district|
  district_code = district.id
 `curl -k #{url}/#{path}/#{district_code}`
end

url =  ebrs_hq_daily_stats[:protocol]
url+=  '://' + ebrs_hq_daily_stats[:host]
url+=  ':' + ebrs_hq_daily_stats[:port]
path = ebrs_hq_daily_stats[:url]

District.all.each do |district|
  district_code = district.id
  init_start_date = "2015-08-01".to_date
  end_date = Date.today
  while init_start_date <= end_date
    `curl -k #{url}/#{path}/#{end_date}/#{district_code}`
    end_date -= 1.day
  end 
end

puts "#{Time.now} - Success!"


