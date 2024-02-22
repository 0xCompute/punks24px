require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks24px.ii.csv' )
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

    green_m = ['Alien Green', 
                *x2('Ape Green'),
               'Demon Green',
               'Mummy Green',
               'Orc Green',
              'Robot Green',
               'Skeleton Green',
               'Vampire Green',
               *x2('Zombie Green') ]
    green_f = ['Alien Female Green', 
                *x2('Ape Female Green'),
               'Demon Female Green',
               'Mummy Female Green',
               'Orc Female Green',
              'Robot Female Green',
             'Skeleton Female Green',
             'Vampire Female Green',
             *x2('Zombie Female Green') ]

   
    ## every 5th - turn into a special
    if punk_type == 'Male Green'
      count =  STATS['Male Green'] += 1  
      punk_type = pick( green_m )    if count % 5 == 0 
    elsif punk_type == 'Female Green'
      count = STATS['Female Green'] += 1  
      punk_type = pick( green_f )    if count % 5 == 0 
    else
       ## do nothing
    end


    ###
    ## clean-up 
    if punk_type.index( 'Robot') ||
       punk_type.index( 'Mummy' )
       attribute_names = cleanup( attribute_names,
                               'Clown Eyes Blue',
                               'Clown Eyes Green',
                               'Purple Eye Shadow',
                               'Blue Eye Shadow',
                               'Green Eye Shadow',
                               'Eye Mask',
                               'Eye Patch' )
    end  

    if punk_type.index( 'Robot') ||
       punk_type.index( 'Skeleton' ) ||
       punk_type.index( 'Orc') 
       attribute_names = cleanup( attribute_names,
                               'Black Lipstick',
                               'Purple Lipstick',
                               'Hot Lipstick'
                            )
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

