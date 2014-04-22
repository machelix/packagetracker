class EmailHelperTest < ActionView::TestCase

  test "find emails with valid city db id" do
    assert_equal 2 , find_emails('12345').size
    assert_equal Email::ActiveRecord_Relation , find_emails('12345').class
  end

  test "find emails with valid city db id set to *" do
    assert_equal 2 , find_emails('*').size
    assert_equal Email::ActiveRecord_Relation , find_emails('*').class
  end

  test "Dont find emails with not found city db id" do
    assert_equal 0 , find_emails('xxxxx').size
    assert_equal Email::ActiveRecord_Relation , find_emails('xxxxx').class
  end

  test "Dont find emails with invalid city db id" do
    assert_equal 0 , find_emails('11').size
    assert_equal Email::ActiveRecord_Relation , find_emails('11').class
    assert_equal Email::ActiveRecord_Relation , find_emails(11).class
  end

end