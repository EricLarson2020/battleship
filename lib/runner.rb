require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require './lib/gameplay'


board1 = Board.new
board2 = Board.new
computer = Computer.new(board2)
game = Gameplay.new(board1, board2, computer)

game.start
# game.play_loop
