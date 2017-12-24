class Array
  def hash
    retHash = 0
    each_with_index do |el, idx|
      retHash += (el.hash + idx).hash
    end
    retHash.hash
  end
end

class String
  def hash
    chars.each_with_index.map do |let, idx|
      (let.ord.hash + idx).hash
    end.hash
  end
end

class Hash
  def hash
    keys.map do |key|
      (self[key].hash + key.hash).hash
    end.reduce(:+).hash
  end
end
