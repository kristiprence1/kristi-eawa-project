desc 'Add Role'
task :add_role  => :environment do
  Role.find_or_create_by(name: "admin")
  Role.find_or_create_by(name: "user")
end