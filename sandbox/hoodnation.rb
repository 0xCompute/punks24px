require 'pixelart'


recs = read_csv( "./punks24px.csv" )
puts "    #{recs.size} record(s)"

punks =  recs.select do |rec| 
                            rec['attributes'].index( 'Hood Dark' ) ||
                            rec['attributes'].index( 'Hood Pharoah' ) 
                          end
puts "    #{punks.size} punks record(s)"
#=> 6 punks record(s)


composite = ImageComposite.new( 10, 1, 
                                  width: 24, height: 24 )

                                  
punks.each do |punk|
    num =  "%04d" % punk['id'].to_i(10)
    img = Image.read( "./i/punk#{num}.png" )

    composite << img
end


composite.save( "./tmp/hoodnation.png" )
composite.zoom(4).save( "./tmp/hoodnation@4x.png" )

puts "bye"
