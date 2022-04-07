require 'gtk3'
require 'gdk3'
require_relative 'MainMenu'
require_relative './UI/AppColors'

#
# Menu qui contient des textes pour la compréhension du jeu
#
class Astuces

  # @pseudo Utilisé pour repasser le pseudo du joueur au menu principal en cas de retour
  # @numero_courant Numéro actuel de la page affiché
  # @window Fenêtre qui contient ce menu
  # @builder Builder Gtk pour implementer le fichier Glade
  # @pages_text Array contenant les différents textes du tuto
  # @text_buffer_page Buffer utilisé pour l'affichage du texte dans la text_view
  # @text_view_page TextView utilisé pour l'affichage du texte

  def initialize(fenetre, pseudo)
    @pseudo = pseudo
    @numero_courant = 0

    build_interface(fenetre)
    populate_liste_pages
    setup_text_view
    apply_css
    connect_signals
    afficher_page(@numero_courant)

    @window.show_all
  end

  #
  # Chargement des composants graphiques Gtk dans la fenetre
  #
  # @param [Gtk::Window] fenetre Fenêtre dans laquelle le menu va s'afficher
  #
  def build_interface(fenetre)
    @builder = Gtk::Builder.new
    @builder.add_from_file('../asset/glade/Astuces.glade')
    @builder.get_object('mainWindow').remove(@builder.get_object('astuces'))

    @window = fenetre
    @window.add(@builder.get_object('astuces'))
    @window.override_background_color(:normal, AppColors::MAIN_COLOR)

    @window.set_title('Astuces')
  end

  #
  # Charge les pages du tuto présentent dans le dossier texte des assets
  #
  def populate_liste_pages
    # Récuperation des fichiers correspondants aux pages du tuto
    fichier_pages = Dir.glob('../asset/textes/*')

    @pages_text = []

    # Lecture des fichiers
    fichier_pages.each do |fichier_page|
      @pages_text << File.open(fichier_page).read
    end
  end

  #
  # Affiche le texte correspondant à la page dans la text_view
  #
  # @param [int] numero Numéro de la page
  #
  def afficher_page(numero)
    # Affichage du texte
    @text_buffer_page.set_text(@pages_text[numero])

    # Mise a jour du compteur de pages
    pages_num_label = @builder.get_object('pagesNumLabel')
    pages_num_label.set_text("Page #{numero + 1}/#{@pages_text.length}")
  end

  #
  # Application du css aux composants Gtk
  #
  def apply_css
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
        #text_view_page{
            font-family: "Pixellari";
            font-size: 25px;
        }
        button:hover{
          background: transparent;
        }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
    @text_view_page.override_background_color(:normal, AppColors::SECOND_COLOR)
  end

  #
  # Initialisation du text_view et de son buffer
  #
  def setup_text_view
    @text_view_page = @builder.get_object('viewtext')

    # Création d'un buffer pour la transmission du texte
    @text_buffer_page = Gtk::TextBuffer.new
    @text_view_page.set_buffer @text_buffer_page

    # Nom pour le css
    @text_view_page.name = 'text_view_page'
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    retour_btn = @builder.get_object('retourBtn')
    retour_btn.signal_connect('clicked') do
      clear_window
      MainMenu.new(@window, @pseudo)
    end

    # Gestion du hover sur le bouton retour
    retour_btn.signal_connect('enter-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return_hover.png')
    end
    retour_btn.signal_connect('leave-notify-event') do
      @builder.get_object('retourImage').set_from_file('../asset/images/return.png')
    end

    # Affichage de la page précédente
    page_precedente_btn = @builder.get_object('backBtn')
    page_precedente_btn.signal_connect('clicked') do
      if @numero_courant.positive?
        @numero_courant -= 1
        afficher_page(@numero_courant)
      end
    end

    # Gestion hover du bouton page précédente
    page_precedente_btn.signal_connect('enter-notify-event') do
      @builder.get_object('backImg').set_from_file('../asset/images/boutons/gauche/gauche_hover.png')
    end
    page_precedente_btn.signal_connect('leave-notify-event') do
      @builder.get_object('backImg').set_from_file('../asset/images/boutons/gauche/gauche.png')
    end

    # Affichage de la page suivante
    page_suivante_btn = @builder.get_object('forwBtn')
    page_suivante_btn.signal_connect('clicked') do
      if @numero_courant < @pages_text.length - 1
        @numero_courant += 1
        afficher_page(@numero_courant)
      end
    end

    # Gestion hover du bouton page suivante
    page_suivante_btn.signal_connect('enter-notify-event') do
      @builder.get_object('forwImg').set_from_file('../asset/images/boutons/droite/droite_hover.png')
    end
    page_suivante_btn.signal_connect('leave-notify-event') do
      @builder.get_object('forwImg').set_from_file('../asset/images/boutons/droite/droite.png')
    end

    @window.signal_connect('delete-event') { Gtk.main_quit }
  end

  #
  # Methode qui vide la fenêtre. A utiliser avant de léguer la fenêtre à un nouveau menu
  #
  def clear_window
    @window.remove(@builder.get_object('astuces'))
  end
end
