# ICE Kickstarter

The Kickstarter provides generators and rake tasks to quickly setup or enhance an [Infopark
Cloud Express](http://infopark.de/infopark-cloud-express) Ruby on Rails project. All generated code
represents a working example, but can be fully customized within the application.


## Installation and Usage

Please visit our Knowledge Base to get the
[latest installation and usage information](https://kb.infopark.de/89b37c1667cda31a/kurzanleitung-zum-gebrauch?locale=en).


## Developer Dashboard

Please visit our Knowledge Base to get the
[latest developer dashboard information](https://kb.infopark.de/638a180eaff436f6/the-developer-dashboard?locale=en).


## Testing

There are two types of tests. First there are standard rspec tests of the ICE Kickstarter engine.
You can run these tests by simply calling:

    $ rake spec

There are also integration tests, that can be run by:

    $ rake test:integration

In order to run them successfully, you need to create a ```config/local.yml``` file and put in your
test tenant data. See [local.yml.template](https://github.com/infopark/ice_kickstarter/blob/master/config/local.yml.template)
for what is needed exactly. The integration tests create an entire new application execute
```rails generate cms:kickstart``` and run a few other generators and then execute the tests of the
newly created application.


## Changelog

See [Changelog](https://github.com/infopark/ice_kickstarter/blob/master/CHANGELOG.md) for more
details.


## Contributing

We would be very happy and thankful if you open new issues in order to further improve the Infopark
Kickstarter. If you want to go a step further and extend the functionality or fix a problem
yourself, you can do so any time by following the steps below.

1. Signup for a [free Infopark Cloud Express account](https://www.infopark.de/) and setup a test CMS
   and CRM tenant in the Infopark Konsole.
2. Fork and clone Infopark Kickstarter Github repository.

        git clone git@github.com:<your github username>/ice_kickstarter.git
        cd ice_kickstarter

3. We suggest using RVM or rbenv. Anyway, compare your local ruby version with the version given in
   `.ruby-version` and install it if necessary.

        ruby --version

3. Download the configuration files from the Infopark Konsole and unzip all files into the test
   application that is part of the Infopark Kickstarter gem.

        spec/dummy/config/rails_connector.yml
        spec/dummy/config/custom_cloud.yml
        spec/dummy/config/deploy.yml

4. Setup the local configuration file and provide the same credentials you just downloaded from the
   Infopark Konsole.

        cp config/local.yml.template config/local.yml
        open config/local.yml

5. Create the bundle and run all test to make sure everything is working before you add your own
   changes.

        bundle
        rake spec
        rake test:integration

6. Create your feature branch (`git checkout -b feature/my-new-feature`)
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin feature/my-new-feature`)
9. Create new Pull Request on Github against the `develop` branch.


## License
Copyright (c) 2009 - 2012 Infopark AG (http://www.infopark.com)

This software can be used and modified under the LGPLv3. Please refer to http://www.gnu.org/licenses/lgpl-3.0.html for the license text.