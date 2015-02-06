require 'chef/resource/lwrp_base'

class Chef
  class Provider
    class PhpRuntime
      class Source < Chef::Provider::PhpRuntime
        action :install do
          log 'hello'
        end

        action :remove do
          log 'hello'
        end
      end
    end
  end
end
