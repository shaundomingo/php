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

  let(:shellout) { double(run_command: nil, error!: nil, stdout: '', stderr: double(empty?: true)) }
  let(:dummy_class) { Class.new { include PhpCookbook::Helpers } }

  before do
    Mixlib::ShellOut.stub(:new).and_return(shellout)
  end

  context 'compiling the test recipe' do
    it 'creates php_pear_channel[default]' do
      expect(Mixlib::ShellOut).to receive(:new).with('/usr/bin/pear list-channels', returns: [0, 1])
      expect(centos_58_pear_channel_51).to install_php_pear_channel('default')
        .with(version: '5.1')
    end
  end

  # context 'stepping into php_pear_channel[default]' do
  #   it 'installs package[default :install php-cli]' do
  #     expect(centos_58_pear_channel_51).to install_package('default :install php-cli')
  #       .with(package_name: 'php-cli', version: nil)
  #   end

  #   it 'installs package[default :install php-common]' do
  #     expect(centos_58_pear_channel_51).to install_package('default :install php-common')
  #       .with(package_name: 'php-common', version: nil)
  #   end
  # end
end
