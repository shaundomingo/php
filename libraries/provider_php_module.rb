class Chef
  class Provider
    class PhpModule < Chef::Provider::LWRPBase
      provides :php_module, platform_family: 'rhel'

      # methods from libraries/helpers.rb
      include PhpCookbook::Helpers

      def module_package_name
        return "php-#{new_resource.module_name}" if node['platform_family'] == 'rhel'
        return "php-#{new_resource.module_name}" if node['platform_family'] == 'fedora'
        return "php5-#{new_resource.module_name}" if node['platform_family'] == 'debian'
      end

      action :install do
        configure_package_repositories if new_resource.manage_package_repos

        # Most distros provide "external extentions" as packages
        # http://php.net/manual/en/extensions.membership.php
        package "#{new_resource.name} :install #{module_package_name}" do
          package_name module_package_name
          action :install
        end
      end
    end
  end
end
