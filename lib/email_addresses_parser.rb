require "email_addresses_parser/version"

module EmailAddressesParser
  extend self
  
  ## Usage: email_addresses_list = (a bunch of email addresses, optionally with names, comma or newline separated)
  ## valid_items_hash, invalid_items_array = EmailAddressesParser.parse_list(email_addresses_list)
  
  ## This should cover almost any case you're likely to see in a web app environment - see http://www.regular-expressions.info/email.html
  ## You can supply your own regex as the optional second arg to the method if this one doesn't satisfy your use case.
  DEFAULT_REGEX = Regexp.new('[a-z0-9\.\_\%\+\-]+@[a-z0-9\.\-]+\.[a-z]{2,4}', true)
  
  def parse_list(list, r=DEFAULT_REGEX)
    raise "First arg must be a string" unless list.kind_of?(String)
    valid_items, invalid_items = {}, []
    
    ## split the list on commas and/or newlines
    list_items = list.split(/[,\n]+/)
    
    list_items.each do |item|
      if m = r.match(item)
        ## get the email address
        email = m[0]
        ## get everything before the email address
        before_str = item[0, m.begin(0)]
        ## get everything after the email address
        after_str = item[m.end(0), item.length]
        ## enter the email as a valid_items hash key (eliminating dups)
        ## make the value of that key anything before the email if it contains any alphnumerics, stripping out any carats and leading/trailing space   
        if /\w/ =~ before_str
          valid_items[email] = before_str.gsub(/[\<\>\"]+/, '').strip
        ## if nothing before the email, make the value of that key anything after the email, stripping out any carats and leading/trailing space 
        elsif /\w/ =~ after_str
          valid_items[email] = after_str.gsub(/[\<\>\"]+/, '').strip
        ## if nothing after the email either, make the value of that key an empty string
        else
          valid_items[email] = ''
        end
      else
        invalid_items << item.strip if item.strip.length > 0
      end
    end
    
    [valid_items, invalid_items]
  end
end
