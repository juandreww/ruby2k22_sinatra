# require 'skeleton/lib/NAME.rb'
require 'test/unit'

puts 'Yakob'

class TestNAME < Test::Unit::TestCase
  puts 'Yehow'
  def test_sample
    assert_equal(4, 2 + 2)
  end
end
