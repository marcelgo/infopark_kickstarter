# ICE Kickstarter

The Kickstarter provides generators and rake tasks to quickly setup or enhance an [Infopark
Cloud Express](http://infopark.de/infopark-cloud-express) Ruby on Rails project. All generated code
represents a working example, but can be fully customized within the application.

## Installation

Add this section to your application's Gemfile:

    group(:development) do
      gem 'ice_kickstarter'
    end

Create the file `config/deploy.yml`. All necessary values can be taken from the Infopark Konsole:

    url: 'https://admin.saas.infopark.net/tenant_management/api/tenants/<tenant id>'
    api_key: '<tenant api key>'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ice_kickstarter

## Usage

The ICE Kickstarter assumes you have a fresh ICE project with an almost empty CMS tenant. If you
should have other content already, the provided examples may not work correctly.

To generate the basic code and CMS structure:

    $ rails generate cms:kickstart

After you enriched your application you should take a look at the CMS migrations under
```cms/migrate``` in order to have a basic understanding of what will be created in the CMS. You
could for example change the name of the website object or adopt some titles.

Once you have an overview, of what structure will be created, you can look at the generated code. A
good place to start is the ```choose_homepage``` callback in
```config/initializers/rails_connector.rb```. You can get a list of all changes with the help of
git:

    $ git status

This will list all files that were changed since your last commit. This allows you to also see
exactly what kind of changes have been made. It is also possible to easily revert all changes.

Finally, if you are pleased with the result of the ICE Kickstarter you can run:

    $ rake cms:migrate

to apply all new migrations to the CMS. After all migrations are processed you can visit the CMS and
look at the newly created workspace or start your local Ruby on Rails application

    $ rails server

and visit ```http://localhost:3000?ws=rtc``` to see the changes made in the migration workspace. You
have to provide the workspace, because the contents are not published yet.

## CMS Structure

When the ```cms:kickstart``` generator is finished the following CMS hierarchy is created:

    |- website
    |    |- homepage
    |        |- beispiel
    |        |- _configuration
    |            |- error_404
    |            |- login
    |            |- search
    |        |- _boxes
    |            |- box_text
    |            |- box_image
    |
    |- resources
        |- videos
        |- audio
        |- images
        |- pdfs

Together with the CMS hierarchy, some CMS object classes and attributes are created as well:

### Attributes ###

* show_in_navigation:enum (Yes No)
* error_404_page:linklist
* search_page:linklist
* login_page:linklist
* locale:string
* source:linklist
* caption:string
* sort_key:string

### Object Classes ###

* Root
* Homepage
* Website
* Container
* ContentPage
* ErrorPage
* LoginPage
* SearchPage
* BoxText
* BoxImage

## Generators

To get an overview of all provided generators:

    $ rails generate

To create a new CMS attribute:

    $ rails generate cms:attribute

To create a new CMS object class:

    $ rails generate cms:model

To create a new controller and index view based on a CMS object class:

    $ rails generate cms:controller

The two above generators (cms:model and cms:controller) can be combined in one generator:

    $ rails generate cms:scaffold

To add the google analytics functionality to the app:

    $ rails generate cms:component:google_analytics

To add a contact page functionality to the app:

    $ rails generate cms:component:contact_page

To add a language switch functionality to the app:

    $ rails generate cms:component:language_switch

## Rake Tasks

To get an overview of all provided rake tasks:

    $ rake -T cms

To run all cms migrations:

    $ rake cms:migrate

The command only processes new, not yet released CMS migrations that are placed in the
```cms/migrate``` directory. Migrations are ordered by their version number.

To publish all processed migrations:

    $ rake cms:migration:publish

To delete all migrations that are not published (deletes the ```rtc workspace```):

    $ rake cms:migration:abort

To deploy the ```origin/master``` branch to the live servers:

    $ rake cms:deploy

To get deployment status for last deployment (or given deployment id):

    $ rake cms:deploy:status[id]

To list github users allowed to access the project repository:

    $ rake cms:github:list

To show access information for github user:

    $ rake cms:github:show[username]

To add github user with ```pull``` (read-only, default) or ```push``` (read and write) permission:

    $ rake cms:github:add[username,permission]

To change access permission of github user to ```pull``` (read-only) or ```push``` (read and write):

    $ rake cms:github:change[username,permission]

To disallow github user to access the project repository:

    $ rake cms:github:remove[username]

## Developer Dashboard

A developer dashboard is available under "/cms/dashboard". It is only available for local requests.
The dashboard provides an overview of the current status of the application, the CMS and CRM. It
lists involved people, CMS and CRM statistics, latest core gem versions and object classes and their
attributes.

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
