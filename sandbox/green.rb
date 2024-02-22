require 'pixelart'


recs = read_csv( "./punks24px.csv" )
puts "    #{recs.size} record(s)"


green = [
  'Alien Green', 
  'Ape Green',
 'Demon Green',
 'Mummy Green',
 'Orc Green',
'Robot Green',
 'Skeleton Green',
 'Vampire Green',
  'Zombie Green',
 'Alien Female Green', 
'Ape Female Green',
 'Demon Female Green',
 'Mummy Female Green',
 'Orc Female Green',
'Robot Female Green',
'Skeleton Female Green',
'Vampire Female Green',
 'Zombie Female Green']  


punks =  recs.select { |rec| green.include?( rec['type'] ) }
puts "    #{punks.size} punks record(s)"
#=> 574 punks


composite = ImageComposite.new( 20, 29, 
                                  width: 24, height: 24 )

                                  
punks.each do |punk|
    num =  "%04d" % punk['id'].to_i(10)
    img = Image.read( "./i/punk#{num}.png" )

    composite << img
end


composite.save( "./tmp/green.png" )
composite.zoom(4).save( "./tmp/green@4x.png" )

puts "bye"
