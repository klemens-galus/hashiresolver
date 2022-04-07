require 'gtk3'
require 'gdk3'
require_relative 'MainMenu'
require_relative './UI/AppColors'

class Astuces

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

  def build_interface(fenetre)
    @builder = Gtk::Builder.new
    @builder.add_from_file('../asset/glade/Astuces.glade')
    @builder.get_object('mainWindow').remove(@builder.get_object('astuces'))

    @window = fenetre
    @window.add(@builder.get_object('astuces'))
    @window.override_background_color(:normal, AppColors::MAIN_COLOR)

    @window.set_title('Astuces')
  end

  def populate_liste_pages
    fichier_pages = Dir.glob('../asset/textes/*')

    @pages_text = []

    fichier_pages.each do |fichier_page|
      @pages_text << File.open(fichier_page).read
    end
  end

  def afficher_page(numero)
    @text_buffer_page.set_text(@pages_text[numero])
    pages_num_label = @builder.get_object('pagesNumLabel')
    pages_num_label.set_text("Page #{numero + 1}/#{@pages_text.length}")
  end

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

  def setup_text_view
    @text_view_page = @builder.get_object('viewtext')
    @text_buffer_page = Gtk::TextBuffer.new
    @text_view_page.set_buffer @text_buffer_page
    @text_view_page.name = 'text_view_page'
  end

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

    @window.signal_connect('delete-event') { |_widget| Gtk.main_quit }
  end

  def clear_window
    @window.remove(@builder.get_object('astuces'))
  end
end
