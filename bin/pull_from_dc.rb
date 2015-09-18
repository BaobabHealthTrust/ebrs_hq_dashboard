uri = "http://#{dde_master_user}:#{dde_master_password}@#{dde_master_uri}/people/master_people_to_sync/"
ids = RestClient.post(uri,{"site_id" => Site.current_id})
render :text =>  ids.to_json and return
