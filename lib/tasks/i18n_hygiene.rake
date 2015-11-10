namespace :i18n do
  namespace :hygiene do

    desc "check for i18n phrases that contain entities"
    task check_entities: :environment do
      puts "Checking for phrases that contain entities but probably shouldn't..."

      keys_with_entities = I18n::Hygiene::KeysWithEntities.new

      keys_with_entities.each do |key|
        puts "- #{key}"
      end

      puts "Finished checking.\n\n"

      exit(1) if keys_with_entities.any?
    end

    desc "Check there are no values containing return symbols"
    task check_return_symbols: :environment do
      puts "Checking that no values contain return symbols i.e. U+23CE ..."

      keys_with_return_symbols = I18n::Hygiene::KeysWithReturnSymbol.new

      keys_with_return_symbols.each { |key| puts "- #{key}" }

      puts "Finished checking.\n\n"

      exit(1) if keys_with_return_symbols.any?
    end

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
