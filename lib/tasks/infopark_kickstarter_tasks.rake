require 'infopark_kickstarter/rake/deployment_task'
InfoparkKickstarter::Rake::DeploymentTask.new

require 'infopark_kickstarter/rake/github_task'
InfoparkKickstarter::Rake::GithubTask.new

require 'infopark_kickstarter/rake/info_task'
InfoparkKickstarter::Rake::InfoTask.new

require 'infopark_kickstarter/rake/cloud_config_task'
InfoparkKickstarter::Rake::CloudConfigTask.new

require 'infopark_kickstarter/rake/cms_task'
InfoparkKickstarter::Rake::CmsTask.new