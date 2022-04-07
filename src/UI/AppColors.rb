require 'gtk3'

module AppColors
  MAIN_COLOR = Gdk::RGBA.parse('#003049')
  SECOND_COLOR = Gdk::RGBA.parse('#00507a')

  ILE_TEXTE_NORMAL = Gdk::RGBA.new(1, 1, 1, 1)
  ILE_TEXTE_COMPLETE = Gdk::RGBA.new(0, 1, 0, 1)
  ILE_TEXTE_SELECTION = Gdk::RGBA.new(1, 0, 0, 1)
end
