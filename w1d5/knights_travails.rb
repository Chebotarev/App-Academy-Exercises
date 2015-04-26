require './tree_node.rb'

class KnightPathFinder
  MOVEMENTS = [
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2]
  ]

  def self.valid_moves(pos)
    moves = MOVEMENTS.map do |add|
      [(pos.first + add.first), (pos.last + add.last)]
    end

    moves.select { |move| move.first.between?(0,7) && move.last.between?(0,7) }
  end

  def initialize(pos)
    @visited_positions = [pos]
    @move_tree = build_move_tree(pos)
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_moves = valid_moves.reject { |move| @visited_positions.include?(move) }
    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree(pos)
    root = PolyTreeNode.new(pos)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |new_pos|
        child = PolyTreeNode.new(new_pos)
        current_node.add_child(child)
        queue << child
      end
    end

    root
  end

  def find_path(end_pos)
    @move_tree.bfs(end_pos).trace_path_back
  end
end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0])
  p knight.find_path([6,2])
end
