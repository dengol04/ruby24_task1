require "levenshtein"

def get_list_of_contestant
  file_path = 'log.txt'
  hash = Hash.new(0)
  File.foreach(file_path) do |line|
    match = line.match(/vote => (.+)/)
    contestant = match[1].chomp
    count = 0
    hash.each do |k, v|
      if hash.include?(contestant)
        hash[contestant] += 1
        break
      end
      if Levenshtein.distance(k, contestant) < 3
        hash[k] += 1
        break
      end
      count += 1
    end
    if count == hash.size()
      hash[contestant] = 1
    end
  end

  hash
end

puts get_list_of_contestant
puts get_list_of_contestant.max_by{|k,v| v}
