puts "Pulling from HQ"

categories = HQ[Rails.env]["category"].split("|")

category_params = HQ[Rails.env]["remote_http_options"]
district_codes = {}
params = {}
params[:category] = categories
username = category_params["user"]
password = category_params["password"]
host = HQ[Rails.env]["app_uri"]
uri = "http://#{username}:#{password}@#{host}/hq/get_record_status_counts/"
json_text = RestClient.post(uri,params) 
counts = JSON.parse(json_text)
counts.each do |count|

  found = Hq.by_category_and_month_and_year.keys([[count.first.upcase,
  																								 count.second["month"],
  																								 count.second["year"]]])
  if found.blank?
  
    Hq.create(:category => count.first.upcase,
              :month_count => count.second["month_count"],
              :year_count => count.second["year_count"],
              :month => count.second["month"] ,
              :year => count.second["year"])
              
    puts "Created new record"
     
  else
  
    found_again = Hq.by_category_and_month_and_year_and_month_count_and_year_count.keys([[count.first.upcase,
  																								 																	count.second["month"],
  																								 																	count.second["year"],
  																								 																	count.second["month_count"],
  																								 																	count.second["year_count"]]])
    if found_again.blank?
    	found_again.first.update_attributes(:month_count => count.second["month_count"] , :year_count => count.second["year_count"])
    	puts "Updated found record"
    else
      puts "Not updated found record"
    end 																								 																	
  					              
  end
  
end
