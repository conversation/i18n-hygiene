module I18n
  module Hygiene
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/i18n_hygiene.rake"
      end
    end
  end
end
