class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def add_self(prev_node, next_node)
    next_node.prev = self
    self.next = next_node

    prev_node.next = self
    self.prev = prev_node
    self
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    self
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next if !(@head.next === @tail)
  end

  def last
    @tail.prev if !(@tail.prev === @head)
  end

  def empty?
    @head.next === @tail
  end

  def get(key)
    (node = find { |node| node.key === key }) && node.val
  end

  def get_node(key)
    find { |node| node.key === key }
  end
  
  def include?(key)
    any? { |node| node.key === key }
  end
  
  def append(key, val)
    if !include?(key)
      return Node.new(key, val).add_self(@tail.prev, @tail)
    end
  end
  
    def append_node(node)
      node.add_self(@tail.prev, @tail)
    end

  def update(key, val)
    if node = get_node(key)
      node.val = val
    end
    nil
  end

  def remove(key)
    (node = find { |node| node.key === key }) && node.remove
  end

  def each(&prc)
    node = @head.next
    while !(node === @tail)
      prc.call(node)
      node = node.next
    end
    self
  end

  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
