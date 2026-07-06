import Foundation

/// Runway surface type, distinguishing grooved and PFC surfaces for RwyCC factor lookup.
public enum SurfaceType: String, Codable, CaseIterable, Sendable {
  case paved
  case grooved
  case pfc
  case turf

  /// Whether this surface type is unpaved (grass/turf)
  public var isTurf: Bool { self == .turf }

  /// Whether this surface type has grooved or PFC treatment
  public var isGroovedOrPFC: Bool { self == .grooved || self == .pfc }
}
