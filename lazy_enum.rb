#!/usr/bin/env ruby -w

r = 1..Float::INFINITY
puts r.lazy.select { |n| n % 2 == 0 }.take(5).to_a
