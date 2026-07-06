import Foundation

/// Common interface for types that represent a publication cycle.
public protocol AnyCycle {
  /// Human-readable cycle identifier (e.g., "2507").
  var name: String { get }

  /// Whether this cycle is currently effective (not yet expired).
  var isEffective: Bool { get }
}
