require 'gtk3'
require 'gdk3'
require 'yaml'
require './MainMenu'

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
    @second_color = Gdk::RGBA.parse('#00507a')

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

    button = Gtk::Button.new
    button.add(label)
    button.override_background_color(:normal, @secondColor)
    button.relief = :none

    button.signal_connect 'clicked' do
      clear_window
      MainMenu.new(@window, profil)
    end

    @list_box.add(button)

    @window.show_all
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

    main_color = Gdk::RGBA.parse('#003049')

    @window.override_background_color(:normal, main_color)

    @list_box = @builder.get_object('listbox')
    @list_box.override_background_color(:normal, @second_color)

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
    popup = Gtk::Window.new('First example')
    popup.show
    popup.set_title '// Edit //'

    box = Gtk::Box.new(:vertical, 10)

    text = Gtk::Entry.new
    text.set_text 'Entrez votre nom'

    box.add(text)

    button = Gtk::Button.new 'Valider'
    button.signal_connect 'clicked' do
      create_profil(text.text)
      popup.close
    end
    box.add(button)

    popup.add box
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

      Gtk::MessageDialog.new(
        parent: nil,
        flags: 0,
        type: :error,
        buttons: :none,
        message: 'Profil déjà existant').show_all

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
