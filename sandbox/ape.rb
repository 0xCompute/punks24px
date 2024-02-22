require 'pixelart'


recs = read_csv( "./punks24px.csv" )
puts "    #{recs.size} record(s)"


punks =  recs.select do |rec| 
                              ## all non-(ethscribe) green aliens
                              rec['type'].index( 'Ape' ) &&
                              !rec['type'].index( 'Green' ) &&
                              !rec['type'].index( 'Alien' )
                          end
puts "    #{punks.size} punks record(s)"
#=>  305 punk record(s)


composite = ImageComposite.new( 20, 16, 
                                  width: 24, height: 24 )

                                  
punks.each do |punk|
    num =  "%04d" % punk['id'].to_i(10)
    img = Image.read( "./i/punk#{num}.png" )

    composite << img
end


composite.save( "./tmp/ape.png" )
composite.zoom(4).save( "./tmp/ape@4x.png" )

puts "bye"
