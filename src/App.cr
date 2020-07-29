require "redis"

class App
  @redis = Redis.new

  LIST = "todo"

  def dump
    i = 1
    @redis.lrange(LIST, 0, -1).each do |item|
      puts "#{i}) #{item}"
      i += 1
    end
  end

  def del(index)
    val = @redis.lindex(LIST, index.to_i - 1)
    @redis.lrem(LIST, 1, val)
  end

  def push(item : String)
    # todo reject dupes
    @redis.rpush(LIST, item)
  end

  def mv(from, to)
    from_i = from.to_i - 1
    to_i = to.to_i - 1

    tmp = @redis.lindex(LIST, from_i)
    pivot = @redis.lindex(LIST, to_i)

    if to_i < 0
      @redis.lrem(LIST, 1, tmp)
      @redis.lpush(LIST, tmp)
    else
      @redis.lrem(LIST, 1, tmp)
      @redis.linsert(LIST, "AFTER", pivot, tmp)
    end
  end

  def edit(index, new_val)
    @redis.lset(LIST, index.to_i - 1, new_val)
  end
end
