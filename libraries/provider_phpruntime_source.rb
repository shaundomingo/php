require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Source < Chef::Provider::PhpRuntime
        action :install do
          include_recipe 'build-essential'
          include_recipe 'yum-epel' if new_resource.manage_package_repos && node['platform_family'] == 'rhel'

          mysql_client 'default' do
            action :create
          end

          parsed_build_pkgdeps.each do |pkg|
            package pkg do
              action :install
            end
          end

          if node['platform_family'] == 'fedora'
            link "#{new_resource.name} :install /usr/lib/libc-client.a" do
              target_file '/usr/lib/libc-client.a'
              to '/usr/lib64/libc-client.a'
              action :create
            end
          end

          if node['platform'] == 'ubuntu'
            link "#{new_resource.name} :install /usr/include/gmp.h" do
              target_file '/usr/include/gmp.h'
              to '/usr/include/x86_64-linux-gnu/gmp.h'
              action :create
            end
          end

          remote_file "#{cache_path}/php-#{parsed_version}.tar.gz" do
            source parsed_mirror_url
            checksum parsed_source_checksum
            mode '0644'
          end

          bash 'make install php tarball' do
            code <<-EOS
            tar xzf #{cache_path}/php-#{parsed_version}.tar.gz -C #{cache_path}
            (cd #{cache_path}/php-#{parsed_version} && ./configure #{parsed_configure_options.join(' ')})
            (cd #{cache_path}/php-#{parsed_version} && make -j#{node['cpu']['total']} && make install)
            EOS
            not_if { ::File.exist?("#{parsed_php_home}/bin/php") }
          end

          directory "#{new_resource.name} : install #{conf_dir}" do
            path conf_dir
            owner 'root'
            group 'root'
            mode '0755'
            recursive true
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
            action :create
          end
        end # action :install

        action :remove do
          log 'hello'
        end # action :remove
      end
    end
  end
end
