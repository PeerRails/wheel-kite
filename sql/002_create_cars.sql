CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    available boolean,
    location GEOGRAPHY(POINT,4326),
    name VARCHAR(255)
  );

CREATE INDEX car_location_gix ON cars USING GIST ( location );

-- Add some data
INSERT INTO cars (available, location, name) VALUES (true, ST_GeographyFromText('SRID=4326;POINT(40.71427 -74.00197)'), 'Voditel 1' );
INSERT INTO cars (available, location, name) VALUES (true, ST_GeographyFromText('SRID=4326;POINT(40.71428 -74.00597)'), 'Voditel 2' );
INSERT INTO cars (available, location, name) VALUES (true, ST_GeographyFromText('SRID=4326;POINT(40.71423 -74.00397)'), 'Voditel 3' );
INSERT INTO cars (available, location, name) VALUES (false, ST_GeographyFromText('SRID=4326;POINT(40.71123 -74.00397)'), 'Voditel 4' );