require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'pry'

class HashMap
  include Enumerable
  
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if list.include?(key)
      list.update(key, val)
    else
      list.append(key, val)
      @count += 1
      resize! if @count >= num_buckets
    end
    self
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if node = bucket(key).get_node(key)
      node.remove
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each { |node| prc.call([node.key, node.val]) }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old = @store;
    @store = Array.new(old.length * 2) { LinkedList.new }
    @count = 0
    old.each do |bucket|
      bucket.each { |node| set(node.key, node.val) }
    end
    self
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
