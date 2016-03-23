# What is a prime?
# A prime is a number that has only itself and 1 as factors
# Factors of n are numbers smaller than n

# How do we test if it is a prime?
#
# DO NOT WORRY ABOUT OPTIMIZING YET
#
# for a potential prime p, divide by all numbers smaller than p up to 1
# make sure there is no 0 remainder
#

# now order sqrt(n) !
def is_prime?(n)
  (2..(Math.sqrt(n).to_i)).each do |f|
    if (n % f) == 0
      return false
    end
  end
  true
end


# ORDER n(sqrt(n)) (? the while loop runs until n elements are in prime_array)
# can it be optimized? 
def primes_array(n)
  # until we have n numbers in the array,
  # we will look for primes 
  prime_storage = []
  test_prime = 2
  while(prime_storage.length < n) do
    if is_prime?(test_prime)
      prime_storage.push(test_prime)
    end
    test_prime += 1
  end
  prime_storage
end

# ORDER  n^2 -- can this be optimized?
def prime_times_table(n)
  primes = primes_array(n) # order n^2
  biggest_multiples = []
  primes.each do |p|
    biggest_multiples.push(primes.max * p)
  end
  biggest_length = biggest_multiples.max.to_s.length

  print " "*(biggest_length + 1)
  primes.each do |p|
    print " " +  (" "*(biggest_length - p.to_s.length).abs) + p.to_s
  end
  puts ""
  primes.each do |p| 
    multiplied = [p]
    primes.each do |prime| # order n^2
      multiplied.push(p * prime)
    end
    multiplied.each do |m|
      print " " + (" "*(biggest_length - m.to_s.length).abs) + m.to_s
    end
    puts ""
  end
end

prime_times_table(10)
#

# ORDER n (instead of n^2)
# MATRIX = []
# primes.each
#   mult = []
#   CREATE MULTIPLIED MATRIX with strings with correct padding
# end
# MATRIX.each do |array|
#   print array
# end
#
#
#
