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
      return prime_trial(n)
    else
      max_upper_bound = (n * Math.log(n) + n * Math.log(Math.log(n))).to_i
      segment_length = (Math.sqrt(max_upper_bound)).to_i
      low = 2
      high = low + segment_length
      unfiltered = [nil, nil, *2..max_upper_bound]
      original_primes = []
      (low..high).each do |i|
        ((i+i)..high).step(i).each do |m|
          if unfiltered[i]
            unfiltered[m] = nil
          end
        end
      end
      original_primes = unfiltered[0, high].compact
      low = high + 1
      high += segment_length

      while low < max_upper_bound
        original_primes.each do |i|
          lowest_multiple = (low/i).ceil * i
          if lowest_multiple < low
            lowest_multiple += i
          end
          (lowest_multiple..high).step(i).each do |m|
            if unfiltered[m]
              unfiltered[m] = nil
            end
          end
        end

        low += segment_length
        high += segment_length
        if high >= max_upper_bound
          high = max_upper_bound
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
      print padding(biggest_length, p) + p.to_s
      primes.each do |prime|
        m = p * prime
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

  def self.prime_trial(n)
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

  private_class_method :biggest_prime_multiple
  private_class_method :padding
  private_class_method :prime_trial

end

# puts Primes.primes_array(36).to_s
# puts Primes.old_primes_array(36).to_s
#puts Benchmark.measure{Primes.primes_array(1000000)}
# puts Benchmark.measure{Primes.primes_array(2000000)}
# puts Benchmark.measure{Primes.old_primes_array(1000000)}
#puts Benchmark.measure{Primes.old_primes_array(2000000)}

=begin

  def self.old_primes_array(n)
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
      max_upper_bound = (n * Math.log(n) + n * Math.log(Math.log(n))).to_i
      low = 2
      high = Math.sqrt(max_upper_bound).to_i
      unfiltered = [nil, nil, *2..max_upper_bound]
      (2..(Math.sqrt(max_upper_bound)).to_i).each do |i|
        (i**2..max_upper_bound).step(i).each do |m|
          if unfiltered[i]
            unfiltered[m] = nil
          end
        end
      end
      unfiltered.compact
    end
  end

=end




#Primes.prime_times_table(10)
#
#
=begin
TERRIBLE SLOW SEGMENTED SIEVE, THROW IT IN THE TRASH :O
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
      max_upper_bound = (n * Math.log(n) + n * Math.log(Math.log(n))).to_i
      low = 2
      high = Math.sqrt(max_upper_bound).to_i
      segment_length = (Math.sqrt(max_upper_bound)).to_i
      unfiltered = [nil, nil, *2..high]
      (low..high).each do |i|
        (i**2..high).step(i).each do |m|
          if unfiltered[i]
            unfiltered[m] = nil
          end
        end
      end
      original_primes = unfiltered.compact
      prime_storage = unfiltered.compact
      low += segment_length + 1
      high += segment_length + 1

      while low < max_upper_bound
        unfiltered = [*low..high]
        original_primes.each do |i|
          lowest_multiple = (low/i).ceil * i
          if lowest_multiple < low
            lowest_multiple += i
          end
          (lowest_multiple..high).step(i).each do |m|
            if unfiltered[m-low]
              unfiltered[m-low] = nil
            end
          end
        end
        (prime_storage << unfiltered.compact).flatten!

        low += segment_length
        high += segment_length
        if high >= max_upper_bound
          high = max_upper_bound
        end
      end
      prime_storage.to_s
    end
  end

=end 
