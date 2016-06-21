module Haversine
  RADIUS=6371
  def self.distance(pos1, pos2)
    unless pos1.is_a?(Array) && pos2.is_a?(Array)
      raise ArgumentError
    end
    lat1 = pos1[0]*Math::PI/180
    lat2 = pos2[0]*Math::PI/180
    long1 = pos1[1]*Math::PI/180
    long2 = pos2[1]*Math::PI/180
    deltaLat=lat2-lat1;
    deltaLon=long2-long1;
    a=Math.sin((deltaLat)/2)**2 + Math.cos(lat1)*Math.cos(lat2) * Math.sin(deltaLon/2)**2
    c=2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    return c*RADIUS
  end

  def self.eta(dist)
    # Maybe be changed to complex algorithm
    dist * 1.5
  end

  def self.calculate_eta(cars=[], call=[])
    unless cars.is_a?(Array)
      raise ArgumentError
    end
    # I will believe, that DB returns to service the real coordinates of cars
    unless call.is_a?(Array) && call.length == 2
      raise ArgumentError
    end
    etas = []
    cars.each { |car| etas.push eta(distance(car, call)) }
    return etas
  end

  def self.eta_median(etas=[])
    (etas.sort[(etas.length - 1) / 2] + etas.sort[etas.length / 2]) / 2.0
  end

  def self.eta_best(etas=[])
    etas.min
  end

end