require 'gtk3'
require './ArcadeMenu'
require './ClassementMenu'

#
# Menu principale
#
class MainMenu
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] pseudo Pseudo du joueur
  #
  def initialize(fenetre, pseudo)
    @pseudo = pseudo
    @builder = Gtk::Builder.new

    build_interface(fenetre)
    connect_signals
  end

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/mainMenu.glade')

    @window = fenetre

    # Liberation de la Box principale qui ne peux etre ratachée qu'a une seule fenêtre
    @builder.get_object('mainWindow').remove(@builder.get_object('mainMenuBox'))

    # Ajout du contenu du menu dans la fenêtre
    @window.add(@builder.get_object('mainMenuBox'))

    # Style
    @window.set_title('Main Menu')

    main_color = Gdk::RGBA.parse('#003049')
    @window.override_background_color(:normal, main_color)

    bienvenue_label = @builder.get_object('bienvenueLabel')
    bienvenue_label.set_text("Bienvenue #{@pseudo}")
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    @window.signal_connect 'destroy' do
      Gtk.main_quit
    end

    continuer_btn = @builder.get_object('continuerBtn')
    continuer_btn.signal_connect('clicked') do
      play
    end

    arcade_btn = @builder.get_object('arcadeBtn')
    arcade_btn.signal_connect('clicked') do
      arcade
    end

    classement_btn = @builder.get_object('classementBtn')
    classement_btn.signal_connect('clicked') do
      classement
    end
  end

  #
  # Affichage du menu
  #
  def show
    @window.show_all
    Gtk.main
  end

  #
  # Lancement du mode aventure
  #
  def play
    puts('Lancement jeu')
  end

  #
  # Lancement du mode arcade
  #
  def arcade
    puts("je lance l'arcade")
    clear_window
    ArcadeMenu.new(@window, @pseudo)
  end

  #
  # Lancement du menu de classement
  #
  def classement
    puts('je lance classement')
    clear_window
    ClassementMenu.new(@window, @pseudo)
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('mainMenuBox'))
  end
end
