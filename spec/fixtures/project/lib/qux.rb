module Qux
  def interpolate
    I18n.t("translation.interpolation", qux: "qux")
  end
end
