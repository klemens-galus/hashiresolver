require 'gtk3'
require 'yaml'
require_relative './UI/AppColors.rb'


class VictoirePopup



# Affichage du popup de sélection du nom du nouveau profil
  def self.popup(score)
    builder = Gtk::Builder.new
    builder.add_from_file('../../asset/glade/VictoirePopup.glade')

    builder.get_object('VictoirePopup').remove(builder.get_object('VictoirePopup'))


    window.add(builder.get_object('VictoirePopup'))


    window.override_background_color(:normal, AppColors::MAIN_COLOR)

    # popup
    popup = Gtk::Window.new('Victoire')

    # button = Gtk::Button.new 'close'
    # score_text = Gtk::Label.new
    # button.signal_connect 'clicked' do
    #   popup.close
    # end
    #
    # popup.add(score_text)
    # popup.add(button)
    # popup.show_all
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de léguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('victoire'))
  end

end
