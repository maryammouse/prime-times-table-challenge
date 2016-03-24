# The Prime Times Table Challenge

> Write a program that prints out a multiplication table of the first 10 prime numbers.

I have written a program to print the table for the first 10 primes - and for the first *n* primes.

#### Table of Contents
[Setup] (#setup)<br>
[Notes] (#notes)<br>
[Thought Process] (#thoughts)<br>

<a name="setup"></a>
### Setup (how to install dependencies and run the program)
Once you have `git clone`-d the repository, enter the directory and run `bundle install`/`bundle update`. This should download the dependencies as listed in the `Gemfile`. You can run the program by typing `ruby primes.rb` at the console -- the output should be `Primes.prime_times_table(10)`, which should be a printed multiplication table of the first 10 prime numbers.

<a name="notes"></a>
### Notes:
> Consider complexity. How fast does your code run? How does it scale?

Currently, my `Prime.prime_times_table` method has a time complexity 
of *O(n^2)*. This is due to the fact that I use a nested `.each` loop to 
print each prime's set of multiples. So far I have not been able to 
determine a way of doing this with less time complexity. The method has 
a space complexity of *O(n)* due to the `prime_array` method, which uses 
the **Segmented Sieve of Eratosthenes** algorithm to find the first *n* primes. 
You can see the optimization of this code over tim by viewing the commits.

I chose to use the Eratosthene's Sieve algorithm instead of others such as the Sieve of Atkin as it 
seems to me to be the most intuitive and simple while also being one of the most efficient
algorithms known, especially in its Segmented form.

> Write tests. Try to demonstrate TDD/BDD.

You can view all of the written tests in `specs/table_spec.rb`, and run them using `rspec specs/table_spec.rb` (see Setup for information on installing dependencies for this program.

While comparing the run times of different versions of my methods, I used `Benchmark` lines within `primes.rb`, as this was 
quick and such localized tests did not seem to fit inside the official spec file which relates to the methods more generally.

<a name="thoughts"></a>
### Thought Process

My thought process while working through this was:

- First, make a version that works (and works correctly)
- Second, make a version that works quickly

My first few commits will show you how I experimented with the code and came up
with methods to test primes and then to return arrays containing the first *n* primes.
Though it was my first time writing tests for such a small program, I wrote tests first in `UnitTest`, 
then in `RSpec` which I was more familiar with. Once I wrote methods to make sure I recieved the
correct output for `is_prime?` and `primes_array`, I wrote tests for the table and then began to implement
the `prime_times_table` method itself. 

Throughout this entire process I was in a red-green-refactor cycle. I edited specs as I began to better understand
what I wanted and edited the methods to account for this.

Once I had a fully functional table (all specs passing), I began to look into how I might make
my code faster. I decided to tackle the optimization of `is_prime?` and
`primes_array` first, as I could not immediately see any way to optimize the nested
`.each` loop area, the biggest 'bottleneck'. Through this process I discovered the **Sieve of Eratosthenes** and
began to figure out how I would use it to solve my own problem (the Sieve finds all primes less than *n* , while
I wanted the first *n* primes). I learned about the **Prime Counting Theorem** and that there existed an equation
for the upper bound of the *nth* prime (for *n* >= 6). This gave me the complete range I would need to iterate over for the
Sieve. I kept my original code to be used for *n* < 6  and used the Sieve for the rest. Using the `Benchmark` library to
test the runtimes, I noticed a significant runtime decrease between my old code and new.

Still seeing no way to decrease the time complexity for the `prime_times_table` method, I simply 
refactored all of the code.I put all of the methods inside a class and separated certain blocks into their own methods to be used inside `prime_times_table`.

<del>This is, at the moment, my "final" code. However, I am going to tackle the segmented Sieve for `primes_array` in order to decrease the space complexity of that program.</del>

###Edit 
I have finally implemented the segmented Eratosthenes Sieve!
It took some time to grasp the algorithm and what exactly I needed to do with my code
but in the end I understood - and also got the code working as it should: returning the
correct result and returning it quickly.

*I have now completed the challenge - Maryam Syed, 3.24.16*

(I may touch up the code here or there, but the viewer may consider
the current state as its final state. I will not make any large changes.)

# Questions?

Please email me at maryamsyed2096@gmail.com

# Thanks for looking!
