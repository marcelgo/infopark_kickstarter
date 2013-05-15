module Cms
  module Generators
    module Widget
      class AccordionGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'AccordionWidget'
              widget.icon = '&#xF010;'
              widget.description = 'Widget that adds a boostrap collapse component.'
              widget.attributes = [
                {:name=>"headline_0", :type=>:string, :title=>"Headline One"},
                {:name=>"content_0", :type=>:html, :title=>"Content One"},
                {:name=>"headline_1", :type=>:string, :title=>"Headline Two"},
                {:name=>"content_1", :type=>:html, :title=>"Content Two"},
                {:name=>"headline_2", :type=>:string, :title=>"Headline Three"},
                {:name=>"content_2", :type=>:html, :title=>"Content Three"},
                {:name=>"headline_3", :type=>:string, :title=>"Headline Four"},
                {:name=>"content_3", :type=>:html, :title=>"Content Four"},
              ]
            end

            directory('app', force: true)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end
      end
    end
  end
end