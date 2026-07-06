# NavData

The shared wire-format schema for the [SF50 TOLD](https://apps.apple.com/app/sf50-told/id6470008295)
navigation database.

This package defines the `Codable` types that the app decodes from the compressed navigation
data files, so that the app and the data **generator** agree on a single source of truth for the
format. It is deliberately dependency-free and cross-platform (Apple platforms + Linux) so the
generator can build it in CI.

## What's in here

- **`AirportDataCodable`** — the top-level container (airports, runways, procedures, navaids,
  obstacles, and per-source cycle metadata), plus its nested `Codable` types.
- **`SurfaceType`** — runway surface classification.
- **`AnyCycle`** — common interface for FAA publication cycles.
- **`Geomagnetism`** — WMM-based magnetic declination.
- **`GeoCalculations`** — platform-independent bearing, distance, and magnetic-variation
  primitives. (Apple-platform `CoreLocation` conveniences are layered on in the app.)

## Usage

```swift
import NavData

let data = try Data(contentsOf: fileURL)           // decompressed binary plist
let database = try PropertyListDecoder().decode(AirportDataCodable.self, from: data)
```

## Distribution

The compressed data files themselves are published as GitHub Release assets by the generator,
not committed here. This package only versions the *schema*.
