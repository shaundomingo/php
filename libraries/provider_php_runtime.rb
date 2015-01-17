require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      include PhpCookbook::Helpers

      action :install do
        parsed_runtime_packages.each do |pkg|
          package "#{new_resource.name} :install #{pkg[:pkg_name]}" do
            package_name pkg[:pkg_name]
            version pkg[:pkg_version]
            action :install
          end
        end
      end

      action :remove do
      end
    end
  end
end
