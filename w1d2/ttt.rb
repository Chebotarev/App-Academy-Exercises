class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, mark)
    grid[row][col] = mark
  end

  def won?

  end

  def winner
  end

  def empty?(pos)
    @grid[*pos].nil?
  end

  def place_mark(pos, mark)
    @grid[*pos] = mark
  end
end

class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def play
  end
end

class HumanPlayer
end

class ComputerPlayer
end


board = Board.new
board.place_mark([0,0], 1)
p board.grid
p board.empty?([0,0])
