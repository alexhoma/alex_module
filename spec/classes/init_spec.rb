require 'spec_helper'
describe 'alex_module' do

  context 'with defaults for all parameters' do
    it { should contain_class('alex_module') }
  end
end
