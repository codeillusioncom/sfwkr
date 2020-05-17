if Auth::User.count == 0
  puts "Creating admin user..."
  admin = Auth::User.new(email: 'admin@test.com', password: 'adminadmin', password_confirmation: 'adminadmin')
  admin.save!
  admin.add_role(:system)
  admin.confirm
end