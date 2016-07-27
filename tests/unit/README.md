Unit tests go here. You can start with:

```ruby
require 'test_helper'

class SomeClassTest < Minitest::Test
  def setup
    super
    
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_something
    assert_equal("X", "x".upcase)
  end
end
```

A list of assertions: http://www.mattsears.com/articles/2011/12/10/minitest-quick-reference/

To run the tests, run `bundle exec rake`.

Test files must be named like `something_test.rb`.