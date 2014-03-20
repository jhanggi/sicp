#!/usr/bin/env ruby -w

class Stream
  include Enumerable
  attr_reader :first

  def initialize(first, &block)
    @first = first
    @block = block
  end

  def rest
    @rest ||= Stream.new(@block.call(first), &@block)
  end

  def each(&block)
    block.call(first)
    rest.each(&block)
  end

  # Does not work yet
  def select(&predicate)
    if predicate.call(first)
      Stream.new(first) { rest.select(&predicate) }
    else
      rest.select(&predicate)
    end
  end

  def to_s
    first.to_s
  end
end

stream = Stream.new(1) { |n| n + 1 }
puts stream.take(100)
# puts stream.select { |n| puts "N:#{n}"; n % 3 == 0 }.take(10)
