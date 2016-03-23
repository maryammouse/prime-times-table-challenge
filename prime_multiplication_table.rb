require 'benchmark'

class Primes
  #
# now order sqrt(n) !
  def self.is_prime?(n)
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

  # using Eratosthene's sieve, we now have O(n(log n)(log(log n)))
  def self.primes_array(n)
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
      (2..Math.sqrt(upper_bound).to_i).each do |i|
        (i**2..upper_bound.to_i).step(i).each do |m|
          if unfiltered[i]
            unfiltered[m] = nil
          end
        end
      end
      unfiltered.compact
    end
  end

  # ORDER  n^2 -- can this be optimized?
  def self.prime_times_table(n)
    primes = primes_array(n)
    biggest_length = biggest_prime_multiple(primes).to_s.length

    print " "*(biggest_length + 1)
    primes.each do |p|
      print padding(biggest_length, p) + p.to_s
    end

    primes.each do |p|
    puts ""
      multiplied = [p]
      primes.each do |prime|
        multiplied.push(p * prime)
      end
      multiplied.each do |m|
        print padding(biggest_length, m) + m.to_s
      end
    end
    puts ""
  end

  def self.biggest_prime_multiple(primes)
    biggest_multiples = []
    primes.each do |p|
      biggest_multiples.push(primes.max * p)
    end
    return biggest_multiples.max
  end

  def self.padding(biggest_length, n)
    return " "*(biggest_length - n.to_s.length + 1).abs
  end

  private_class_method :biggest_prime_multiple
  private_class_method :padding

end

Primes.prime_times_table(10)
