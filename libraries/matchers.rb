if defined?(ChefSpec)
  # runtime
  def install_php_runtime(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_runtime, :install, resource_name)
  end

  def remove_php_runtime(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_runtime, :remove, resource_name)
  end
end
