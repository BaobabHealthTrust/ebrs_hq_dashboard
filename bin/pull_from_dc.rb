puts "Pulling from DC"

districts = DC[Rails.env]["districts"].split("|").sort

districts.each do |district|
  district_params = DC[district]["remote_http_options"]
  district_code = {}
  params = {}
  district_code["district_code"] = district.upcase
  params[:district_code] = district_code
  username = district_params["user"]
  password = district_params["password"]
  host = DC[district]["app_uri"]
  uri = "http://#{username}:#{password}@#{host}/dc/get_counts/"
  json_text = RestClient.post(uri,params) rescue next
  counts = JSON.parse(json_text)
  if counts.length == 3
    found = Dc.by_district_code_and_registered_and_approved.keys([[counts["district_code"],
    																															counts["ever_registered"],
    																															counts["ever_approved"]]])
    																															   
    if found.blank?
    
      Dc.create(:district_code => counts["district_code"],
                :registered => counts["ever_registered"],
                :approved => counts["ever_approved"])
                
      puts "Updated"
       
    else
    
      puts "No update"
                   
    end
    
  end
end

puts "Pulling from DC Desktop"

districts = DCDESKTOP[Rails.env]["districts"].split("|").sort

district_params = DCDESKTOP[Rails.env]["remote_http_options"]
district_codes = {}
params = {}
district_codes["district_codes"] = districts.sort
params[:district_codes] = district_codes
username = district_params["user"]
password = district_params["password"]
host = DCDESKTOP[Rails.env]["app_uri"]
uri = "http://#{username}:#{password}@#{host}/dc/get_counts/"
json_text = RestClient.post(uri,params) rescue exit
counts = JSON.parse(json_text)
counts.each do |count|

  found = Dc.by_district_code_and_registered_and_approved.keys([[count.first.upcase,
  																															 count.second["ever_registered"],
  																															 count.second["ever_approved"]]])
  if found.blank?
  
    Dc.create(:district_code => count.first.upcase,
              :registered => count.second["ever_registered"],
              :approved => count.second["ever_approved"])
              
    puts "Updated"
     
  else
  
    puts "No update"
                 
  end
  
end
   
