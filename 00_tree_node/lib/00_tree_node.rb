require 'byebug'

class PolyTreeNode
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent # is an instance of PolyTreeNode
    @children = children # is an array of instances of PolyTreeNode
  end

  def parent=(new_parent)
    if new_parent.is_a?(PolyTreeNode) # if the new parent is a node
      new_parent.children << self unless new_parent.children.include?(self)
      if new_parent != @parent && @parent.is_a?(PolyTreeNode)
        @parent.children.delete(self)
      end
    end
    @parent = new_parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child" unless self.children.include?(child_node)
    child_node.parent = nil
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.map do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
  end

  def bfs(target_value)
    queue = [self]
    #dequeue is shift
    #enque is push
    until queue.empty?
      temp_node = queue.shift
      return temp_node if temp_node.value == target_value
      temp_node.children.each { |child| queue.push(child) }
    end
    nil
  end
end
