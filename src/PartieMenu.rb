require 'gtk3'
require_relative 'LevelSelector'
require_relative './Jeu/Grille'
require_relative './Jeu/Chronometre'
require_relative './Util/Sauvegardeur'
require_relative './Util/Solveur'
require_relative './Jeu/EtatJeu'
require_relative './UI/AppColors'


#
# Menu lors d'une partie
#
class PartieMenu
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher
  # @diff Difficulté des niveaux de ce menu
  # @niveau Niveau choisi
  # @jeu_grille Grille qui contient les iles et les cases
  # @chrono Chronometre pour la gestion du temps
  # @aide_label Texte pour l'affichage des aides
  # @solveur Outil d'aide à la résolution de la grille
  # @etat Etat du jeu en cours (gagné ou en cours)

  attr :aide_label, true
  attr :etat, true
  attr_reader :diff, :chrono

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] diff Difficulté choisie
  # @param [String] pseudo Pseudo du joueur
  #
  def initialize(fenetre, diff, pseudo, niveau)
    @pseudo = pseudo
    @builder = Gtk::Builder.new
    @diff = diff
    @niveau = niveau
    @etat = EtatJeu::EN_COURS

    build_interface(fenetre)

    apply_css
    connect_signals
    creer_grille
    @solveur = Solveur.new(@jeu_grille, self)
    start_chrono 
    charger_niveau_profil
    stop_chrono if @etat == EtatJeu::GAGNE
  end

  attr_reader :chrono

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/grilleJeu.glade')

    @window = fenetre
    @aide_label = @builder.get_object('aideLabel')

    # Liberation de la Box principale qui ne peux etre ratachée qu'a une seule fenêtre
    @builder.get_object('mainWindow').remove(@builder.get_object('grilleJeuBox'))

    # Ajout du contenu du menu dans la fenêtre
    @window.add(@builder.get_object('grilleJeuBox'))

    # Style
    @window.set_title('Jeu')

    @window.override_background_color(:normal, AppColors::MAIN_COLOR)

    panneau_gauche_box = @builder.get_object('panneauGaucheBox')
    panneau_gauche_box.override_background_color(:normal, AppColors::PANNEAU_AIDE_JEU)

    panneau_haut_box = @builder.get_object('panneauHautBox')
    panneau_haut_box.override_background_color(:normal, AppColors::PANNEAU_JEU)

    panneau_bas_box = @builder.get_object('panneauBasBox')
    panneau_bas_box.override_background_color(:normal, AppColors::PANNEAU_JEU)

    aide_box = @builder.get_object('aideBox')
    aide_box.override_background_color(:normal, AppColors::PANNEAU_AIDE_JEU)

    aide_btn = @builder.get_object('aideBtn')
    aide_btn.override_background_color(:normal, AppColors::BUTTON_JEU)

    undo_btn = @builder.get_object('undoBtn')
    undo_btn.override_background_color(:normal, AppColors::BUTTON_JEU)

    redo_btn = @builder.get_object('redoBtn')
    redo_btn.override_background_color(:normal, AppColors::BUTTON_JEU)

    @builder.objects.each do |n|
      n.name = 'btn' if n.builder_name.end_with?('Btn')
    end

    panneau_gauche_box.name = 'box'
    panneau_haut_box.name = 'box'
    panneau_bas_box.name = 'box'
    aide_box.name = 'box'

  end

  #
  # Application du css aux composants graphiques Gtk
  #
  def apply_css
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
        #box{
            border: 1px solid black;
        }

        #btn{
            font-family: Arial;
            font-size: 15px;
            border-radius: 0;
            color: black;
    }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider,
                                              Gtk::StyleProvider::PRIORITY_APPLICATION)
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    back_btn = @builder.get_object('backBtn')
    back_btn.signal_connect('clicked') do
      back
    end

    @builder.get_object('aideBtn').signal_connect('clicked') do
      demande_aide
    end

    undo_btn = @builder.get_object('undoBtn')
    undo_btn.signal_connect('clicked') do
      @jeu_grille.undo()

    end
    redo_btn = @builder.get_object('redoBtn')
    redo_btn.signal_connect('clicked') do
      @jeu_grille.redo()
    end
  end

  def start_chrono
    @chrono = Chronometre.new(@builder.get_object('tempsLabel'))
    @chrono.start
  end

  def stop_chrono
    @chrono.stop
  end

  #
  # Retour sur la selection de niveau
  #
  def back
    sauvegarder_grille(@jeu_grille.calcul_score)
    clear_window
    LevelSelector.new(@window, @diff, @pseudo)
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('grilleJeuBox'))
  end

  #
  # Création de la grille de jeu (la grille s'occupe du déroulement du jeu)
  #
  def creer_grille
    puts "création de la grille #{@niveau} : #{@diff}"

    @jeu_grille = Grille.new(@diff, @niveau, self)
    @jeu_grille.set_column_homogeneous(true)
    @jeu_grille.set_row_homogeneous(true)
    @UndoRedo = UndoRedo.new(@jeu_grille)
    # Placement de la grille dans le menu
    @builder.get_object('grilleJeuBox').pack_start(@jeu_grille, expand: true, fill: true, padding: 0)

    @window.show_all
  end

  #
  # Sasuvegarde la grille dans le fichier du joueur
  #
  def sauvegarder_grille(score)
    stop_chrono
    Sauvegardeur.sauvegarder_niveau_arcade(@diff, @niveau, @pseudo, @jeu_grille, @chrono, score, @etat)
  end

  #
  # Charge les ponts présents dans le fichier du joueur
  #
  def charger_niveau_profil
    fichier_profil = File.open("../saves/#{@pseudo}.yml", 'r')

    data_profil = YAML.load(fichier_profil.read)

    # Verification de la présence du niveau dans le fichier du joueur
    return unless data_profil[:arcade][@diff.to_sym].key?(@niveau.to_sym)

    # Lecture de l'état du niveau
    @etat = data_profil[:arcade][@diff.to_sym][@niveau.to_sym][:etat]

    # Données concernants les ponts
    data_pont = data_profil[:arcade][@diff.to_sym][@niveau.to_sym][:ponts]

    nb_ponts = data_pont[:ile_debut].length

    # Remise en place des ponts
    (0..nb_ponts - 1).each do |i|
      ile_debut = @jeu_grille.get_child_at(data_pont[:ile_debut][i].split(',')[0].to_i, data_pont[:ile_debut][i].split(',')[1].to_i)
      ile_fin = @jeu_grille.get_child_at(data_pont[:ile_fin][i].split(',')[0].to_i, data_pont[:ile_fin][i].split(',')[1].to_i)

      @jeu_grille.creer_pont(ile_debut, ile_fin) if data_pont[:double][i]

      @jeu_grille.creer_pont(ile_debut, ile_fin)
    end

    # Remise en place du chrono
    @chrono.temps = data_profil[:arcade][@diff.to_sym][@niveau.to_sym][:temps]
    @builder.get_object('tempsLabel').set_text(@chrono.second_beautifull)

    @jeu_grille.desactiver_iles if @etat == EtatJeu::GAGNE
  end

  def demande_aide
    @solveur.analyser_grille if @etat == EtatJeu::EN_COURS
  end
end
