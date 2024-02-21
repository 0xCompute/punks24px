require 'pixelart'


recs = read_csv( "./punks24px.csv" )
puts "    #{recs.size} record(s)"


fast_food = ['Cap M',
             'Cap M Flipped', 
             'Cap M White', 'Cap M Gray', 'Cap M Black',
            'Cap Sub',
           'Cap W',
           'Cap Br', 
            'Cap Brk',
            'Cap Dom',
             'Cap Dunk',
             'Cap Hut',
             'Cap KFC', 
             'Bucket Hat M', 'Crown Burger King', 'Safari Hat KFC'
           ]


punks =  recs.select do |rec| 
                             found = false
                             fast_food.each do |q|
                                 if rec['attributes'].index( q )
                                    found = true
                                    break  
                                 end
                             end
                            found
                          end
puts "    #{punks.size} punks record(s)"
#=>  202 punk record(s)

composite = ImageComposite.new( 20, 11, 
                                  width: 24, height: 24 )

                                  
punks.each do |punk|
    num =  "%04d" % punk['id'].to_i(10)
    img = Image.read( "./i/punk#{num}.png" )

    composite << img
end


composite.save( "./tmp/fastfood.png" )
composite.zoom(4).save( "./tmp/fastfood@4x.png" )

puts "bye"
