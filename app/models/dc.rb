require 'couchrest_model'

class Dc < CouchRest::Model::Base

  property :district_code, String
  property :registered, Integer
  property :approved, Integer
   
  timestamps!
  
  design do
    view :by__id
    view :by_district_code
    view :by_registered
    view :by_approved
  end 
  
end
