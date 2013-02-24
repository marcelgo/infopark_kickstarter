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

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request


## License
Copyright (c) 2009 - 2012 Infopark AG (http://www.infopark.com)

This software can be used and modified under the LGPLv3. Please refer to http://www.gnu.org/licenses/lgpl-3.0.html for the license text.