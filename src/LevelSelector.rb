require 'gtk3'
require 'gdk3'
require './ArcadeMenu'
require './PartieMenu'

#
# Menu de selection des niveaux du mode arcade
#
class LevelSelector
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher
  # @diff Difficulté des niveaux de ce menu
  # @second_color Couleur secondaire de ce menu

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] diff Difficulté choisie
  # @param [String] pseudo Pseudo du joueur
  #
  def initialize(fenetre, diff, pseudo)
    @pseudo = pseudo
    @builder = Gtk::Builder.new
    @diff = diff
    @second_color = Gdk::RGBA.parse('#00507a')

    build_interface(fenetre)
    apply_css
    connect_signals
    populate_niveaux_list

    @window.show_all
  end

  #
  # Rempli le composants graphiques Gtk qui affiche la liste des niveaux
  #
  def populate_niveaux_list
    liste_niveaux = []

    # Chargement des niveaux par raport à la difficulté choisie
    files = Dir.glob("../levels/#{@diff}/*")

    files.each do |fichier_niveau|
      liste_niveaux.push(File.basename(fichier_niveau, '.*'))
    end

    # Debug
    puts(liste_niveaux)

    liste_niveaux.each do |niveau|
      label = Gtk::Label.new(niveau)
      label.name = 'BTNLVL'

      button = Gtk::Button.new
      button.add(label)
      button.override_background_color(:normal, @second_color)
      button.relief = Gtk::ReliefStyle::NONE

      button.signal_connect 'clicked' do
        lancer_partie(niveau)
      end

      @list_box.add(button)
    end
  end

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/LevelSelector2.glade')

    @builder.get_object('mainWindow').remove(@builder.get_object('levels'))

    @window = fenetre
    @window.add(@builder.get_object('levels'))

    main_color = Gdk::RGBA.parse('#003049')
    @window.override_background_color(:normal, main_color)

    @list_box = @builder.get_object('listbox')
    @list_box.override_background_color(:normal, @second_color)
    @window.set_title(@diff.capitalize)
  end

  #
  # Application du css aux composants graphiques Gtk
  #
  def apply_css
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
        #BTNLVL{
            font-family: "Pixellari";
            font-size: 65px;
        }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider,
                                              Gtk::StyleProvider::PRIORITY_APPLICATION)
  end

  #
  # Gestions des signaux
  #
  def connect_signals
    retour_btn = @builder.get_object('retourBtn')
    retour_btn.signal_connect('clicked') do
      clear_window
      ArcadeMenu.new(@window, @pseudo)
    end

    # Gestion du hover sur le bouton retour
    retour_btn.signal_connect('enter-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return_hover.png')
    end
    retour_btn.signal_connect('leave-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return.png')
    end

    @window.signal_connect('delete-event') do
      Gtk.main_quit
    end
  end

  #
  # Lancement du menu de jeu avec le niveau choisi
  #
  def lancer_partie(niveau)
    clear_window
    PartieMenu.new(@window, @diff, @pseudo, niveau)
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('levels'))
  end
end
