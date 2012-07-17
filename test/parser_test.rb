require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe "Parser" do
  it "should raise an exception if first arg is not a string" do
    proc{EmailAddressesParser.parse_list(2)}.must_raise RuntimeError
  end
  
  it "should correctly parse a variety of webform inputs" do
    email_addresses_list = %Q{John Smith Jr. <jsmith@example.com>\r\n\r\n\r\nfoo@example.com, bar@example, jotoole@example.com John O'Tool\r\njotoole@example.com John O'Toole\r\njsmd@example.com "Dr. John Smith", Jane Smith}
    valid_items_hash, invalid_items_array = EmailAddressesParser.parse_list(email_addresses_list)
    
    valid_items_hash.size.must_equal 4
    valid_items_hash['jsmith@example.com'].must_equal "John Smith Jr."
    valid_items_hash['foo@example.com'].must_equal ""
    valid_items_hash['jotoole@example.com'].must_equal "John O'Toole" #dup
    valid_items_hash['jsmd@example.com'].must_equal "Dr. John Smith"
    
    invalid_items_array.size.must_equal 2
    invalid_items_array[0].must_equal "bar@example"
    invalid_items_array[1].must_equal "Jane Smith"
  end
  
  it "should accept and use a regex agrument" do
    wierd_address = %Q{foo[bar]@example.com}
    
    valid_items_hash, invalid_items_array = EmailAddressesParser.parse_list(wierd_address)
    valid_items_hash.size.must_equal 0
    invalid_items_array.size.must_equal 1
    invalid_items_array[0].must_equal "foo[bar]@example.com"
    
    valid_items_hash, invalid_items_array = EmailAddressesParser.parse_list(wierd_address, /[a-z0-9\.\_\%\+\-\[\]]+@[a-z0-9\.\-]+\.[a-z]{2,4}/i)
    valid_items_hash.size.must_equal 1
    invalid_items_array.size.must_equal 0
    valid_items_hash["foo[bar]@example.com"].must_equal ""
  end
  
end