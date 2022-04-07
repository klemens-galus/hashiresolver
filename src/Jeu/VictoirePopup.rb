require 'gtk3'
require 'yaml'
require_relative '../UI/AppColors'


class VictoirePopup

# Affichage du popup de selection du nom du nouveau profil

  def self.popup(score)
    builder = Gtk::Builder.new
    builder.add_from_file('../asset/glade/VictoirePopup.glade')

    builder.get_object('VictoirePopupWindow').remove(builder.get_object('VictoirePopupBox'))


    window.add(builder.get_object('VictoirePopupWindow'))


    window.override_background_color(:normal, AppColors::MAIN_COLOR)


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
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    window.remove(builder.get_object('VictoirePopupWindow'))
  end

end
