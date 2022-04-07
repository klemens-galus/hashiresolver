require 'gtk3'

module AppColors
  MAIN_COLOR = Gdk::RGBA.parse('#003049')
  SECOND_COLOR = Gdk::RGBA.parse('#00507a')

  BUTTON_JEU = Gdk::RGBA.parse('#e9e1b7')
  PANNEAU_AIDE_JEU = Gdk::RGBA.parse('#004366')
  PANNEAU_JEU = Gdk::RGBA.parse('#00507a')

  ILE_TEXTE_NORMAL = Gdk::RGBA.new(1, 1, 1, 1)
  ILE_TEXTE_COMPLETE = Gdk::RGBA.new(0, 1, 0, 1)
  ILE_TEXTE_SELECTION = Gdk::RGBA.new(1, 0, 0, 1)
  ILE_BACKGROUND_AIDE = Gdk::RGBA.new(0.435, 0.529, 0.427, 1)
  ILE_BACKGROUND_TRANSPARENT = Gdk::RGBA.new(1, 1, 1, 0)
end
