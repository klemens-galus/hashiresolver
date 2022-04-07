require 'gtk3'
require 'gdk3'
require 'yaml'
require_relative 'MainMenu'
require_relative './UI/AppColors'
require_relative './UI/NouveauProfilPopup'

#
# Menu de selection du profil
#
class MenuProfil
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] pseudo Pseudo du joueur
  #
  def initialize(fenetre)
    @builder = Gtk::Builder.new

    build_interface(fenetre)
    apply_css
    connect_signals
    populate_profil_list
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    @window.signal_connect('delete-event') do |_widget|
      Gtk.main_quit
    end
  end

  #
  # Fonction d'implementation des profils dans la liste
  #
  def populate_profil_list

    files = Dir.glob('../saves/*')

    files.each do |n|
      add_profil_to_list_box(File.basename(n, '.*'))
    end
  end

  #
  # Ajoute un profil à la liste des profils
  #
  # @param [String] profil Nom du profil à ajouter
  #
  def add_profil_to_list_box(profil)
    label = Gtk::Label.new(profil)
    label.name = 'profilLabel'

    profil_box = Gtk::Box.new(:horizontal, 5)
    profil_box.set_homogeneous(true)

    remove_button = Gtk::Button.new(label: '✖')
    remove_button.relief = :none
    remove_button.name = 'remove_button'

    remove_button.signal_connect('clicked') do
      supprimer_profile(profil)
    end

    button = Gtk::Button.new
    button.add(label)
    button.override_background_color(:normal, AppColors::SECOND_COLOR)
    button.relief = :none

    button.signal_connect 'clicked' do
      clear_window
      MainMenu.new(@window, profil)
    end

    profil_box.add(button)
    profil_box.add(remove_button)

    @list_box.add(profil_box)

    @window.show_all
  end

  def supprimer_profile(profil)
    File.delete("../saves/#{profil}.yml")

    clear_window
    MenuProfil.new(@window)
  end

  #
  # Application du css sur les composants Gtk
  #
  def apply_css
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
      #profilLabel{
          font-family: "Pixellari";
          font-size: 65px;
          color: #EAE2B7;
      }

      #remove_button{
        font-size: 80px;
        color: white;
       }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
  end

  #
  # Generation de la fenetre avec les composants du fichier glade
  #
  # @param [Gtk::Window] fenetre Fenêtre où vont être implémentés les composants Gtk
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/menuProfil2.glade')
    @window = fenetre

    @builder.get_object('mainWindow').remove(@builder.get_object('profils'))

    @window.add(@builder.get_object('profils'))

    @window.override_background_color(:normal, AppColors::MAIN_COLOR)

    @list_box = @builder.get_object('listbox')
    @list_box.override_background_color(:normal, AppColors::SECOND_COLOR)

    new_profil_button = @builder.get_object('newProfilButton')
    new_profil_button.signal_connect 'clicked' do
      puts 'nouveau profil'
      show_new_profil_popup
    end

    @window.set_title('Menu profil')
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('profils'))
  end

  #
  # Affichage du popup de selection du nom du nouveau profil
  #
  def show_new_profil_popup
    # popup
    popup = NouveauProfilPopup.new

    popup.valider_button.signal_connect 'clicked' do
      unless popup.pseudo_entry.text.empty? || popup.pseudo_entry.text.length > 10
        create_profil(popup.pseudo_entry.text)
        popup.close
      end
    end

    popup.show_all
  end

  #
  # Création d'un nouveau profil
  #
  # @param [String] name Nom du profil à créer
  #
  def create_profil(name)
    # Verification doublons
    if File.exist?("../saves/#{name}.yml")
      puts 'erreur ça exist deja'
      return
    end

    puts "creation profil de #{name}"
    f = File.open("../saves/#{name}.yml", 'w')

    # Données de base
    data = {
      arcade: {
        facile: {

        },
        normal: {

        },
        difficile: {

        }
      }
    }

    f.write(data.to_yaml)
    f.close

    # Ajout du profil à la liste
    add_profil_to_list_box(name)
  end

  #
  # Affichage de la fenetre
  #
  def show
    @window.show_all
    Gtk.main
  end
end
