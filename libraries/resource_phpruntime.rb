require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class PhpRuntime < Chef::Resource::LWRPBase
      self.resource_name = :php_runtime
      actions :install, :remove
      default_action :install

      attribute :version, kind_of: String, default: nil
      attribute :packages, kind_of: Array, default: nil # of Hashes
    end
  end
end
