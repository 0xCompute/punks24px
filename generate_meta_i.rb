require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks24px.i.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


 
def pick_worker( opts )
  opt =  opts[ rand( opts.size ) ]
  opt = pick( opt )  if opt.is_a?( Array )   ## allow nested options
  opt
end

def pick( opts )
  opt = pick_worker( opts )

  if opt.include?( '+' )  ## check for combo(s)
    opt.split( '+' ).map { |el| el.strip }
  else   
    opt
  end
end

def x( opt, count: )
   opts = []
   count.times { opts << opt }
   opts
end

def x2( opt ) x( opt, count: 2 ); end
def x3( opt ) x( opt, count: 3 ); end
def x4( opt ) x( opt, count: 4 ); end
def x5( opt ) x( opt, count: 5 ); end
def x6( opt ) x( opt, count: 6 ); end
def x7( opt ) x( opt, count: 7 ); end
def x8( opt ) x( opt, count: 8 ); end
def x9( opt ) x( opt, count: 9 ); end
def x10( opt ) x( opt, count: 10 ); end



def generate_punk( *values  )
  id              = values[0].to_i(10)
  punk_type       = values[1]
  attribute_names = (values[2] || '' ).split( '/').map { |attr| attr.strip }


  ## only convert "unminted"
  if id > 27 

  fast_food =  [ 
                *x6( 'Cap M' ),
                *x2( 'Cap M Flipped' ), 
                ['Cap M White', 'Cap M Gray', 'Cap M Black'],
                'Cap Sub',
                'Cap W',
                'Cap Br', 
                'Cap Brk',
                'Cap Dom',
                'Cap Dunk',
                'Cap Hut',
                'Cap KFC', 
                ['Bucket Hat M', 'Crown Burger King', 'Safari Hat KFC'], 
              ]
              
  hoodie = [ *x8( 'Hoodie' ),
              [ *x4( 'Hoodie Dark' ), 
                *x2( 'Hoodie Light' ),
                [*x2('Hood Dark'), 'Hood Pharoah']
              ] 
            ]


  cigarette = [ *x10( 'Cigarette' ), 
                [*x2( 'Bubble Gum' ), 
                'Cigar',
                ]
              ]

  pilot_helmet = [ *x2( 'Pilot Helmet'),
                   'Hoodie',
                   'Hoodie Pink (F)', 
                 ]
  tiara = [ *x2( 'Tiara'),
            ['Straight Hair Dark + Bow',
             'Straight Hair + Bow',
             'Straight Hair Blonde + Bow'], 
            ['Straight Hair Blonde + Flowers',
             'Straight Hair + Flowers',
             'Straight Hair Dark + Flowers' ],  ## fix - add hair - why? why?
           ]
            
  cap_forward = [ *x4( 'Cap Forward'),
                  ['Birthday Hat', 'Jester Hat'],
                ]

  big_shades = [ *x9( 'Big Shades' ),
                      'Heart Shades',
                ]


  attribute_names = attribute_names.map do |attribute_name|
          case attribute_name
          when 'Police Cap'   then pick( fast_food ) 
          when 'Cap Forward'   then pick( cap_forward ) 
          when 'Hoodie'       then pick( hoodie ) 
          when 'Cigarette'    then pick( cigarette ) 
          when 'Big Shades'    then pick( big_shades ) 
          when 'Pilot Helmet' then pick( pilot_helmet )  # female only
          when 'Tiara'        then pick( tiara )  # female only
          when 'VR'           
               ## hack - add (m) or (f) for patch
              punk_type.downcase.index('female') ? 'VR (F)' : 'VR (M)'
          else attribute_name
          end
  end
  end

  
  [punk_type, *attribute_names.flatten]
end # method generate


##
# let's go - generate all 10 000 using the records

srand( 4242 )   ## make deterministic


meta = []
recs.each_with_index do |rec,i|
  puts "==> punk #{i}:"
  pp rec

  values = rec.values
  attributes = generate_punk( *values )

  type            = attributes[0]
  more_attributes = attributes[1..-1]

  meta << [i.to_s, type, more_attributes.join( ' / ')]   
end



headers = ['id', 'type', 'attributes']
File.open( "./punks24px.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end

puts "bye"

