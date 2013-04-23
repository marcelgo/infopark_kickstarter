# v2.1.0
  * Improved introduction page, when the current workspace does not have a homepage, by switching to
    a more positive message, giving clear directions and smoothing the transition to more help
    through links in the footer.
  * Extracted the redirect functionality into its own generator. It is still included as part of the
    kickstart.
  * The language switch is now generated without an example. Use
    `rails generate cms:component:language_switch --example` for the old behavior.
  * Useless, empty controller `index` actions got removed.
  * Useless spec files got removed.

# v2.0.1
  * Bugfix: Some widgets still had a sort key attribute, which is not longer needed due to the built
    in sort feature of widgets.
  * Bugfix: Widgets did not place their migrations in the widget folder.
  * Bugfix: The Dashboard crashed when global attributes were used and did not display the list of
    global attributes. (Thanks @TWT)
  * Bugfix: The Dashboard people page did not work, if no `config/deploy.yml` file was given.
  * Bugfix: The WebCRM was not initialized correctly after running `rake cms:kickstart`.
  * Bugfix: The page method of the widget concern did not return the correct page, where the widget
    was placed in.

# v2.0.0
  * Added a widget generator to create and integrate widgets of any kind. See
    `rails generate cms:widget` for more details.
  * Bugfix: Timestamped ids are now used when creating migrations.
  * Presents a nicer error page, when the choose homepage callback does not return a homepage.
  * Removed the user manager as it was way too complicated and didn't fit the more general use case.
    This lead to some refactorings of the profile, login and contact page, which should be much
    clearer now.
  * Added social sharing component, that lets you easily integrate social sharing provider to share
    the current url. (Thanks @jan-hendrik)
  * Bugfix: The workspace toggle did not always display the correct workspace title.
  * Simplified the contact page component to a more general and understandable use case. Removed
    "valid_email" dependency and user attributes prefill. The contact page is no longer placed under
    "_configuration" and linked on the homepage, but can be placed like a normal page anywhere in
    the hierarchy.
  * Bugfix: Deployment task returned an 406 error, because the url params were not formatted
    correctly.
  * Supports widgets to put their locale files into the widget directory.
  * Switched to inplace editing and the Infopark widget framework. This also removes the need for
    concrete widget examples, as they can easily be inserted on each page via the widget browser. A
    toggle is placed in the main navigation bar to switch to edit mode. (Thanks @cocodercoder)
  * Kickstarter now uses local attributes only, because global attributes are deprecated and their
    usage is discouraged. See
    [News](https://dev.infopark.net/d72e25d5cd446190/cms-attributes-are-now-local-to-object-classes)
    for further details.
  * Bugfix: Added "sort_key" to GoogleMaps Box. (Thanks @franziska-luecke)
  * Added monitoring rake task for future extension to other monitoring provider. See
    `rake cms:component:monitoring` for further details.
  * Renamed `flash_message` to `flash`, simplified and streamlined use of cells.
  * Added rake task to retrieve a list of all permalinks and their paths. See
    `rake cms:info:permalinks` for more details.
  * Search support moved into its own generator and got cleaned up and simplified. See
    `rails generate cms:component:search --help` for more details.
  * Edit-Marker no longer are included by Infopark Kickstarter, as it became a default feature of
    of Infopark RailsConnector. (Thanks @tritz)
  * All rake tasks now use RestClient instead of curl, for better compatibility and consistent use
    of accept headers. (Thanks @awendt)
  * Bugfix: Dashboard could not be displayed, because the engine files were not packaged in the gem.
  * Added `honeybadger` as an error tracking provider. This will also be the default from now on
    instead of `airbrake`. Run `rails generate cms:component:error_tracking --provider=honeybadger`
    to install.
  * A new slider box type was added. It slides selected images and displays there title in an
    overlay. See `rails generate cms:widget:slider --help` for more details.
  * Bugfix: Creates file `before_migrate.rb` if it doesn't exist yet. This fixes an annoyence that
    was reported several times.
  * Speed up kickstart time by grouping gem setup at the beginning. (Thanks @sethiele)
  * A new person box type was added. It allows to display a crm person with some details like her
    name and email. See `rails generate cms:widget:person --help` for more details.

# v1.0.0
  * Renamed gem from `ice_kickstarter` to `infopark_kickstarter`. Please update your `Gemfile` to
    get the latest version.
  * Added blog component to generate a basic blog with RSS and comment functionality based on the
    box framework. Call `rails generate cms:component:blog --help` to get started.
  * Added `image_url` application helper to determine the external url of an image.
  * Added rake task to check the status of the Infopark Cloud-Express Platform. Run
    `rake cms:status` to get current status information.
  * A new video box type was added. It allows to play videos from the CMS, vimeo and youtube. See
    more details running `rails generate cms:widget:video --help`.
  * Added video obj class to the kickstart generator. This allows to upload and handle videos in a
    dedicated obj class.
  * Cleaned up the composition pattern used to add common behavior to object classes. You can
    differentiate between a `Page` and a `Box` by mixing in a module in the model class.
  * Updated links to the Infopark Console to `https://console.infopark.net`.
  * Bugfix: The markup for box titles is no longer displayed, when no title exists.
  * Cleaned up and extended the composition pattern used to add common behavior to object classes.
    You can now differentiate between a `Page`, a `Box` and a `Resource`.
  * Added rake task `rake cms:console` to open the Infopark console directly from the command line.
    This introduces a new dependency on the [launchy](https://github.com/copiousfreetime/launchy)
    gem. (Thanks @thomasritz)
  * Bugfix: The CMS webservice returns `RestClient::PreconditionFailed` not
    `RestClient::InternalServerError` when asked for the Github users when there
    is no Github repository configured. (Thanks @awendt)
  * Added model generator option to set mandatory attributes. For example:
    `rails generate cms:model Foo --attributes=foo bar baz --mandatory_attributes=bar baz`.
  * Added model generator option to preset attributes. For example:
    `rails generate cms:model Foo --attributes=foo bar baz --preset_attributes=foo:f bar:b`.
  * Added attribute generator option to preset the attribute value. The default depends on the type
    of the attribute. For example, to create an integer attribute that has `10` configured as a
    default, you call `rails generate cms:attribute my_attribute --type=integer --preset_value=10`.
  * Added attribute generator option to set the name of getter method. For Example:
    `rails generate cms:attribute my_attribute --type=integer --method_name=foo`. (Thanks @cocodercoder)
  * Added support for integer and float attribute types. For example:
    `rails generate cms:attribute count --type=integer` or
    `rails generate cms:attribute latitude --type=float`.
  * Newrelic generator now sets up developer mode. (Thanks @Kieran Hayes)
  * Bugfix: Newrelic generator did not insert the correct website name in the deploy files. It also
    does not depend on the kickstart generator anymore.
  * Bugfix: Newrelic generator did not differentiate between the deploy and the api key for
    deployment notifications.
  * Bugfix: The dashboard does no longer depend on the flash messages of the
    host application.
  * Bugfix: The contact form raised an error when there was no user logged in.
  * Airbrake component now includes secure option by default and does not depend on the kickstart
    generator anymore. Also added option "--skip-deployment-notification" if you don't resolve all
    error notifications on deployment.
  * Airbrake component is now available as the default provider for the error tracking component.
    This allows to support different error tracking solutions in the future. Run
    `rails generate cms:component:error_tracking --help` to get an overview. You can still call the
    Airbrake generator directly by running `rails generate cms:component:error_tracking:airbrake`.
  * Updated contribution section in the README, which should make it easier for developers to setup
    and add features to the project.
  * Updated Infopark gems and required ```bundler >= 1.3.1``` to also work with newer
    RubyGems versions.
  * Profile Page Component: Added option to skip the import of country translations.
  * Bugfix: ```application``` javascript manifest needs to be loaded before
    ```rails_connector_after_content_tags```. (Thanks @apepper)
  * Added support for markdown attribute type. For example:
    `rails generate cms:attribute body_md --type=markdown`. (Thanks @thomasritz)

# v0.0.5
  * Renamed ```error_404``` to ```error_not_found```.
  * Moved flash messages and workspace toggle into its own cell for better
    reusability and separation of concerns.
  * Simplified cms attribute concerns for easier understanding and extensibility.
  * Added support for https S3 urls in ```obj.rb```. (Thanks @thomasritz)
  * Added Https before filter to force https in live environment. Make sure to set a hostname in
    ```app/controllers/filters/https.rb``` before deployment. (Thanks @thomasritz)
  * Bugfix: There was an UTF encoding issue in the contact page generator. (Thanks @mremolt)
  * Removed fixed versions on most of the base gems to install newest versions on project setup.
  * Removed ```rails-footnotes``` as ```better_errors``` made it superfluous in most situations.
  * Added a profile page generator that adds a link in the meta navigation when the user is logged
    in. On the profile page, the user can edit all kinds of attributes that will be saved to the web
    crm.
  * Changed default homepage to ```en``` and updated examples accordingly.
  * Updated ```less-rails-bootstrap``` to version 2.3.0 and ```rspec``` to version 2.13.0.
  * The BoxText and BoxImage widgets are now a separate generator and can therefore be called with
    ```rake cms:widget:text```. If you also want to create an example, you can add the
    ```--cms_path``` option. Both widgets are still included in the Infopark Kickstarter base
    generator.
  * Added support for boolean attribute type. It fakes a boolean by creating an enum with "Yes" and
    "No" values and provides query method in the attribute module.
  * The newrelic generator now extends the local ```custom_cloud.yml``` file, runs
    ```bundle --quiet``` because it adds a new gem and prints a notice to update the custom cloud
    platform configuration.
  * The airbrake generator now reads in the api_key from the ```custom_cloud.yml```, extends the
    local ```custom_cloud.yml``` file, runs ```bundle --quiet``` because it adds a new gem and
    prints a notice to update the custom cloud platform configuration.
  * The ```custom_cloud.yml``` is now loaded in an initializer and is available as a hash in the
    global Rails configuration as ```Rails.application.config.cloud```. The initializer is created
    in such a way, that it is loaded before the rest of the initializers are run, so that it can be
    used in the following initializers as well.
  * A new google maps box type was added. It allows to easily create a map and place pins on it.
    The new box type is part of the base Infopark Kickstarter functionality but is also
    available as a separate generator. Call ```rails generate cms:widget:google_maps --help```
    for more information.
  * Added three additional rake tasks to easily edit the cloud config file, that holds configuration
    parameters that should not be checked in to the version control system. See
    ```rake -T cms:cloud_config``` for more details on the tasks.
  * The user manager now allows to find an user by id. The remote user with this id is retrieved and
    then mapped to an application user.
  * haml-rails is not longer required by the dashboard, but only haml. This prevents the default
    rails template engine to be set for the host application. (Thanks @mremolt)
  * A website object can now be asked for all its homepages and returns a list of all Homepage
    objects.
  * A language switch allows to navigate from one language homepage to another. All languages are
    listed in the sidebar. The current language is not linked.

# v0.0.4
  * Added README information on how to create a ```deploy.yml``` file and what content it needs to
    hold.

# v0.0.3
  * Added two new rake tasks ```rake cms:info:attributes[workspace]``` which returns a list of
    attributes and their type and ```rake cms:info:obj_classes[workspace]``` which returns a list of
    object classes and their attributes. For each task the workspace can optionally be provided.
  * BoxImage now supports a link attribute, that defines if and where the displayed image is linked
    to.
  * Support for ```Redirect``` cms objects. They allow to create a navigation item, for example,
    that redirects to a different page.
  * Assets are now shared between deployments via ```before_migrate.rb``` deploy hook.
  * The body tag now holds the name of the current controller. This allows easier css scoping.
  * Included [BetterErrors](https://github.com/charliesome/better_errors) and
    [BindingOfCaller](https://github.com/banister/binding_of_caller) as core development gems. Also
    added an developer initializer file that is ignored by default.
  * The Infopark Kickstarter now depends on Ruby 1.9.3. Please make sure to upgrade your Ruby version and
    use the latest Infopark gems. We recommend to use the new hash syntax throughout the project.
  * Added authorization support to simply protect access to a page via a before filter. Use
    ```before_filter Filters::Authorization``` in your controller to protect the entire page.
  * Complete refactoring of user management. Separated application user model from its remote user
    model by introducing an application wide user manager. A default implementation is given for the
    Infopark WebCRM. This makes it possible to easily swap the user manager to LDAP for example. A
    mapper class is used for the communication between the two, possibly different, user models.
    Have a look at ```app/models/user.rb``` for how it is implemented exactly.
  * Added optional contact_page component that is connected to the WebCRM and prefills email, when
    user is logged in. Call ```rails generate cms:component:contact_page```.
  * Added Infopark Developer Dashboard mounted under ```/cms/dashboard```. The dashboard
    is only available for local requests and completely separated from your Ruby on Rails
    application.
  * Bugfix: Workspace Toggle no longer displays an empty list, when there is only one workspace.
  * Changed ```rake cms:deploy:live``` to ```rake cms:deploy``` as there is no other environment yet.
  * Added optional google analytics generator. Tracking ID and Anonymize IP Setting can
    be configured in the CMS for each homepage. Default settings can be given as generator
    options.

# v0.0.2
  * initial functionality