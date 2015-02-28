if defined?(ChefSpec)
  # php_runtime
  def install_php_runtime(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_runtime, :install, resource_name)
  end

  def remove_php_runtime(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_runtime, :remove, resource_name)
  end

  # php_pear_channel
  def discover_php_pear_channel(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear_channel, :discover, resource_name)
  end

  # php_pear
  def install_php_pear(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :install, resource_name)
  end

  def upgrade_php_pear(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :upgrade, resource_name)
  end

  def upgrade_php_pear(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :upgrade, resource_name)
  end

  def remove_php_pear(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :remove, resource_name)
  end

  def purge_php_pear(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :purge, resource_name)
  end
end
