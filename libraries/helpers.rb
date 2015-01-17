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
    def parsed_runtime_packages
      return new_resource.packages if new_resource.packages
      runtime_packages
    end

    def runtime_packages
      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel' &&
           node['platform_version'].to_i == 5 &&
           new_resource.version == '5.1'

      return [
        { pkg_name: 'php53-common', pkg_version: nil },
        { pkg_name: 'php53-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel' &&
           node['platform_version'].to_i == 5 &&
           new_resource.version == '5.3'

      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel' &&
           node['platform_version'].to_i == 6 &&
           new_resource.version == '5.3'

      return [
        { pkg_name: 'php-common', pkg_version: nil },
        { pkg_name: 'php-cli', pkg_version: nil }
      ] if node['platform_family'] == 'rhel' &&
           node['platform_version'].to_i == 7 &&
           new_resource.version == '5.4'
    end
  end
end
