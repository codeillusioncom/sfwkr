rm -f /app/tmp/pids/server.pid
bundle
rails db:migrate
rails db:seed
rails s -b 0.0.0.0
