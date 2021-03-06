require 'minitest'
require 'minitest/autorun'
require_relative '../ruby_extensions/string_extension'
require_relative '../simple'

class SimpleTest < Minitest::Test

  def check_vm_output(expression, environment, expected_output)
    assert_output(expected_output.strip_tabs) do
      machine = Machine.new(expression, environment)
      machine.run
    end
  end

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
    check_vm_output(expression, nil, %(
      1 * 2 + 3 * 4
      2 + 3 * 4
      2 + 12
      14
    ))
  end

  def test_boolean_less_than
    expression = LessThan.new(
      Number.new(5),
      Add.new(
        Number.new(2),
        Number.new(2)
      )
    )
    check_vm_output(expression, nil,  %(
      5 < 2 + 2
      5 < 4
      false
    ))
  end

  def test_variable
    expression = Add.new(
      Variable.new(:x),
      Variable.new(:y),
    )
    environment = {
      x: Number.new(3),
      y: Number.new(4)
    }
    check_vm_output(expression, environment,  %(
      x + y
      3 + y
      3 + 4
      7
    ))
  end

end
