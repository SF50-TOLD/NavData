import Foundation
import Synchronization

/// Shared geographic calculation utilities.
///
/// This enum holds the platform-independent primitives shared between the iOS app
/// and the nav-data generator. Apple-platform extensions (e.g. `CLLocationCoordinate2D`
/// overloads) are layered on in the app.
public enum GeoCalculations {
  /// Mean radius of the Earth in meters.
  private static let earthRadiusM: Double = 6_371_000

  /// Meters per nautical mile (exact by definition).
  private static let metersPerNauticalMile: Double = 1852

  /// Mean radius of the Earth in nautical miles.
  private static let earthRadiusNM = earthRadiusM / metersPerNauticalMile

  /// Shared ``Geomagnetism`` instance for calculating magnetic variation, reused to
  /// avoid expensive re-initialization on each calculation.
  ///
  /// ``Geomagnetism/calculate(longitude:latitude:)`` mutates the instance's stored
  /// `declination` before it is read back, so access is serialized through a `Mutex`
  /// to keep ``calculateMagneticVariation(_:_:)`` safe to call from concurrent tasks.
  private static let geomagnetism = Mutex(Geomagnetism())

  /// Calculates bearing between two points specified in arcseconds.
  /// - Parameters:
  ///   - from: Tuple of (latitude, longitude) in arcseconds
  ///   - to: Tuple of (latitude, longitude) in arcseconds
  /// - Returns: Bearing in degrees (0-360)
  public static func calculateBearing(from: (Float, Float), to: (Float, Float)) -> Float {
    let lat1 = from.0 / 3600 * .pi / 180,
      lat2 = to.0 / 3600 * .pi / 180,
      deltaLon = (to.1 / 3600 - from.1 / 3600) * .pi / 180

    let x = sin(deltaLon) * cos(lat2),
      y = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon)

    let bearing = atan2(x, y) * 180 / .pi
    return (bearing + 360).truncatingRemainder(dividingBy: 360)
  }

  /// Calculates magnetic variation using the WMM model.
  /// - Parameters:
  ///   - latitudeDeg: Latitude in decimal degrees
  ///   - longitudeDeg: Longitude in decimal degrees
  /// - Returns: Magnetic declination in degrees (positive = east)
  public static func calculateMagneticVariation(_ latitudeDeg: Double, _ longitudeDeg: Double)
    -> Double
  {
    geomagnetism.withLock { geomagnetism in
      geomagnetism.calculate(longitude: longitudeDeg, latitude: latitudeDeg)
      return geomagnetism.declination
    }
  }

  /// Calculates distance in nautical miles between two coordinates using the Haversine formula.
  /// - Parameters:
  ///   - fromLat: Origin latitude in decimal degrees
  ///   - fromLon: Origin longitude in decimal degrees
  ///   - toLat: Destination latitude in decimal degrees
  ///   - toLon: Destination longitude in decimal degrees
  /// - Returns: Distance in nautical miles
  public static func calculateDistanceNM(
    fromLat: Double,
    fromLon: Double,
    toLat: Double,
    toLon: Double
  ) -> Double {
    let lat1 = fromLat * .pi / 180,
      lat2 = toLat * .pi / 180,
      deltaLat = (toLat - fromLat) * .pi / 180,
      deltaLon = (toLon - fromLon) * .pi / 180

    // Haversine formula
    let a =
      sin(deltaLat / 2) * sin(deltaLat / 2)
      + cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))

    return earthRadiusNM * c
  }
}
