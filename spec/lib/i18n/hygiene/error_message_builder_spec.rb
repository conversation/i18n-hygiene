require "i18n/hygiene/error_message_builder"

RSpec.describe I18n::Hygiene::ErrorMessageBuilder do
  let(:builder) { I18n::Hygiene::ErrorMessageBuilder.new }

  describe "#create" do
    context "defaults" do
      it "builds a colourised string" do
        expect(builder.create).to eq <<~STRING

          \e[31mi18n-hygiene/Unspecified Error:\e[0m
            unknown_key
        STRING
      end
    end

    context "setting all the things" do
      before do
        builder
          .title("Condiment Missing")
          .locale("ja")
          .key("ketchup")
          .translation("ケチャップ")
          .expected("lots of ketchup use!")
      end

      it "builds a colourised string" do
        expect(builder.create).to eq <<~STRING

          \e[31mi18n-hygiene/Condiment Missing:\e[0m
            ja.ketchup: \e[33m\"ケチャップ"\e[0m
              Expected: \e[38;5;214mlots of ketchup use!\e[0m
        STRING
      end
    end
  end
end
