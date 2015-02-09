require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Source < Chef::Provider::PhpRuntime

        action :install do
          include_recipe 'build-essential'
          include_recipe 'yum-epel' if new_resource.manage_package_repos

          mysql_client 'default' do
            action :create
          end

          parsed_build_pkgdeps.each do |pkg|
            package pkg do
              action :install
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
            (cd #{cache_path}/php-#{parsed_version} && make && make install)
            EOS
            not_if { ::File.exist?("#{parsed_php_home}/bin/php") }
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
