require_relative 'p05_hash_map'

def make_count_map(string)
  map = HashMap.new()
  string.chars.each do |letter|
    case_letter = letter.downcase
    if map[case_letter]
      map[case_letter] += 1
    else
      map[case_letter] = 1
    end
  end
  map
end

def can_string_be_palindrome?(string)
  odd_count = 0
  make_count_map(string).each do |kv|
    if kv[1].odd?
      odd_count += 1
    end
  end
  odd_count <= 1
end
