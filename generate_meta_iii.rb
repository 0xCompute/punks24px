require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks24px.iii.csv' )
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


def cleanup( attribute_names, *names )
    attribute_names.select do |attribute_name|
           names.include?( attribute_name ) ? false : true
    end
end




STATS = Hash.new(0)


def generate_punk( *values  )
  id              = values[0].to_i(10)
  punk_type       = values[1]
  attribute_names = (values[2] || '' ).split( '/').map { |attr| attr.strip }


  ## only convert "unminted"
  if id > 32

    ape = [
    'Ape Black', 
    'Ape Golden Brown',
    'Ape Cheetah',
    'Ape Blue',
    'Ape DMT',
    'Ape Pink',
    'Ape Red',
    'Ape Tan',
    'Ape Cream',
    'Ape White',
    'Ape Trippy',
    'Ape Noise',
    'Ape Solid Gold',
    'Ape Bot',
    'Ape Death Bot',
    ]

    alien_m = [
        *x3('Alien'),
        'Alien Red',
        'Alien Gold 1', 
        'Alien 120°',  # cyber green 
        'Alien Orange',
        'Alien Blue',
        'Alien Violet',
        ['Alien (Ape)', 
         'Alien (Ape) Red', 'Alien (Ape) 120°', 'Alien (Ape) Blue',  
        ], 
    ]

    alien_f = [
        *x2('Alien Female'),
        'Alien Female Red',
        'Alien Female Gold 1',  
        'Alien Female 120°',  # cyber green 
        'Alien Female Orange',
        'Alien Female Blue',
        'Alien Female Violet',
    ]
    

    ## every 5th - turn into an ape
    ## every 11th (10th) - turn into an alien
    if punk_type == 'Male 1'
      count = STATS['Male 1'] += 1
      if count % 5 == 0
         punk_type = pick( ape )   
      elsif count % 11 == 0    ## note: might be a case for count % 5 == 0 too 
         punk_type = pick( alien_m )
      else
        # do nothing
      end  
    elsif punk_type == 'Female 1'
      count = STATS['Female 1'] += 1
      if count % 10 == 0 
         punk_type = pick( alien_f )
      end
    else 
      # do nothing
    end       

    ###
    ## clean-up 
    if punk_type.index( 'Alien') 
      attribute_names = cleanup( attribute_names,
                              'Purple Eye Shadow',
                              'Blue Eye Shadow',
                              'Green Eye Shadow' )
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

