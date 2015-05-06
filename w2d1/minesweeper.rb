require 'yaml'

class Tile
  NEIGHBORS = [
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1]
  ]

  attr_accessor :bombed, :flagged, :hidden

  def initialize(board, pos)
    @board = board
    @pos = pos
    @hidden = true
    @flagged = false
    @bombed = false
  end

  def neighbors
    neighbors = NEIGHBORS.map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end

    neighbors.
      select { |pos| @board.on_board?(pos) }.
      map { |pos| @board.tile_at(pos) }
  end

  def neighbor_bomb_count
    neighbors.count do |neighbor|
      neighbor.bombed
    end
  end

  def already_revealed?
    !@hidden
  end

  def reveal
    return if @flagged || already_revealed?

    @hidden = false

    if @bombed
      @board.game_over_state = "lost"
    elsif neighbor_bomb_count == 0
      neighbors.each do |neighbor|
        neighbor.reveal
      end
    end
  end

  def to_s
    if @flagged
      'F'
    elsif @hidden
      '*'
    elsif neighbor_bomb_count == 0
      '_'
    else
      "#{neighbor_bomb_count}"
    end
  end

  def toggle_flag
    @flagged = !@flagged
  end

  private

    def inspect
      "#<Tile:#{object_id}  pos => #{@pos}
                            bombed => #{@bombed}
                            flagged => #{@flagged}
                            hidden => #{@hidden}"
    end
end

class Board
  attr_reader :grid
  attr_accessor :game_over_state

  def initialize(bomb_seed)
    @grid = Array.new(9) do |i|
      Array.new(9) do |j|
        Tile.new(self, [i, j])
      end
    end

    @grid.flatten.sample(bomb_seed).each do |tile|
      tile.bombed = true
    end

    @game_over_state = nil
  end

  def show
    print "  1 2 3 4 5 6 7 8 9\n"
    print "  -----------------\n"

    @grid.each_with_index do |row, idx|
      print "#{idx + 1}|"

      row.each do |el|
        print el.to_s + " "
      end

      print "\n"
    end
  end

  def tile_at(pos)
    @grid[pos.first][pos.last]
  end

  def game_over?
    bombed_tiles = @grid.flatten.select { |tile| tile.bombed }
    flagged_tiles = @grid.flatten.select { |tile| tile.flagged }
    if bombed_tiles == flagged_tiles
      @game_over_state = "won"
    end

    !@game_over_state.nil?
  end

  def on_board?(pos)
    pos[0].between?(0, 8) && pos[1].between?(0, 8)
  end
end

class Game

  def self.load(file)

  end

  def initialize(board_size = 1)
    @board = Board.new(board_size)
  end

  def selected_tile(x, y)
    @board.tile_at([x.to_i - 1, y.to_i - 1])
  end

  def execute(command, tile)
    if command == 'r'
      tile.reveal
    elsif command == 'f'
      tile.toggle_flag
    end
  end

  def run
    until @board.game_over?
      @board.show
      print "Move > "
      input = gets.chomp

      if input == "save"
        save("test.yml")
        return
      end

      command, x, y = input.split
      execute(command, selected_tile(x, y))
    end

    puts "Game over! You #{@board.game_over_state.to_s}!"
  end

  def save(file)
    file ||= "#{Time.now.year}_#{Time.now.month}_#{Time.now.day}_minesweeper.yml"
    File.open(file, 'w') do |f|
      f.puts self.to_yaml
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new(10)
  game.run
end
