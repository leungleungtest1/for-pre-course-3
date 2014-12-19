require 'paratrooper'


namespace :deploy do 
  desc 'Doploy app in staging environment'
  task :staging do 
    deployment = Paratrooper::Deploy.new("whispering-atoll-7000", tag: "staging")

    deployment.deploy
  end
  desc 'Deploy app in production environment'
  task :production do
    deployment = Paratrooper::Deploy.new("peaceful-hollows-1925") do |deploy|
      deploy.tag = 'production'
      deploy.match_tag = 'staging'
    end
  
    deployment.deploy
  end
end