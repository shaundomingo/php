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
