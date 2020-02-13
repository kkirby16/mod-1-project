require_relative "../config/environment"
require_relative "../lib/cli"

puts "HELLO WORLD"

cli = CommandLineInterface.new
cli.greet
cli.main_menu_options
