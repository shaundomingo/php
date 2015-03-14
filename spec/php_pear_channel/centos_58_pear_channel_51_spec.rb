require 'spec_helper'

describe 'php_pear_channel_test::default' do
  cached(:centos_58_pear_channel_51) do
    ChefSpec::ServerRunner.new(
      platform: 'centos',
      version: '5.8',
      step_into: 'php_pear_channel'
      ) do |node|
      node.set['php']['version'] = '5.1'
    end.converge('php_pear_channel_test::default')
  end

  before do
    stub_command("/usr/bin/pear list-channels | awk '{ print $2 }'| grep ^symfony$").and_return(false)
    stub_command('/usr/bin/pear list-channels | grep ^pear.horde.org').and_return(false)
  end

  context 'compiling the test recipe' do
    it 'creates php_pear_channel[pear.horde.org]' do
      expect(centos_58_pear_channel_51).to discover_php_pear_channel('pear.horde.org')
    end
  end

  context 'stepping into php_pear_channel[pear.horde.org]' do
  end
end
