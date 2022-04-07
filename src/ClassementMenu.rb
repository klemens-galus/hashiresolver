require 'gtk3'
require 'gdk3'
require './MainMenu'
require 'yaml'

#
# Menu de classement des scores des joueurs
#
class ClassementMenu
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher
  # @list_box Composant graphique pour l'affichage du classement

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
    populate_classement_list
    apply_css
    connect_signals

    @window.show_all
  end

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/ClassementMenu.glade')

    # Liberation de la Box principale qui ne peux etre ratachée qu'a une seule fenêtre
    @builder.get_object('mainWindow').remove(@builder.get_object('classementBox'))

    @window = fenetre

    # Ajout du contenu du menu dans la fenêtre
    @window.add(@builder.get_object('classementBox'))

    # Style
    main_color = Gdk::RGBA.parse('#003049')
    second_color = Gdk::RGBA.parse('#00507a')
    @window.override_background_color(:normal, main_color)

    @list_box = @builder.get_object('listbox')
    @list_box.override_background_color(:normal, second_color)

    @window.set_title('Selection du niveau')
  end

  #
  # Rempli le composant graphique du classement avec les scores des joueurs sur
  #
  def populate_classement_list
    liste_scores = {}

    # Récuperation de tous les profils
    files = Dir.glob('../saves/*')

    # Récuperation des scores
    files.each do |n|
      liste_scores[File.basename(n, '.*')] = calculer_score_joueur(n)
    end

    # Tri de la liste en fonction des scores et affichage
    liste_scores.sort_by { |_name, score| score }.reverse.each do |name, score|
      label = Gtk::Label.new("#{name} : #{score}")
      label.name = 'score'

      @list_box.add(label)
    end
  end

  def calculer_score_joueur(fichier_joueur)
    data_joueur = YAML.load(File.read(fichier_joueur))

    score_total = 0

    data_joueur[:arcade].each_key do |difficulte_symbol|
      data_joueur[:arcade][difficulte_symbol].each_key do |niveau_symbol|
        score_total += data_joueur[:arcade][difficulte_symbol][niveau_symbol][:score] if data_joueur[:arcade][difficulte_symbol][niveau_symbol][:etat] == EtatJeu::GAGNE
      end
    end

    score_total
  end

  #
  # Application du css aux composants graphiques Gtk
  #
  def apply_css
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
        #score{
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
      MainMenu.new @window, @pseudo
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
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('classementBox'))
  end
end
