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

    it "runs very quickly, even for large numbers" do
      expect(Benchmark.realtime{is_prime?(10000000000)}).to be < 1
    end
  end

  context "primes_array" do
    it "returns an array of all primes from 2 to n" do
      expect(primes_array(5)).to eq([2,3,5,7,11])
    end
  end

  context "prime_times_table" do
    it "outputs the correct table for n = 1" do
      expect{prime_times_table(1)}.to output("   2\n 2 4\n").to_stdout
    end

    it "outputs the correct table for n > 1" do
      expect{prime_times_table(2)}.to output("   2 3\n 2 4 6\n 3 6 9\n").to_stdout
    end
  end
end

