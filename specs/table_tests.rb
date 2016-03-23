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

  context "prime_times_table" do
    it "outputs the correct table for a single given number" do
      expect{prime_times_table(1)}.to output("1").to_stdout
      
    end
  end
end

