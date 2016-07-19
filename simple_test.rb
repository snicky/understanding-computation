require 'minitest'
require 'minitest/autorun'
require_relative 'string_extension'
require_relative 'simple'

class SimpleTest < Minitest::Test

  def test_number_add_multiply
    expression = Add.new(
      Multiply.new(
        Number.new(1),
        Number.new(2)
      ),
      Multiply.new(
        Number.new(3),
        Number.new(4)
      )
    )
    expected_output = %(
      1 * 2 + 3 * 4
      2 + 3 * 4
      2 + 12
      14
    ).strip_tabs
    assert_output(expected_output) do
      machine = Machine.new(expression)
      machine.run
    end
  end

end
