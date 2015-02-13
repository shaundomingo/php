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

# http://pear.php.net/manual/en/guide.users.commandline.channels.php

require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end

action :discover do
  execute "Discovering pear channel #{new_resource.channel_name}" do
    command "#{php_bin} channel-discover #{new_resource.channel_name}"
    not_if { channel_exists? }
    action :run
  end
end

action :add do
  execute "Adding pear channel #{new_resource} from #{new_resource.channel_xml}" do
    command "#{php_bin} channel-add #{new_resource.channel_xml}"
    not_if { channel_exists? }
    action :run
  end
end

action :update do
  if channel_exists?
    update_needed = false
    begin
      update_needed = true if shell_out("#{php_bin} search -c #{new_resource.channel_name} NNNNNN").stdout =~ /channel-update/
    rescue Chef::Exceptions::CommandTimeout
      # CentOS can hang on 'pear search' if a channel needs updating
      Chef::Log.info("Timed out checking if channel-update needed...forcing update of pear channel #{new_resource.channel_name}")
      update_needed = true
    end

    if update_needed
      description = "update pear channel #{new_resource}"
      converge_by(description) do
        Chef::Log.info("Updating pear channel #{new_resource}")
        shell_out!("#{php_bin} channel-update #{new_resource.channel_name}")
      end
    end
  end
end

action :remove do
  execute "Deleting pear channel #{new_resource.channel_name}" do
    command "#{php_bin} channel-delete #{new_resource.channel_name}"
    not_if {  channel_exists? }
    action :run
  end
end

private

def channel_exists?
  shell_out!("#{php_bin} channel-info #{current_resource.channel_name}")
  true
rescue Mixlib::ShellOut::ShellCommandFailed
  false
end
