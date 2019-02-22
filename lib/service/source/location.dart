// dummy
final lat = -6.892534;
final long = 107.613463;

class Location {
  final double latitude;
  final double longitude;

  const Location(this.latitude, this.longitude);
}

class LocationService {
  static Location gerCurrentLocation() {
    return Location(lat, long);
  }
}
