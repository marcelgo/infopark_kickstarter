
# Airbrake deployment notification
run "bundle exec rake environment airbrake:deploy TO=#{new_resource.environment['RAILS_ENV']}"