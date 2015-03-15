require 'spec_helper'

describe 'php_pear_test::default' do
  cached(:centos_58_pear_51) do
    ChefSpec::ServerRunner.new(
      platform: 'centos',
      version: '5.8',
      step_into: 'php_pear'
      ) do |node|
      node.set['php']['version'] = '5.1'
    end.converge('php_pear_test::default')
  end

  let(:wat) { double('wat') }

  before do
    Mixlib::ShellOut.stub(:new).and_return(wat)
    wat.stub(:run_command).and_return(wat)
    wat.stub(:live_stream).and_return(wat)
    wat.stub(:error!).and_return(wat)
    wat.stub(:stdout).and_return(wat)
    wat.stub(:match).and_return(wat)
    wat.stub(:[]).and_return(wat)

    wat.stub(:pecl?).and_return(false)
    wat.stub(:ext_dir).and_return('/usr/lib64/php/modules')
    wat.stub(:pear_shell_out).and_return(true)
    wat.stub(:installed_version).and_return('0.6.9')
    wat.stub(:candidate_version).and_return('0.6.9')
    wat.stub(:pear_installed?).and_return(false)

    stub_command('/usr/bin/pear list | grep ^Net_URL[[:space:]].*1.0.1').and_return(true)
    stub_command('/usr/bin/pear list | grep ^Net_Socket[[:space:]].*1.0.1').and_return(true)
    stub_command('/usr/bin/pear list | grep ^Date').and_return(true)
  end

  context 'compiling the test recipe' do
    it 'creates php_pearl[Net_Ping]' do
      expect(centos_58_pear_51).to install_php_pear('Net_Ping')
    end
  end
end
