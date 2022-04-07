require 'gtk3'
require_relative 'LevelSelector'
require_relative './Jeu/Grille'
require_relative './Jeu/Chronometre'
require_relative './Util/Sauvegardeur'

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

    build_interface(fenetre)
    apply_css
    connect_signals
    creer_grille
    start_chrono
    charger_niveau_profil
  end

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder.add_from_file('../asset/glade/grilleJeu.glade')

    @window = fenetre

    # Liberation de la Box principale qui ne peux etre ratachée qu'a une seule fenêtre
    @builder.get_object('mainWindow').remove(@builder.get_object('grilleJeuBox'))

    # Ajout du contenu du menu dans la fenêtre
    @window.add(@builder.get_object('grilleJeuBox'))

    # Style
    @window.set_title('Jeu')

    main_color = Gdk::RGBA.parse('#003049')
    btn_color = Gdk::RGBA.parse('#e9e1b7')
    @window.override_background_color(:normal, main_color)

    panneau_gauche_box = @builder.get_object('panneauGaucheBox')
    panneau_gauche_box.override_background_color(:normal, Gdk::RGBA.parse('#004366'))

    panneau_haut_box = @builder.get_object('panneauHautBox')
    panneau_haut_box.override_background_color(:normal, Gdk::RGBA.parse('#00507a'))

    panneau_bas_box = @builder.get_object('panneauBasBox')
    panneau_bas_box.override_background_color(:normal, Gdk::RGBA.parse('#00507a'))

    aide_box = @builder.get_object('aideBox')
    aide_box.override_background_color(:normal, Gdk::RGBA.parse('#004366'))

    aide_btn = @builder.get_object('aideBtn')
    aide_btn.override_background_color(:normal, btn_color)

    verifier_btn = @builder.get_object('verifierBtn')
    verifier_btn.override_background_color(:normal, btn_color)

    hypo_btn = @builder.get_object('hypoBtn')
    hypo_btn.override_background_color(:normal, btn_color)

    fin_hypo_btn = @builder.get_object('finHypoBtn')
    fin_hypo_btn.override_background_color(:normal, btn_color)

    undo_btn = @builder.get_object('undoBtn')
    undo_btn.override_background_color(:normal, btn_color)

    redo_btn = @builder.get_object('redoBtn')
    redo_btn.override_background_color(:normal, btn_color)

    @builder.objects.each do |n|
      n.name = 'btn' if n.builder_name.end_with?('Btn')
      n.name = 'box' if n.builder_name.end_with?('Box')
    end
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
    sauvegarder_grille
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

    # Placement de la grille dans le menu
    @builder.get_object('grilleJeuBox').pack_start(@jeu_grille, expand: true, fill: true, padding: 0)

    @window.show_all
  end

  #
  # Sasuvegarde la grille dans le fichier du joueur
  #
  def sauvegarder_grille
    stop_chrono
    Sauvegardeur.sauvegarder_niveau_arcade(@diff, @niveau, @pseudo, @jeu_grille, @chrono)
  end

  #
  # Charge les ponts présents dans le fichier du joueur
  #
  def charger_niveau_profil
    fichier_profil = File.open("../saves/#{@pseudo}.yml", 'r')

    data_profil = YAML.load(fichier_profil.read)

    # Verification de la présence du niveau dans le fichier du joueur
    return unless data_profil[:arcade][@diff.to_sym].key?(@niveau.to_sym)

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
  end
end
