require 'couchrest_model'
class Statistic < CouchRest::Model::Base

  use_database "individual_stats"

  property :person_doc_id, String
  property :site_code, String
  property :date_doc_created, Time
  property :date_doc_approved, Time
  timestamps!

  design do
    view :by__id
    view :by_person_doc_id
    view :by_site_code
    view :by_date_doc_created
    view :by_date_doc_approved
    view :by_site_code_and_date_doc_created
    view :by_site_code_and_date_doc_approved
    view :by_registered,
         :map => "function(doc) {
                  if (doc['type'] == 'Statistic') {
                    if(doc['date_doc_approved'] !=null){
                      emit([doc['date_doc_approved']], 1);
                    }
                  }
                }"
  end
end
