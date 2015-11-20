require 'couchrest_model'
class Statistic < CouchRest::Model::Base

  use_database "dashboard"

  property :person_doc_id, String
  property :site_code, String
  property :date_doc_created, Time
  property :date_doc_approved, Time
  property :created_at, Time
  property :updated_at, Time
  timestamps!

  design do
    view :by__id
    view :by_person_doc_id
    view :by_site_code
    view :by_date_doc_created
    view :by_date_doc_approved
    view :by_site_code_and_date_doc_approved
  end
end
