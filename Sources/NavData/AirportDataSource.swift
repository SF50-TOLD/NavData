/**
 A source that contributed data to an airport record.

 The set of sources grows as the generator adds them, so this is an open type: a
 value this version doesn't know still decodes, keeping older apps able to read newer
 files. Raw values match the spellings the app persists.
 */
public struct AirportDataSource: RawRepresentable, Codable, Sendable, Hashable {

  /// FAA National Airspace System Resources.
  public static let NASR = Self(rawValue: "NASR")

  /// The OurAirports community database.
  public static let ourAirports = Self(rawValue: "OurAirports")

  /// The open flightmaps community database.
  public static let openFlightmaps = Self(rawValue: "OpenFlightmaps")

  /// The UK AIP data set, published by NATS.
  public static let NATS = Self(rawValue: "NATS")

  /// Threshold points published by LFV, the Swedish air navigation service provider.
  public static let LFV = Self(rawValue: "LFV")

  /// The source's identifier as written in the data file.
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}
