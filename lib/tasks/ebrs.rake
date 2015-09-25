namespace :ebrs do
  desc "ebrs namespace"
  task i!: :environment do
  	require Rails.root.join('db','seeds.rb')
  end
end
