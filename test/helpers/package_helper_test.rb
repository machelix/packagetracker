class PackageHelperTest < ActionView::TestCase

  test "find emails with valid city db id" do
    assert_equal 2 , find_packages('12345').size
    assert_equal Package::ActiveRecord_Relation , find_packages('12345').class
  end

  test "find emails with valid city db id set to *" do
    assert_equal 2 , find_packages('*').size
    assert_equal Package::ActiveRecord_Relation , find_packages('*').class
  end

  test "Dont find emails with not found city db id" do
    assert_equal 0 , find_packages('xxxxx').size
    assert_equal Package::ActiveRecord_Relation , find_packages('xxxxx').class
  end

  test "Dont find emails with invalid city db id" do
    assert_equal 0 , find_packages('11').size
    assert_equal Package::ActiveRecord_Relation , find_packages('11').class
    assert_equal Package::ActiveRecord_Relation , find_packages(11).class
  end

  test "Dont find emails with invalid city db id i.e. 0" do
    assert_equal 0 , find_packages(0).size
    assert_equal Package::ActiveRecord_Relation , find_packages(0).class
  end

end