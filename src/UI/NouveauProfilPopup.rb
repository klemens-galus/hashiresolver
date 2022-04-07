require 'gtk3'
require_relative 'AppColors'

class NouveauProfilPopup < Gtk::Window
  # @builder Builder gtk pour la mise en place du fichier Glade
  # @pseudo_entry Boite de texte qui contient le pseudo choisi par le joueur
  # @valider_button Le bouton de validation du popup

  attr_reader :valider_button, :pseudo_entry

  def initialize
    super('Nouveau Profil')
    build_interface
  end

  def build_interface
    @builder = Gtk::Builder.new
    @builder.add_from_file('../asset/glade/NouveauProfilPopup.glade')

    @builder.get_object('window').remove(@builder.get_object('contentBox'))

    add(@builder.get_object('contentBox'))

    @valider_button = @builder.get_object('validerBtn')

    @pseudo_entry = @builder.get_object('pseudoEntry')
    @pseudo_entry.signal_connect 'activate' do
      @valider_button.activate
    end

    annuler_button = @builder.get_object('annulerBtn')
    annuler_button.signal_connect 'clicked' do
      close
    end
  end
end
