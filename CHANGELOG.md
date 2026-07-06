# Change Log

## [1.0.0] - 2026-07-06

Initial release.

The shared wire-format schema for the SF50 TOLD navigation database: `AirportDataCodable`
and its nested types, `SurfaceType`, `AnyCycle`, `Geomagnetism`, and the platform-independent
`GeoCalculations` primitives. Consumed by the iOS app (`import NavData`) and by the nav-data
generator that publishes per-cycle `.plist.lzma` releases.
