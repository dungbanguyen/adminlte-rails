require 'spec_helper'

RSpec.describe AdminLTE::Rails::VERSION do
  it 'is defined' do
    expect(AdminLTE::Rails::VERSION).not_to be_nil
  end
end
