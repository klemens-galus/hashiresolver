require 'gtk3'
require 'yaml'


class VictoirePopup < Gtk::Button

  #
  # Affichage du popup de selection du nom du nouveau profil
  #
  def self.popup(score)
    # popup
    popup = Gtk::Window.new('Victoire')

    button = Gtk::Button.new 'close'
    button.signal_connect 'clicked' do
      popup.close
    end


    popup.add(button)
    popup.show_all
  end

end