require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Package < Chef::Provider::PhpRuntime
        action :install do
          # because pecls need compilers
          # include_recipe 'build-essential'

          configure_package_repositories if new_resource.manage_package_repos

          cache_path = Chef::Config[:file_cache_path]

          # require 'pry'; binding.pry if node['platform'] == 'ubuntu'

          # iterate over packages..
          parsed_runtime_packages.each do |pkg|
            package "#{new_resource.name} :install #{pkg[:pkg_name]}" do
              package_name pkg[:pkg_name]
              version pkg[:pkg_version]
              action :install
            end
          end

          if very_old_pear?
            package 'expect' do
              action :install
            end

            cookbook_file "#{new_resource.name} :install #{cache_path}/go-pear.phar" do
              path "#{cache_path}/go-pear.phar"
              source 'go-pear.phar'
              cookbook 'php'
              owner 'root'
              group 'root'
              mode '0755'
              action :create
            end

            template "#{new_resource.name} :install #{cache_path}/anykey.exp" do
              path "#{cache_path}/anykey.exp"
              source 'anykey.exp.erb'
              cookbook 'php'
              owner 'root'
              group 'root'
              mode '0755'
              variables(cache_path: cache_path)
              action :create
            end

            execute "#{new_resource.name} :install /usr/bin/pear" do
              command "#{cache_path}/anykey.exp"
              creates '/usr/bin/pear'
              action :run
            end
          else
            package 'php-pear' do
              action :install
            end
          end

          directory "#{new_resource.name} :install #{conf_dir}" do
            path conf_dir
            owner 'root'
            group 'root'
            mode '0755'
            action :create
          end

          template "#{new_resource.name} :install #{conf_dir}/php.ini" do
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
