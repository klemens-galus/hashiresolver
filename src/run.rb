require 'gtk3'
require './MainMenu'

main_window = Gtk::Window.new()

main_window.set_window_position(Gtk::WindowPosition::CENTER)

main_window.set_default_size(1280, 720)

main_menu = MainMenu.new(main_window, 'Romain')
main_menu.show
