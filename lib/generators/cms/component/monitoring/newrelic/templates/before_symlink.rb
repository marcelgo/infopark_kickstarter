template "#{release_path}/config/newrelic.yml" do
  local true
  owner 'deploy'
  group 'root'
  mode 0664
  source "#{release_path}/deploy/templates/newrelic.yml.erb"
end