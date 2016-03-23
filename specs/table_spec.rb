require_relative './spec_helper.rb'
require 'benchmark'

RSpec.describe "Primes" do
  context "is_prime?" do 
    it "returns true for a prime number" do
      expect(is_prime?(5)).to eq(true)
    end

    it "returns false for a composite number" do
      expect(is_prime?(6)).to eq(false)
    end

    it "is order sqrt(n)" do
      n = 10000000000
      basetime = Benchmark.realtime{is_prime?(n)}
      expect(Benchmark.realtime{is_prime?(n**2)}).to be < Math.sqrt(basetime)
    end
  end

  context "primes_array" do
    it "returns an array of all primes from 2 to n for n >= 6" do
      expect(primes_array(6)).to eq([2,3,5,7,11,13])
    end

    it "returns an array of all primes from 2 to n for n < 6" do
      expect(primes_array(4)).to eq([2,3,5,7])
    end

    it "is order n(log(n))(log(log(n)))" do
      n = 1000
      basetime = Benchmark.realtime{primes_array(n)}
      puts Math.log(basetime)
      upper_bound = (basetime * (Math.log(basetime))).abs
      # using (log(log(n))) results in domain errors 
      expect(Benchmark.realtime{primes_array(n*2)}).to be < upper_bound

    end
  end

  context "prime_times_table" do
    it "outputs the correct table for n = 1" do
      expect{prime_times_table(1)}.to output("   2\n 2 4\n").to_stdout
    end

    it "outputs the correct table for n > 1" do
      expect{prime_times_table(2)}.to output("   2 3\n 2 4 6\n 3 6 9\n").to_stdout
    end

    it "is of order n^2 time complexity" do
      basetime = Benchmark.realtime{prime_times_table(10)}
      expect(Benchmark.realtime{prime_times_table(20)}).to be < Math.sqrt(basetime)
    end
  end
end

