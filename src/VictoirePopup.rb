require 'gtk3'
require 'yaml'
require_relative './UI/AppColors.rb'


class VictoirePopup



  class VictoirePopup
    # Affichage du popup de selection du nom du nouveau profil

    def self.popup(score)
      builder = Gtk::Builder.new
      builder.add_from_file('../asset/glade/VictoirePopup.glade')

      window = builder.get_object('VictoirePopupWindow')
      window.override_background_color(:normal, AppColors::MAIN_COLOR)

      builder.get_object('quitterBtn').signal_connect 'clicked' do
        window.close
      end

      message_label = builder.get_object('messageLabel')
      message_label.set_text(message_label.text << " " << score.to_s)

      window.show_all
    end
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('victoire'))
  end

end
