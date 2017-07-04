namespace :i18n do
  namespace :hygiene do

    desc 'run all the i18n hygiene checks'
    task all: [:check_key_usage, :check_variables, :check_entities, :check_return_symbols, :check_script_tags]

    desc "check usage of all EN keys"
    task check_key_usage: :environment do
      require 'parallel'

      puts "Checking usage of EN keys..."
      puts "(Please be patient while the codebase is searched for key usage)"

      unused_keys = Parallel.map(I18n::Hygiene::Wrapper.new.keys_to_check) { |key|
        key unless I18n::Hygiene::KeyUsageChecker.new(key).used_in_codebase?
      }.compact

      unused_keys.each do |key|
        puts "#{key} is unused."
      end

      puts "Finished checking.\n\n"

      exit(1) if unused_keys.any?
    end

    desc "check for mismatching interpolation variables"
    task check_variables: :environment do
      puts "i18n:hygiene:check_variables is deprecated"
      print "\t", caller.first(5).map(&:strip).join("\n\t")

      puts "==="
      puts "New usage is exposed via I18n::Hygiene::Tasks::CheckVariables"
      puts "==="

      puts "Checking for mismatching interpolation variables..."

      wrapper = I18n::Hygiene::Wrapper.new

      mismatched_variables = wrapper.keys_to_check.select do |key|
        checker = I18n::Hygiene::VariableChecker.new(key, wrapper)
        checker.mismatch_details if checker.mismatched_variables_found?
      end

      mismatched_variables.each { |details| puts details }

      puts "Finished checking.\n\n"

      exit(1) if mismatched_variables.any?
    end

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
