class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    unless @parent.nil?
      self.parent.children.reject! { |child| child == self }
    end

    @parent = node

    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(node)
    @children << node
    node.parent = self
  end

  def remove_child(node)
    raise "Node is not a child!" unless @children.include?(node)
    @children.reject! { |child| child == node }
    node.parent = nil
  end

  def dfs(target_value)
    return self if target_value == @value

    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    queue = Array.new
    queue << self

    until queue.empty?
      current_node = queue.shift
      return current_node if target_value == current_node.value
      current_node.children.each { |child| queue << child }
    end

    nil
  end

  def trace_path_back
    return [self.value] if self.parent.nil?
    self.parent.trace_path_back + [self.value]
  end
end
