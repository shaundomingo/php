require 'spec_helper'

describe 'php_pear_channel_test::default' do
  cached(:ubuntu_1004_pear_channel_53) do
    ChefSpec::ServerRunner.new(
      platform: 'ubuntu',
      version: '10.04',
      step_into: 'php_pear_channel'
      ) do |node|
      node.set['php']['version'] = '5.3'
    end.converge('php_pear_channel_test::default')
  end

  before do
    stub_command("/usr/bin/pear list-channels | awk '{ print $2 }'| grep ^symfony$").and_return(false)
  end

  context 'compiling the test recipe' do
    it 'creates php_pear_channel[pear.horde.org]' do
      expect(ubuntu_1004_pear_channel_53).to discover_php_pear_channel('pear.horde.org')
    end
  end

  context 'stepping into php_pear_channel[pear.horde.org]' do
  end
end
