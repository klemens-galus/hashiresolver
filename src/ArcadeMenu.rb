require 'gtk3'
require './LevelSelector'

#
# Menu de selection de la difficulté du mode arcade
#
class ArcadeMenu
  # @pseudo pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] pseudo du joueur
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
    @builder.add_from_file('../asset/glade/arcadeMenu.glade')

    @window = fenetre

    # Liberation de la Box principale qui ne peux etre ratachée qu'a une seule fenêtre
    @builder.get_object('mainWindow').remove(@builder.get_object('arcadeBox'))

    # Ajout du contenu du menu dans la fenêtre
    @window.add(@builder.get_object('arcadeBox'))

    # Style
    @window.set_title('Arcade')

    bienvenue_label = @builder.get_object('bienvenueLabel')
    bienvenue_label.set_text("Bienvenue #{@pseudo}")
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    @window.signal_connect('destroy') do
      Gtk.main_quit
    end

    facile_btn = @builder.get_object('facileBtn')
    facile_btn.signal_connect('clicked') do
      facile
    end

    normal_btn = @builder.get_object('normalBtn')
    normal_btn.signal_connect('clicked') do
      normal
    end

    difficile_btn = @builder.get_object('difficileBtn')
    difficile_btn.signal_connect('clicked') do
      difficile
    end

    retour_btn = @builder.get_object('retourBtn')
    retour_btn.signal_connect('clicked') do
      retour
    end

    # Gestion du hover du bouton retour
    retour_btn.signal_connect('enter-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return_hover.png')
    end
    retour_btn.signal_connect('leave-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return.png')
    end
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('arcadeBox'))
  end

  #
  # Lancement du menu avec les niveaux faciles
  #
  def facile
    puts('Facile')
    clear_window
    LevelSelector.new(@window, 'facile', @pseudo)
  end

  #
  # Lancement du menu avec les niveaux normaux
  #
  def normal
    puts('Normal')
    clear_window
    LevelSelector.new(@window, 'normal', @pseudo)
  end

  #
  # Lancement du menu avec les niveaux difficiles
  #
  def difficile
    puts('Difficile')
    clear_window
    LevelSelector.new(@window, 'difficile', @pseudo)
  end

  #
  # Retour au menu principale
  #
  def retour
    clear_window
    MainMenu.new(@window, @pseudo)
  end
end
