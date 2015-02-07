require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Source < Chef::Provider::PhpRuntime
        include PhpCookbook::Helpers

        action :install do
          # Variables
          parsed_version = '5.6.4'

          include_recipe 'build-essential'
          include_recipe 'yum-epel'

          parsed_build_pkgdeps.each do |pkg|
            package pkg do
              action :install
            end
          end

          remote_file "#{cache_path}/php-#{parsed_version}.tar.bz2" do
            source parsed_mirror_url
            checksum parsed_source_checksum
            mode '0644'
          end

          bash 'make install php tarball' do
            code <<-EOS
            tar xjf #{cache_path}/php-#{parsed_version}.tar.bz2 -C #{cache_path}
            (cd #{cache_path}/php-#{parsed_version} && ./configure #{parsed_configure_options.join(' ')})
            (cd #{cache_path}/php-#{parsed_version} && make && make install)
            EOS
            not_if { ::File.exist?("#{parsed_php_home}/bin/php") }
          end
        end

        action :remove do
          log 'hello'
        end
      end
    end
  end
end
