class Car
  def self.find_nearest(x, y)
  	DB["SELECT id, name, st_y(location::geometry) as y, st_x(location::geometry) as x FROM cars
  					WHERE ST_DWithin(location, ST_GeographyFromText('SRID=4326;POINT(40 -74)'), 1000000) AND available=true"].all
  end
end