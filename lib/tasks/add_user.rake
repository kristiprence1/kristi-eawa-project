desc 'Add User'
task :add_user  => :environment do
  User.create(name: "admin", surname: "admin", email: "admin@gmail.com", password: "password", role: Role.find_by(name: "admin"))
end