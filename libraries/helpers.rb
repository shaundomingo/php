#
# Author:: Sean OMeara (<sean@chef.io>)
# Cookbook Name:: php
# Libraries:: helpers
#
# Copyright 2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module PhpCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def cache_path
      Chef::Config[:file_cache_path]
    end
    
    def parsed_php_home
      '/opt/php-instance-1'
    end

    def parsed_version
      return new_resource.version if new_resource.version
      # put default versions here
    end

    def parsed_build_pkgdeps
      return new_resource.build_pkgdeps if new_resource.build_pkgdeps
      value_for_platform_family(
        %w(rhel fedora) => %w(
          bzip2-devel libc-client-devel
          curl-devel freetype-devel
          gmp-devel libjpeg-devel
          krb5-devel libmcrypt-devel
          libpng-devel openssl-devel
          t1lib-devel mhash-devel
          libxml2-devel
        ),
        %w(debian ubuntu) => %w(
          libbz2-dev libc-client2007e-dev
          libcurl4-gnutls-dev libfreetype6-dev
          libgmp3-dev libjpeg62-dev
          libkrb5-dev libmcrypt-dev
          libpng12-dev libssl-dev
          libt1-dev
        ))
    end
    
    def lib_dir
      return node['kernel']['machine'] =~ /x86_64/ ? 'lib64' : 'lib' if node['platform_family'] == 'rhel'
      'lib'
    end

    def conf_dir
      return '/etc' if %w(rhel fedora).include? node['platform_family']
      return '/etc/php5/cli' if %w(debian ubuntu suse).include? node['platform_family'] 
    end

    def ext_conf_dir
      return '/etc/php.d' if %w(rhel fedora).include? node['platform_family']
      return '/etc/php5/conf.d' if %w(debian ubuntu suse).include? node['platform_family'] 
    end

    def fpm_user
      return 'nobody' if %w(rhel fedora).include? node['platform_family']
      return 'www-data' if %w(debian ubuntu).include? node['platform_family']
      return 'wwwrun' if %w(suse).include? node['platform_family'] 
    end

    def fpm_group
      return 'nobody' if %w(rhel fedora).include? node['platform_family']
      return 'www-data' if %w(debian ubuntu).include? node['platform_family']
      return 'www' if %w(suse).include? node['platform_family'] 
    end
    
    def parsed_configure_options
      return new_resource.configure_options if new_resource.configure_options
      # FIXME: conf_dir
      # FIXME: ext_conf_dir
      # FIXME: fpm_user
      # FIXME: fpm_group
      %W(
        --prefix=#{parsed_php_home}
        --with-libdir=#{lib_dir}
        --with-config-file-path=#{conf_dir}
        --with-config-file-scan-dir=#{ext_conf_dir}
        --with-pear
        --enable-fpm
        --with-fpm-user=#{fpm_user}
        --with-fpm-group=#{fpm_group}
        --with-zlib
        --with-openssl
        --with-kerberos
        --with-bz2
        --with-curl
        --enable-ftp
        --enable-zip
        --enable-exif
        --with-gd
        --enable-gd-native-ttf
        --with-gettext
        --with-gmp
        --with-mhash
        --with-iconv
        --with-imap
        --with-imap-ssl
        --enable-sockets
        --enable-soap
        --with-xmlrpc
        --with-libevent-dir
        --with-mcrypt
        --enable-mbstring
        --with-t1lib
        --with-mysql
        --with-mysqli=/usr/bin/mysql_config
        --with-mysql-sock
        --with-sqlite3
        --with-pdo-mysql
        --with-pdo-sqlite)
    end

    def parsed_mirror_url
      return new_resource.mirror_url if new_resource.mirror_url
      "http://us1.php.net/get/php-#{parsed_version}.tar.bz2/from/this/mirror"
    end

    def parsed_source_url
      return new_resource.source_url if new_resource.source_url
      # FIXME: calculate a default?
      # based on?
    end

    def parsed_source_checksum
      return new_resource.source_checksum if new_resource.source_checksum
      '576f9001b612f5ddc22f447311bbec321e2c959b6a52259d664c4ba04ef044f1'
      # FIXME: look this up based on what?
    end

    def parsed_runtime_packages
      return new_resource.packages if new_resource.packages
      runtime_packages
    end

    def parsed_version
      return new_resource.version if new_resource.version
      return '5.3' if node['platform'] == 'amazon'
      return '5.4' if node['platform'] == 'debian'
      return '5.3' if node['platform'] == 'ubuntu' && node['platform_version'].to_f == 10.04
      return '5.3' if node['platform'] == 'ubuntu' && node['platform_version'].to_f == 12.04
      return '5.5' if node['platform'] == 'ubuntu' && node['platform_version'].to_f == 14.04
      return '5.3' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 5
      return '5.3' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 6
      return '5.4' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 7
      return '5.4' if node['platform_family'] == 'fedora' && node['platform_version'].to_i == 20
      return '5.5' if node['platform_family'] == 'fedora' && node['platform_version'].to_i == 21
    end

    def configure_package_repositories
      platfam = node['platform_family']
      platver = node['platform_version']
      case parsed_version
      when '5.4'
        include_recipe 'yum-remi::remi' if platfam == 'rhel' && platver.to_i == 5
        include_recipe 'yum-remi::remi' if platfam == 'rhel' && platver.to_i == 6
      when '5.5'
        include_recipe 'yum-remi::remi-php55' if platfam == 'rhel' && platver.to_i == 5
        include_recipe 'yum-remi::remi-php55' if platfam == 'rhel' && platver.to_i == 6
        include_recipe 'yum-remi::remi-php55' if platfam == 'rhel' && platver.to_i == 7
      when '5.6'
        include_recipe 'yum-remi::remi-php56' if platfam == 'rhel' && platver.to_i == 5
        include_recipe 'yum-remi::remi-php56' if platfam == 'rhel' && platver.to_i == 6
        include_recipe 'yum-remi::remi-php56' if platfam == 'rhel' && platver.to_i == 7
        include_recipe 'yum-remi::remi-php56' if platfam == 'fedora' && platver.to_i == 20
      end
    end

    def runtime_packages
      # amazon
      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform'] == 'amazon' &&
           parsed_version == '5.3'

      return [
        { pkg_name: 'php54-common', pkg_version: nil },
        { pkg_name: 'php54-cli', pkg_version: nil }
      ] if node['platform'] == 'amazon' &&
           parsed_version == '5.4'

      return [
        { pkg_name: 'php55-common', pkg_version: nil },
        { pkg_name: 'php55-cli', pkg_version: nil }
      ] if node['platform'] == 'amazon' &&
           parsed_version == '5.5'

      # rhel
      return [
        { pkg_name: 'php53-common', pkg_version: nil },
        { pkg_name: 'php53-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel' &&
           node['platform_version'].to_i == 5 &&
           parsed_version == '5.3'
      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel'

      # fedora
      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform_family'] == 'fedora'

      # debian
      return [
        { pkg_name: 'php5', pkg_version: nil },
        { pkg_name: 'php5-cli', pkg_version: nil }
      ] if node['platform'] == 'debian' &&
           node['platform_version'].to_i == 7 &&
           parsed_version == '5.4'

      # ubuntu
      return [
        { pkg_name: 'php5', pkg_version: nil },
        { pkg_name: 'php5-cli', pkg_version: nil }
      ] if node['platform'] == 'ubuntu' &&
           node['platform_version'].to_f == 10.04 &&
           parsed_version == '5.3'

      return [
        { pkg_name: 'php5', pkg_version: nil },
        { pkg_name: 'php5-cli', pkg_version: nil }
      ] if node['platform'] == 'ubuntu' &&
           node['platform_version'].to_f == 12.04 &&
           parsed_version == '5.3'

      return [
        { pkg_name: 'php5', pkg_version: nil },
        { pkg_name: 'php5-cli', pkg_version: nil }
      ] if node['platform'] == 'ubuntu' &&
           node['platform_version'].to_f == 14.04 &&
           parsed_version == '5.5'
    end
  end
end
