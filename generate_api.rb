require 'cocos'

specs = read_csv( "./punks24px.csv" )

=begin
 {"name":"#0",
   "image":"https://live---metadata-5covpqijaa-uc.a.run.app/images/0",
    "external_url":"https://www.proof.xyz/moonbirds/0",
    "attributes":[
        {"trait_type":"Eyes","value":"Angry"},
        {"trait_type":"Outerwear","value":"Hoodie Down"},
        {"trait_type":"Body","value":"Tabby"},
        {"trait_type":"Feathers","value":"Gray"},
        {"trait_type":"Background","value":"Green"},
        {"trait_type":"Beak","value":"Small"}]
  }
=end

specs.each_with_index do |rec, i|
     # break if i > 10

     print "."
     print i    if i % 100 == 0     

     base        = rec['type']
     attributes = (rec['attributes'] || '' ).split( '/').map { |attr| attr.strip }

     item_attributes = []
     item_attributes << { 'trait_type' => 'type',
                          'value'      => base }
     attributes.each do |attr|   ## change name to attribute (from accessory)
         item_attributes << { 'trait_type' => 'attribute',
                              'value'      => attr } 
     end
  
     item_attributes <<  { 'trait_type' => 'attribute count',
                           'value' => attributes.size.to_s }  ## number (type) possible?

     num = "%04d" % i
     # puts "==> punk #{num}"
  
     item =  {
              'name' => "Punk 24px \##{i}",
              'image' => "https://github.com/0xCompute/punks24px/raw/master/i/punk#{num}.png",
              'attributes' => item_attributes
           }   
    
     write_json( "./metadata/#{i}", item )
end


puts "bye"


