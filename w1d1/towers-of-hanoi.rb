# winning state array.last = [1,2,3]
# [1,2,3]
# []
# []


class TowersOfHanoi

  def initialize
    @board = [[1,2,3], [], []]
  end

  def game_over?
    @board.last == [1,2,3]
  end

  def move_disc(to, from)
     value = @board[from].shift
     @board[to].unshift(value)
  end

  def valid_move?(to, from)
    !@board[from].empty? && (@board[to].empty? ||
                            (@board[to].first > @board[from].first))
  end

  def show_board
    @board.each do |peg|
      p peg
    end
  end

  def get_user_input
    puts "What peg do you want to move the piece from?"
    from = gets.chomp.to_i - 1
    puts "What peg do you want to move the piece to?"
    to = gets.chomp.to_i - 1
    [to,from]
  end

  def run
    until game_over?

      show_board
      to, from = get_user_input

      move_disc(to, from) if valid_move?(to, from)
    end

    puts "You win!"
  end


end

game = TowersOfHanoi.new
game.run
