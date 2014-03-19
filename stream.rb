#!/usr/bin/env ruby -w

class Stream
  include Enumerable
  def initialize(init_value, &block)
    @value = init_value
    @block = block
  end

  def next
    Stream.new(@block.call(@value), &@block)
  end

  def filter(&block)

    n = self
    until (n = n.next) && block.call(n.to_i)
    end
    Stream.new(n.to_i, &block)
  end

  def each
    n = self
    while n = n.next
      yield n.to_i
    end
  end

  def %(mod)
    @value % mod
  end

  def to_i
    @value.to_i
  end

  def to_s
    @value.to_s
  end
end

stream = Stream.new(0) { |n| n + 1 }
# stream.filter { |n| n % 2 == 0 }.each { |n| puts n }

while true
  stream = stream.next
  puts stream.to_s
end
