namespace :ebrs do
  desc "ebrs namespace"
  task i!: :environment do
  	require Rails.root.join('db','seeds.rb')
  end

  desc "dc"
  task dc: :environment do
    require Rails.root.join('bin','pull_from_dc.rb')
  end
  
  desc "hq"
  task hq: :environment do
    require Rails.root.join('bin','pull_from_hq.rb')
  end

end
