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
                {:name=>"content", :type=>:string, :title=>"Content"},
                {:name=>"headline", :type=>:string, :title=>"Headline"},
              ]
            end

            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = 'AccordionContent'
              model.title = '&#xF010;'
              model.description = 'Content row of the accordion widget.'
              model.type = 'publication'
              model.attributes = [
                {:name=>"headline", :type=>:string, :title=>"Headline"},
                {:name=>"content", :type=>:html, :title=>"Content"},
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