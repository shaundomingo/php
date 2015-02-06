require 'spec_helper'

describe 'php_runtime_test::package' do
  cached(:centos_58_runtime_51) do
    ChefSpec::ServerRunner.new(
      platform: 'centos',
      version: '5.8',
      step_into: 'php_runtime'
      ) do |node|
      node.set['php']['version'] = '5.1'
    end.converge('php_runtime_test::package')
  end

  context 'compiling the test recipe' do
    it 'creates php_runtime[default]' do
      expect(centos_58_runtime_51).to install_php_runtime('default')
        .with(version: '5.1')
    end
  end

  context 'stepping into php_runtime[default]' do
    # it 'installs package[default :install php-cli]' do
    #   require 'pry'; binding.pry
    #   expect(centos_58_runtime_51).to install_package('default :install php-cli')
    #     .with(package_name: 'php-cli', version: nil)
    # end

    # it 'installs package[default :install php-common]' do
    #   expect(centos_58_runtime_51).to install_package('default :install php-common')
    #     .with(package_name: 'php-common', version: nil)
    # end
  end
end
