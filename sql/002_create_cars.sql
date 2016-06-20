CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    busy boolean,
    position GEOGRAPHY(POINT,4326)
  );
