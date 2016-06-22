class Car
  def self.find_nearest(x, y)
  	DB["SELECT id,
  			name,
  			st_y(location::geometry) as y,
  			st_x(location::geometry) as x,
			ST_Distance(location, 'SRID=4326;POINT(40 -74)'::geography) * 1.5 as distance
		FROM cars
  		WHERE ST_DWithin(location, ST_GeographyFromText('SRID=4326;POINT(40 -74)'), 1000000) AND available=true
  		ORDER BY distance
  		LIMIT 3"].all
  end
end