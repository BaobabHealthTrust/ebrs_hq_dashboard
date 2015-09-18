puts "Initialising Districts"

CSV.foreach("#{Rails.root}/app/assets/data/districts_with_codes.csv", :headers => true) do |row|
 next if row[0].blank?
 district = District.find(row[0])
 
 if district.blank?
    district = District.create(district_code: row[0], name: row[1], region: row[2])
    
    if district.present?
       puts district.name + " district initialised succesfully!"
    else
       puts row[1] + " could not be saved!"
    end
    
 else
    puts  row[1] + " district already exists"
 end
        
end

puts "Districts count : #{District.all.count}"
