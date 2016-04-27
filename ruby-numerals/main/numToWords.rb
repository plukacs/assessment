#!/usr/bin/env ruby
#require 'active_support/all'
N2W_hash = {
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
    100 => "hundred",
    1000 => "thousand",
    1000000 => "million",
    1000000000 => "billion",
    1000000000000 => "trillion"
}

class NumConverter

  class << self


    def converter(num)
      return "zero" if num == 0
      word_acc = []
    digit_reversed = num.to_s.reverse
      digit_count = 0
      digit_reversed.chars.each_with_index do |digit, index|
        digit_as_number = Integer(digit)
        skip_zero(digit_as_number) do
          if digit_count == 0
            word_acc << "#{N2W_hash[digit_as_number]}"
          elsif teens_to_twenties?(digit_as_number, digit_count)
            trace word_acc
            actual_number = Integer("#{digit}#{digit_reversed[index - 1]}")
            counter = (digit_count > 1 ? 10**(digit_count - 1) : nil)
            word_rep = "#{N2W_hash[actual_number]}"
            word_rep += " #{N2W_hash[counter]}" if counter
            word_rep += " and" if word_acc.size == 1
            word_acc << word_rep
          elsif twenties_to_hundreds?(digit_count)
            trace word_acc
            counter = (digit_count > 1 ? 10**(digit_count - 1) : nil)
            lookup_number = digit_as_number * 10
            word_rep = "#{N2W_hash[lookup_number]}"
            word_rep += "-" if Integer(digit_reversed[index - 1]) != 0
            word_rep += " #{N2W_hash[Integer(digit_reversed[index - 1])]}".strip
            word_rep += " #{N2W_hash[counter]}" if counter
            word_rep += " and" if word_acc.size == 1
            word_acc << word_rep
          elsif digit_count == 2 || digit_count % 3 == 2
            counter = 10**2
            word_rep = "#{N2W_hash[digit_as_number]} #{N2W_hash[counter]}"
            word_rep += " and" if word_acc.size != 0
            word_acc << word_rep
          else
            counter = 10**digit_count
            word_rep = "#{N2W_hash[digit_as_number]} #{N2W_hash[counter]}"
            word_rep += " and" if word_acc.size == 1
            word_acc << word_rep
          end
        end
        digit_count += 1
      end
      word_acc.reverse.join(" ")
    end

    def skip_zero(digit)
      if digit != 0
        yield
      end
    end

    def trace(word_list)
      word_list.pop
    end

    def teens_to_twenties?(digit_as_number, digit_count)
      (digit_count - 1) % 3 == 0 && digit_as_number == 1
    end

    def twenties_to_hundreds?(digit_count)
      (digit_count - 1) % 3 == 0
    end



end
end

puts NumConverter.converter(1999)

#if __FILE__ == $0
##
#puts "Enter arabic num to converter to english phrase: "
#puts NumConverter.converter(gets.chomp)
#  end

