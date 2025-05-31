import Foundation

/// Formatting for amounts (e.g. 1, 1.5, 1.25)
extension Double {
    var cleanAmount: String {
        if truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.2f", self)
        }
    }
}
