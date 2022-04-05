require 'gtk3'
require 'gdk3'
require 'yaml'


class MenuProfil

    @listeProfil
    #private_class_method :new

    def initialize(fenetre)

      @builder = Gtk::Builder.new()
      @builder.add_from_file("../asset/glade/menuProfil.glade")
      main = @builder.get_object('profilWindow')

      mainColor = Gdk::RGBA::parse("#003049")
      secondColor = Gdk::RGBA::parse("#00507a")
      main.override_background_color(:'normal', mainColor)

      listbox = @builder.get_object('listbox')
      listbox.override_background_color(:'normal', secondColor)
      main.set_title("Menu profil")


      @ListeProfil = Array.new()
      @ListeButton = Array.new()
      @ListeLabels = Array.new()
      @files = Dir.glob("../save/*")

      @files.each do |n| 
        @ListeProfil.push(File.basename(n,"*"))
      end

      puts(@ListeProfil)
      @ListeProfil.each do |n|
        label = Gtk::Label.new(n)
        @ListeLabels.push(label)

        button = Gtk::Button.new()
        button.add(label);
        button.override_background_color(:'normal', secondColor)
        button.relief = :none
        @ListeButton.push(button)

      end


      #save
      newProfilButton = @builder.get_object("newProfilButton")
      newProfilLabel = @builder.get_object("newProfilLabel")
      newProfilButton.signal_connect "clicked" do
        puts "nouveau profil"
        showNewProfilPopup()
      end

      @ListeLabels.each do |n| 
        n.name = "BTNLVL"
      end

      @ListeButton.each do |n| 
        n.signal_connect "clicked" do |_widget|
          puts "Hello World!!"
        end
      end

      provider = Gtk::CssProvider.new()
      provider.load(data: <<-CSS)
      #BTNLVL{
          font-family: "Pixellari";
          font-size: 65px;
      }
      CSS
      Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)

      @ListeButton.each{ |n| listbox.add(n)}


      button = Gtk::Button.new(:label => "Say hello")
      button.signal_connect "clicked" do |_widget|
        puts "Hello World!!"
      end

      #main.add(button)
      main.signal_connect("delete-event") do |_widget| 
        Gtk.main_quit
      end

      main.show_all

    end


    def showNewProfilPopup()
      #popup
      popup = Gtk::Window.new("First example")
      popup.show
      popup.set_title "// Edit //"


      box = Gtk::Box.new(:vertical, 10) 

      text = Gtk::Entry.new
      text.set_text "Entrez votre nom"

      box.add(text)

      button = Gtk::Button.new "Valider"
      button.signal_connect "clicked" do
        createProfil(text.text)
        popup.close()
      end
      box.add(button)

      popup.add box
      popup.show_all
    end

    def createProfil(name)
      puts "creation profil de " + name
      File.new("../save/"+name+".yml","w+")
    end

end


a = MenuProfil.new()
Gtk.main()
