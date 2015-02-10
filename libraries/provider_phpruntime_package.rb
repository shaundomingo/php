require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Package < Chef::Provider::PhpRuntime
        action :install do
          configure_package_repositories if new_resource.manage_package_repos

          # iterate over packages..
          # either supplied as resource parameters, or default values
          parsed_runtime_packages.each do |pkg|
            package "#{new_resource.name} :install #{pkg[:pkg_name]}" do
              package_name pkg[:pkg_name]
              version pkg[:pkg_version]
              action :install
            end
          end

          directory "#{new_resource.name} : install #{conf_dir}" do
            path conf_dir
            owner 'root'
            group 'root'
            mode '0755'
            action :create
          end

          template "#{new_resource.name} : install #{conf_dir}/php.ini" do
            path "#{conf_dir}/php.ini"
            source 'php.ini.erb'
            cookbook 'php'
            owner 'root'
            group 'root'
            mode '0644'
            variables(directives: new_resource.directives)
          end
        end # action :install

        action :remove do
        end # action :remove
      end
    end
  end
end
