source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt', '~> 2.0'
  cookbook 'yum-epel'
end

cookbook 'mysql', path: '/Users/someara/src/chef-cookbooks/mysql'
cookbook 'yum-remi', path: '/Users/someara/src/chef-cookbooks/yum-remi'
cookbook 'php_runtime_test', path: 'test/fixtures/cookbooks/php_runtime_test'
cookbook 'pear_channel_test', path: 'test/fixtures/cookbooks/pear_channel_test'
