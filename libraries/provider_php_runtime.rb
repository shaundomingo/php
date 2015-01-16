require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :install do
        package "#{new_resource.name} :install php" do
          package_name 'php'
          version new_resource.package_version
          action :install
        end
      end

      action :remove do
      end
    end
  end
end
