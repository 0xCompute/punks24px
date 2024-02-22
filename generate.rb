$LOAD_PATH.unshift( "../../cryptopunksnotdead/cryptopunks/punks/lib" )
require 'punks'



specs = read_csv( "./punks24px.csv" )



##
#  more new ethscribed archetypes & attributes
ETHSCRIBED_PATCH = {
  'malegreen'       =>  Image.read( './more/male_green.png'),
  'femalegreen'     =>  Image.read( './more/female_green.png'),

  'aliengreen' =>  Image.read( './more/alien-male_green.png'),
  'apegreen' => Image.read( './more/ape-male_green.png'),
  'demongreen' => Image.read( './more/demon-male_green.png'),
  'mummygreen' => Image.read( './more/mummy-male_green.png'),
  'orcgreen' => Image.read( './more/orc-male_green.png'),
  'robotgreen' => Image.read( './more/robot-male_green.png'),
  'skeletongreen' => Image.read( './more/skeleton-male_green.png'),
  'vampiregreen' => Image.read( './more/vampire-male_green.png'),
  'zombiegreen' => Image.read( './more/zombie-male_green.png'),

  'alienfemalegreen' =>  Image.read( './more/alien-female_green.png'),
  'apefemalegreen' => Image.read( './more/ape-female_green.png'),
  'demonfemalegreen' => Image.read( './more/demon-female_green.png'),
  'mummyfemalegreen' => Image.read( './more/mummy-female_green.png'),
  'orcfemalegreen' => Image.read( './more/orc-female_green.png'),
  'robotfemalegreen' => Image.read( './more/robot-female_green.png'),
  'skeletonfemalegreen' => Image.read( './more/skeleton-female_green.png'),
  'vampirefemalegreen' => Image.read( './more/vampire-female_green.png'),
  'zombiefemalegreen' => Image.read( './more/zombie-female_green.png'),

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
