require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require './lib/gameplay'
require './lib/player'
require './lib/multiboats'

cruiser_user = Ship.new("Cruiser", 3)
submarine_user = Ship.new("Submarine", 2)
cruiser_computer = Ship.new("Cruiser", 3)
submarine_computer = Ship.new("Submarine", 2)
board_user = Board.new
board_computer = Board.new
computer = Computer.new(board_user, board_computer)
player = Player.new(board_user, board_computer)
multiboats = Multiboats.new(1)
game = Gameplay.new(board_user, board_computer, computer, player, cruiser_user, cruiser_computer, submarine_user, submarine_computer, multiboats)


game.start
