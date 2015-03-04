#
# Author:: Seth Chisamore <schisamo@chef.io>
# Author:: Sean OMeara <sean@chef.io>
#
# Copyright:: 2015, Chef Software, Inc. <legal@chef.io>
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

# methods from libraries/helpers.rb
include PhpCookbook::Helpers

class Chef
  class Provider
    class PhpPear < Chef::Provider::LWRPBase
      use_inline_resources

      def whyrun_supported?
        true
      end

      action :install do
        # block methods found in libraries/helpers.rb
        ruby_block "#{new_resource.name} :install #{new_resource.package_name}" do
          block { install_pear }
          not_if { pear_installed? }
          action :run
        end
      end

      action :upgrade do
        # block methods found in libraries/helpers.rb
        ruby_block "#{new_resource.name} :upgrade #{new_resource.package_name}" do
          block { upgrade_pear }
          not_if { pear_at_desired_version? }
          only_if { upgrade_available? }
          action :run
        end
      end

      action :remove do
        # block methods found in libraries/helpers.rb
        ruby_block "#{new_resource.name} :remove #{new_resource.package_name}" do
          block { remove_pear }
          only_if { pear_installed? }
          action :run
        end
      end

      action :purge do
        # block methods found in libraries/helpers.rb
        ruby_block "#{new_resource.name} :purge #{new_resource.package_name}" do
          block { purge_pear }
          only_if { pear_installed? }
          action :run
        end
      end
    end
  end
end
