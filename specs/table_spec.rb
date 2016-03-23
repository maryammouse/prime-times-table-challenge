require_relative './spec_helper.rb'

RSpec.describe "Primes" do
  context "is_prime?" do 
    it "returns true for a prime number" do
      expect(is_prime?(5)).to eq(true)
    end

    it "returns false for a composite number" do
      expect(is_prime?(6)).to eq(false)
    end
  end

  context "primes_array" do
    it "returns an array of all primes from 1 to n" do
      expect(primes_array(5)).to eq([1,2,3,5,7])
    end
  end

  context "prime_times_table" do
    it "outputs the correct table for a single given number" do
      expect{prime_times_table(1)}.to output("  1 \n1 1 \n").to_stdout
    end
  end
end

