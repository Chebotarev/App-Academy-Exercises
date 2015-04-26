require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      @board.winner == other_mark(evaluator)
    else
      if evaluator == next_mover_mark
        all_losing_nodes?(evaluator)
      else
        any_losing_nodes?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator
    else
      if next_mover_mark == evaluator
        any_winning_nodes?(evaluator)
      else
        all_winning_nodes?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    potential_states = []

    @board.rows.each_with_index do |row, x|
      row.each_with_index do |position, y|
        next unless @board.empty?([x, y])
        dup_board = @board.dup
        dup_board[[x,y]] = @next_mover_mark
        new_pos = @prev_move_pos.nil? ? [x, y] : (@prev_move_pos + [x, y])
        new_next_mover_mark = @next_mover_mark == :x ? :o : :x
        potential_states << TicTacToeNode.new(dup_board,
                                              new_next_mover_mark,
                                              new_pos)
      end
    end

    potential_states
  end

  private

  def other_mark(mark)
    mark == :x ? :o : :x
  end

  def any_losing_nodes?(evaluator)
    self.children.any? { |child| child.losing_node?(evaluator) }
  end

  def all_losing_nodes?(evaluator)
    self.children.all? { |child| child.losing_node?(evaluator) }
  end

  def all_winning_nodes?(evaluator)
    self.children.all? { |child| child.winning_node?(evaluator)}
  end

  def any_winning_nodes?(evaluator)
    self.children.any? { |child| child.winning_node?(evaluator) }
  end
end
