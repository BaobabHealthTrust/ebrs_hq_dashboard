require 'couchrest_model'

class Hq < CouchRest::Model::Base
  property :category, String
  property :current_month_count, Integer
  property :current_year_count, Integer
   
  timestamps!
  
  design do
    view :by__id
    view :by_category
    view :current_month_count
    view :current_year_count
  end 
end
