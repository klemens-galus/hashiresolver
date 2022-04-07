require 'gtk3'
require_relative 'ArcadeMenu'
require_relative 'ClassementMenu'
require_relative 'Astuces'
require_relative './UI/AppColors'

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

    @window.override_background_color(:normal, AppColors::MAIN_COLOR)

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

    arcade_btn = @builder.get_object('arcadeBtn')
    arcade_btn.signal_connect('clicked') do
      arcade
    end

    classement_btn = @builder.get_object('classementBtn')
    classement_btn.signal_connect('clicked') do
      classement
    end

    tuto_btn = @builder.get_object('tutoBtn')
    tuto_btn.signal_connect('clicked') do
      tuto
    end

    retour_btn = @builder.get_object('retourBtn')
    retour_btn.signal_connect 'clicked' do
      clear_window
      MenuProfil.new(@window)
    end

    # Gestion du hover sur le bouton retour
    retour_btn.signal_connect('enter-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return_hover.png')
    end

    retour_btn.signal_connect('leave-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return.png')
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

  def tuto
    clear_window
    Astuces.new(@window, @pseudo)
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('mainMenuBox'))
  end
end
