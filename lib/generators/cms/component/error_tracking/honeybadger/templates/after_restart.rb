
# Honeybadger deployment notification
repository = %x(git config --get remote.origin.url).strip
user = %x(whoami).strip
revision = %x(git rev-parse HEAD).strip
run "bundle exec rake honeybadger:deploy REPO=#{repository} TO=#{new_resource.environment['RAILS_ENV']} USER=#{user} REVISION=#{revision}"