$LOAD_PATH.unshift( "../../cryptopunksnotdead/cryptopunks/punks/lib" )
require 'punks'



specs = read_csv( "./punks24px.csv" )



##
#  more new ethscribed archetypes & attributes
ETHSCRIBED_PATCH = {
  'malegreen'       =>  Image.read( './more/male_green.png'),
  'femalegreen'     =>  Image.read( './more/female_green.png'),

  'vrm'         =>  Image.read( './more2/visionpro-male.png'),
  'vrf'         =>  Image.read( './more2/visionpro-female.png'),
 
  'hoodiedark'   =>  Image.read( './more2/hoodie-dark.png' ),
  'hoodielight'   => Image.read( './more2/hoodie-light.png' ),
  'hooddark'      => Image.read( './more2/hood-dark.png' ),
  'hoodpharoah'   =>  Image.read( './more2/hood-pharoah.png' ),
  'hoodiepinkf'  =>  Image.read( './more2/hoodie-pink_(f).png' ),
}


specs.each_with_index do |rec, i|
     # break if i > 10

     base        = rec['type']
     attributes = (rec['attributes'] || '' ).split( '/').map { |attr| attr.strip }
     
     spec = [base] + attributes

     img = Punk::Image.generate( *spec, patch: ETHSCRIBED_PATCH )
     
     num = "%04d" % i
     puts "==> punk #{num}"
     img.save( "./i/punk#{num}.png" )
end


puts "bye"
