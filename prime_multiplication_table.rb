require 'benchmark'
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
  if n % 2 == 0 && n != 2
    return false
  end
  (3..(Math.sqrt(n).to_i)).step(2).each do |f|
    if (n % f) == 0
      return false
    end
  end
  true
end

puts "is_prime?"
puts Benchmark.realtime{is_prime?(10000000000)}
puts Benchmark.realtime{is_prime?(100000000000000000000)}

is_prime?(4)
# sqrt(4) = 2
# sqrt(16) = 4
# sqrt(9) = 3
# sqrt(81) = 9
is_prime?(16)


# ORDER n(sqrt(n)) (? the while loop runs until n elements are in prime_array)
# can it be optimized? 
# we could make a Sieve of Eratosthenes (then we no longer use is_prime?)
# however, the sieve does not return n primes,
# it returns all primes less than n.
# however, the Prime Number Theorem can tell us the upper bound on the 
# nth prime, so that we can sieve over it! :) 

# using Eratosthene's sieve, we now have O(n(log n)(log(log n)))
def primes_array(n)
  # until we have n numbers in the array,
  # we will look for primes 
  if n < 6
    prime_storage = []
    test_prime = 2
    while(prime_storage.length < n) do
      if is_prime?(test_prime)
        prime_storage.push(test_prime)
      end
      test_prime += 1
    end
    prime_storage
  else
    upper_bound = n * Math.log(n) + n * Math.log(Math.log(n))
    unfiltered = [nil, nil, *2..upper_bound]
    (2..upper_bound.to_i).each do |i|
      (i**2..upper_bound.to_i).step(i).each do |m|
        if unfiltered[i]
          unfiltered[m] = nil
        end
      end
    end
    unfiltered.compact
  end
end

def old_primes_array(n)
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
end

puts Benchmark.measure{old_primes_array(100)}
puts Benchmark.measure{old_primes_array(200)}
puts Benchmark.measure{primes_array(100)}
puts Benchmark.measure{primes_array(200)}

# ORDER  n^4 definitely greater than n^2 -- can this be optimized?
def prime_times_table(n)
  primes = primes_array(n) # order n(log(n))(log(log(n)))
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
      multiplied.push(p * prime) # order n^2
    end
    multiplied.each do |m|
      print " " + (" "*(biggest_length - m.to_s.length).abs) + m.to_s
    end
    puts ""
  end
end

# prime_times_table(10)


