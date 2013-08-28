
# Airbrake deployment notification
run "bundle exec rake environment airbrake:deploy TO=#{new_resource.environment['RAILS_ENV']}"
# Honeybadger deployment notification
repository = %x(git config --get remote.origin.url).strip
user = %x(whoami).strip
revision = %x(git rev-parse HEAD).strip
run "bundle exec rake honeybadger:deploy REPO=#{repository} TO=#{new_resource.environment['RAILS_ENV']} USER=#{user} REVISION=#{revision}"user = %x(whoami).strip
revision = %x(git rev-parse HEAD).strip
newrelic_deploy_key = node['custom_cloud']['newrelic']['deploy_key']

newrelic_app_name = 'Test Website'
if new_resource.environment['RAILS_ENV'] == 'staging'
  newrelic_app_name = 'Test Website (Staging)'
end

run %(curl -H "x-api-key:#{newrelic_deploy_key}" -d "deployment[app_name]=#{newrelic_app_name}" -d "deployment[description]=#{new_resource.environment['RAILS_ENV']}" -d "deployment[revision]='#{revision}'" -d "deployment[user]='#{user}'"  https://rpm.newrelic.com/deployments.xml)