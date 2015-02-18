require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      include PhpCookbook::Helpers

      def whyrun_supported?
        true
      end

      action :install do
      end

      action :remove do
      end
    end
  end
end
