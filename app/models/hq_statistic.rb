require 'couchrest_model'
class HQStatistic < CouchRest::Model::Base

  use_database "hq_dashboard"

  property :date_doc_created, Time
  property :reported, Interger
  property :printed, Interger
  property :verified, Interger
  property :reprinted, Interger
  property :incomplete, Interger
  property :suspectd_duplicates, Interger
  property :amendements_requests, Interger
  timestamps!

  design do
    view :by__id
    view :by_reported
    view :by_printed
    view :by_verified
    view :by_reprinted
    view :by_incomplete
    view :by_suspectd_duplicates
    view :by_amendements_requests
  end
end

