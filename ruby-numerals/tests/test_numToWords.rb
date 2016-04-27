require "../../ruby-numerals/main/numToWords"

require "test/unit"

class TestNumConverter < Test::Unit::TestCase

  def test_converter
    assert_equal("seven", NumConverter.converter(7) )
    assert_equal("forty-two", NumConverter.converter(42) )
    assert_equal("two thousand and one", NumConverter.converter(2001) )
    assert_equal("one thousand nine hundred and ninety nine", NumConverter.converter(1999) )
  end


end