user = %x(whoami).strip
revision = %x(git rev-parse HEAD).strip
newrelic_deploy_key = node['custom_cloud']['newrelic']['api_key']

newrelic_app_name = '<%= name %>'
if new_resource.environment['RAILS_ENV'] == 'staging'
  newrelic_app_name = '<%= name %> (Staging)'
end

run %(curl -H "x-api-key:#{newrelic_deploy_key}" -d "deployment[app_name]=#{newrelic_app_name}" -d "deployment[description]=#{new_resource.environment['RAILS_ENV']}" -d "deployment[revision]='#{revision}'" -d "deployment[user]='#{user}'"  https://rpm.newrelic.com/deployments.xml)