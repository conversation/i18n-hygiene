namespace :i18n do
  namespace :hygiene do

    desc "Check there are no values containing scripts"
    task check_script_tags: :environment do
      puts "Checking that no values contain script tags ..."

      keys_with_script_tags = I18n::Hygiene::KeysWithScriptTags.new

      keys_with_script_tags.each { |key| puts " - #{key}" }

      puts "Finished checking.\n\n"

      exit(1) if keys_with_script_tags.any?
    end

  end
end
