# The module can be used to patch generators that are invoked from the generator under test. It
# sets the destination root to the tmp directory.
#
# Example:
#
#   before(:all) do
#     Cms::Generators::AttributeGenerator.send(:include, TestDestinationRoot)
#   end
module TestDestinationRoot
  def initialize(*args)
    super(*args)

    self.destination_root = File.expand_path('../../../tmp/generators', __FILE__)
  end
end