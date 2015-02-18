#
# Author:: Sean OMeara <sean@chef.io>
#
# Copyright:: 2015, Chef Software, Inc <legal@chef.io>
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

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class PhpRuntime < Chef::Resource::LWRPBase
      self.resource_name = :php_runtime
      actions :install, :remove
      default_action :install

      # package provider expects version in the form '5.x'
      # source provider expects version in the form '5.x.x'

      attribute :build_pkgdeps, kind_of: Array, default: nil
      attribute :configure_options, kind_of: Array, default: nil
      attribute :directives, kind_of: Hash, default: {}
      attribute :instance, kind_of: String, name_attribute: true
      attribute :manage_package_repos, kind_of: [TrueClass, FalseClass], default: true
      attribute :mirror_url, kind_of: String, default: nil
      attribute :packages, kind_of: Array, default: nil # of Hashes
      attribute :php_home, kind_of: String, default: nil
      attribute :source_checksum, kind_of: String, default: nil
      attribute :source_url, kind_of: String, default: nil
      attribute :version, kind_of: String, default: nil
    end
  end
end
