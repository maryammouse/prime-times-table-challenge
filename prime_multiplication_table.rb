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

# ORDER N
def is_prime?(n)
  prime = true
  (2...n).each do |f|
    if (n % f) == 0
      prime = false
    end
  end
  prime
end

# ORDER N (? the while loop runs until n elements are in prime_array)
# it does not run n times. It runs more than n times.
def primes_array(n)
  # until we have n numbers in the array,
  # we will look for primes
  prime_storage = [1]
  test_prime = 2
  while(prime_storage.length < n) do
    if is_prime?(test_prime)
      prime_storage.push(test_prime)
    end
    test_prime += 1
  end
  prime_storage
end

def prime_times_table(n)
  primes = primes_array(n)
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
    primes.each do |prime|
      multiplied.push(p * prime)
    end
    multiplied.each do |m|
      print " " + (" "*(biggest_length - m.to_s.length).abs) + m.to_s
    end
    puts ""
  end
end

prime_times_table(25)
