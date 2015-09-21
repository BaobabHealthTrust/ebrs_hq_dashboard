districts = ["bt", "nu", "ll", "cp"]

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
  json_text = RestClient.post(uri,params)
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
