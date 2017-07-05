require 'i18n/hygiene/tasks/check_variables'
require 'i18n/hygiene/variable_checker'
require 'i18n/hygiene/wrapper'

RSpec.describe I18n::Hygiene::Tasks::CheckVariables do
  it "it yields a block" do
    expect{ |b| I18n::Hygiene::Tasks::CheckVariables.new(&b) }.to yield_control
  end

  it "defines a rake task" do
    expect_any_instance_of(Rake::TaskLib).to receive(:task)

    I18n::Hygiene::Tasks::CheckVariables.new do |task|
      task.check_locales = [:fr, :ja]
    end
  end
end
