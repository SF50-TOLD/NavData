# Change Log

## [2.0.0] - 2026-10-31

### Changed

- **BREAKING:** `AirportCodable.recordID` holds a namespaced, stable key
  (`FAA:<site number>`, `ICAO:<location indicator>`, `LOC:<country>:<code>`,
  `OA:<OurAirports id>`, or `OFM:<region>:<code>`) instead of the winning source's raw
  identifier. `AirportCodable.aliases` maps earlier identifiers, including the bare ones
  older files used, to the current key.
- `AirportCodable.dataSource` is spelled as an `AirportDataSource` raw value (`NASR`,
  `OurAirports`, …) and is kept only for app versions that predate `sources`.

### Added

- `AirportDataSource`, an open set of the sources that contribute airport data.
- `AirportCodable.sources`, `aliases`, and `countryCode`.
- `AirportDataCodable.supplementarySources`, describing each additional source with the
  attribution its terms require and, where required, where users report data errors.
- `GeoCalculations.destination(latitudeDeg:longitudeDeg:bearingDeg:distanceM:)`.

## [1.0.0] - 2026-07-06

Initial release.

The shared wire-format schema for the SF50 TOLD navigation database: `AirportDataCodable`
and its nested types, `SurfaceType`, `AnyCycle`, `Geomagnetism`, and the platform-independent
`GeoCalculations` primitives. Consumed by the iOS app (`import NavData`) and by the nav-data
generator that publishes per-cycle `.plist.lzma` releases.
