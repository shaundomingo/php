#
# Author::  Sean OMeara (<sean@chef.io>)
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

def el5_range
  (0..99).to_a.map { |i| "5.#{i}" }
end

module PhpCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def parsed_runtime_packages
      return new_resource.packages if new_resource.packages
      runtime_packages
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
  end
end
