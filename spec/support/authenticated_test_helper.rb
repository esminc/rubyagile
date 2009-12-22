module Spec
  module Rails
    module Example
      [ControllerExampleGroup, ViewExampleGroup].each do |klass|
        klass.send(:include, AuthenticatedTestHelper)
      end
    end
  end
end
