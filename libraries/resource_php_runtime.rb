require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class PhpRuntime < Chef::Resource::LWRPBase
      self.resource_name = :php_runtime
      actions :install, :remove
      attribute :version
    end
  end
end
