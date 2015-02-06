# provider mappings for Chef 11

#############
# php_runtime
#############
Chef::Platform.set platform: :amazon, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :centos, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :debian, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :fedora, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :redhat, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :scientific, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :suse, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
Chef::Platform.set platform: :ubuntu, resource: :php_runtime, provider: Chef::Provider::PhpRuntime::Package
