require 'byebug'

class PolyTreeNode
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end
  
  def parent=(parent_val)
    return if parent == parent_val
    @parent.children.delete(self) unless @parent.nil?
    #@parent.remove_child(self) unless @parent.nil?
    @parent = parent_val
    @parent.children << self unless parent_val.nil?
  end
  
  def add_child(node)
    
    #self.children << node if node.instance_of?(PolyTreeNode)
    node.parent = self
    @parent.children.delete(self) unless @parent.nil?
  end
  
  
  def remove_child(node)
    #debugger
    p node
    raise error "Not a child" unless self.children.include?(node)
    node.parent = nil unless node.nil?
    self.children.delete(node) unless (node.nil? && self.nil?)
    
  end 
  
  def children
    @children unless self.nil?
  end
  
  def value
    @value
  end
  
  def dfs(target_val)
     
    return self if self.value == target_val
    self.children.each do |child|
      node = child.dfs(target_val)
      return node unless node.nil?
    end
    
    nil
  end
  
  def bfs(target_val)
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      if node.value == target_val
        return node unless node.nil?
      else
        queue.concat(node.children)
      end 
    end
    nil
  end
  
  #private
  attr_reader :parent
  attr_accessor :children
end