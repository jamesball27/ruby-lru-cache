require_relative 'linked_list'

class LRUCache

  def initialize(max = 5)
    @map = {}
    @store = LinkedList.new
    @max = max
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]
    if link
      update_link!(link)
      link.val
    end
  end

  def set(key, val)
    @store.append(key, val)
    @map[key] = @store.last
    eject! if count > @max
    true
  end

  def most_recently_used
    @store.last
  end

  def least_recently_used
    @store.first
  end

  private

  def update_link!(link)
    link.remove
    @store.append(link.key, link.val)
  end

  def eject!
    link = least_recently_used
    @map.delete(link.key)
    link.remove
  end
end
