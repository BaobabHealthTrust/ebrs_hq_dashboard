require 'couchrest_model'
class Circle < CouchRest::Model::Base

  use_database "circle"

  property :circle, Integer, :default => 0
  property :description, String
  timestamps!

  design do
    view :by__id
    view :by_description
  end

end
