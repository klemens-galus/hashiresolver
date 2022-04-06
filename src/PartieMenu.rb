require 'gtk3'
require './LevelSelector'
require './Aide'
require './Jeu/Grille'

#
# Menu lors d'une partie
#
class PartieMenu
  # @pseudo pseudo Pseudo du joueur
  # @builder Builder glade pour récuperer les composants graphiques
  # @window Fenetre dans laquelle le menu va s'afficher
  # @diff Difficulté des niveaux de ce menu

  #
  # Initialisation
  #
  # @param [Gtk::Window] fenetre Fenetre dans laquelle le menu va s'afficher
  # @param [String] diff Difficulté choisie
  # @param [String] pseudo Pseudo du joueur
  # @param [Integer] nb_indices Nombre d'indice demandés par le joueur
  # @param [Gtk::Label] indice_label Texte indiquant le nombre d'indice demandés par le joueur
  # @param [Gtk::Label] aide_label Texte indiquant une aide
  #
  def initialize(fenetre, diff, pseudo, niveau)
    @pseudo = pseudo
    @builder = Gtk::Builder.new
    @diff = diff
    @nb_indices = 0
    @niveau = niveau

    build_interface(fenetre)
    apply_css
    connect_signals
    creer_grille
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

    @aide_label = @builder.get_object('aideLabel')
    @indice_label = @builder.get_object('indiceLabel')

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

    aide_box.name = 'box'

    @builder.objects.each do |n|
      n.name = 'btn' if n.builder_name.end_with?('Btn')
      n.name = 'box' if n.builder_name.start_with?('panneau')
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
    aide_btn = @builder.get_object('aideBtn')
    aide_btn.signal_connect('clicked') do
      aide
    end

    back_btn = @builder.get_object('backBtn')
    back_btn.signal_connect('clicked') do
      back
    end
  end

  #
  # Affiche une aide en fonction du jeu en cours
  #
  def aide
    aide = Aide.new
    text = aide.verif_aide
    incr_indices
    @aide_label.set_text(text)
  end

  #
  # Incrémente le nombre d'indice demandés par le joueur
  #
  def incr_indices
    @nb_indices += 1
    @indice_label.set_text(@nb_indices.to_s)
  end

  #
  # Retour sur la selection de niveau
  #
  def back
    clear_window
    LevelSelector.new(@window, @diff, @pseudo)
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de leguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('grilleJeuBox'))
  end

  def creer_grille
    puts "création de la grille #{@niveau} : #{@diff}"

    jeu_grid = Grille.new(@diff, @niveau)
    jeu_grid.set_column_homogeneous(true)
    jeu_grid.set_row_homogeneous(true)

    @builder.get_object('grilleJeuBox').pack_start(jeu_grid, expand: true, fill: true, padding: 0)

    @window.show_all
  end
end
