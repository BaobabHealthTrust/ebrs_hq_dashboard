require 'couchrest_model'

class Dc < CouchRest::Model::Base

  property :site_code, String
  property :registered, Integer
  property :approved, Integer
   
  timestamps!
  
  design do
    view :by__id
    view :by_site_code
    view :by_registered
    view :by_approved
  end 
  
end
