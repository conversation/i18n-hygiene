require 'i18n/hygiene/rake_task'
require 'i18n/hygiene/config'

RSpec.describe I18n::Hygiene::RakeTask do
  it "yields a Configuration object" do
    expect{ |b| I18n::Hygiene::RakeTask.new(&b) }.to yield_with_args(I18n::Hygiene::Config)
  end
end
