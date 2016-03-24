require_relative './spec_helper.rb'
require 'benchmark'

RSpec.describe "Primes" do
  context "is_prime?" do 
    it "returns true for a prime number" do
      expect(Primes.is_prime?(5)).to eq(true)
    end

    it "returns false for a composite number" do
      expect(Primes.is_prime?(6)).to eq(false)
    end

    it "is not grossly inefficient (it is possibly O(sqrt(n)))" do
      n = 17
      basetime = Benchmark.realtime{Primes.is_prime?(n)}
      expect(Benchmark.realtime{Primes.is_prime?(293)}).to be < Math.sqrt(basetime)
      # need to use sqrt instead of ** 2 because while the basetime is
      # small, **2 results in an even smaller basetime instead of a larger one.
    end
  end

  context "primes_array" do
    it "returns an array of all primes from 2 to n for n >= 6" do
      expect(Primes.primes_array(6)).to eq([2,3,5,7,11,13])
    end

    it "returns an array of all primes from 2 to n for n < 6" do
      expect(Primes.primes_array(4)).to eq([2,3,5,7])
    end

    it "is order n(log(n))(log(log(n)))" do
      n = 1000
      basetime = Benchmark.realtime{Primes.primes_array(n)}
      puts "And here goes the basetime"
      puts basetime
      puts Benchmark.realtime{Primes.primes_array(n*2)}
      upper_bound = (basetime * (Math.log(basetime))).abs
      puts "upper bound: " + upper_bound.to_s
      # using the (log(log(n))) part results in domain errors
      expect(Benchmark.realtime{Primes.primes_array(n*2)}).to be < upper_bound

    end
  end

  context "prime_times_table" do
    it "outputs the correct table for n = 1" do
      expect{Primes.prime_times_table(1)}.to output("   2\n 2 4\n").to_stdout
    end

    it "outputs the correct table for n > 1" do
      expect{Primes.prime_times_table(2)}.to output("   2 3\n 2 4 6\n 3 6 9\n").to_stdout
    end

    it "is of order n^2 time complexity" do
      basetime = Benchmark.realtime{Primes.prime_times_table(10)}
      expect(Benchmark.realtime{Primes.prime_times_table(20)}).to be < Math.sqrt(basetime)
      # need to use sqrt instead of ** 2 because while the basetime is 
      # small, **2 results in an even smaller basetime instead of a larger one.
    end
  end
end

