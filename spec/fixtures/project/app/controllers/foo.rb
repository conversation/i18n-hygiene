class FooController
  def show
    dynamic_translation = I18n.t("dynamic", scope: "translation")
  end
end
