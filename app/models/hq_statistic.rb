require 'couchrest_model'
class HQStatistic < CouchRest::Model::Base

  use_database "dashboard"

  property :person_doc_id, String
  property :site_code, String
  property :date_doc_created, Time
  property :doc_record_status, Time
  property :doc_request_status, Time
  timestamps!  

  design do
    view :by__id
    view :by_person_doc_id
  end
end
