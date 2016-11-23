class Tagging < ApplicationRecord

  # get all stats
  def get_all_stats(taggings)
    hash = {  }
    taggings.each do |i|
      i['tags'].each do |tag|
        hash = fill_hash_with_tag(hash,tag)
      end
    end
    @array = []
    @array = fill_array_with_hash(hash)
  end

  # get a specific stat based on an entity_type and an entity_id
  def get_stats(tagging)
    hash = {}
    tagging.first.tags.each do |tag|
      hash = fill_hash_with_tag(hash,tag)
    end
    @array = []
    @array = fill_array_with_hash(hash)
  end

  def fill_hash_with_tag(hash,tag)
    if hash.keys.include? tag 
      hash[tag] += 1
    else
      hash[tag] = 1
    end
    hash
  end

  def fill_array_with_hash(hash)
    hash.each do |k,v|
      hash1 = {}
      hash1['tag'] = k
      hash1['count'] = v
      @array << hash1
    end
    @array
  end

end
