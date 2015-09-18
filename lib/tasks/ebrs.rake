namespace :ebrs do
  desc "ebrs namespace"
  task i!: :environment do
  	require Rails.root.join('db','seeds.rb')
  end

  desc "TODO"
  task dc: :environment do
  end

  desc "TODO"
  task hq: :environment do
  end

end
