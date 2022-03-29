require 'gtk3'
require 'gdk3'


class LevelSelector

    @ListeNiveaux

    #private_class_method :new

    def initialize(fenetre, diff)

        builder = Gtk::Builder.new()
        builder.add_from_file("../asset/glade/LevelSelector.glade")
        builder.get_object('mainWindow').remove(builder.get_object("levels"))

        main = fenetre
        main.add(builder.get_object("levels"))
        mainColor = Gdk::RGBA::parse("#003049")
        secondColor = Gdk::RGBA::parse("#00507a")
        main.override_background_color(:'normal', mainColor)

        listbox = builder.get_object('listbox')
        listbox.override_background_color(:'normal', secondColor)
        main.set_title("Main menu")


        @ListeNiveaux = Array.new()
        @ListeButton = Array.new()
        @ListeLabels = Array.new()
        @files = Dir.glob("../levels/"+diff+"/*")

        @files.each{ |n| @ListeNiveaux.push(File.basename(n,"*"))}
        puts(@ListeNiveaux)
        @ListeNiveaux.each{ |n| 
        label = Gtk::Label.new(n)
        @ListeLabels.push(label)

        button = Gtk::Button.new()
        button.add(label);
        button.override_background_color(:'normal', secondColor)
        button.relief = Gtk::ReliefStyle::NONE
        @ListeButton.push(button)
        
        
        }
        @ListeLabels.each{ |n| n.name = "BTNLVL"}
        
        @ListeButton.each{ |n| n.signal_connect "clicked" do |_widget|
            puts "Hello World!!"
          end}
   
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
    main.signal_connect("delete-event") { |_widget| Gtk.main_quit }
    main.show_all
        end

end

