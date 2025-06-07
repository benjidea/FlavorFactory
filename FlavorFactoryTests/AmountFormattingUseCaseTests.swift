import Foundation
import Testing

@testable import FlavorFactory

struct AmountFormattingUseCaseTests {
    @Test(arguments: [
        (5, "5"),
        (0.8, "0,8"),
        (0.85, "0,85"),
        (1.234, "1,23"),
        (1.239, "1,24"),
        (0, "0"),
        (-2.5, "-2,5"),
    ])
    func formatsAmount_deDE(_ input: Double, _ expected: String) {
        let useCase = AmountFormattingUseCaseImpl(locale: Locale(identifier: "de_DE"))
        let formatted = useCase(input)
        #expect(formatted == expected, "[de_DE] Failed for input: \(input), got: \(formatted)")
    }

    @Test(arguments: [
        (5, "5"),
        (0.8, "0.8"),
        (0.85, "0.85"),
        (1.234, "1.23"),
        (1.239, "1.24"),
        (0, "0"),
        (-2.5, "-2.5")
    ])
    func formatsAmount_enUS(_ input: Double, _ expected: String) {
        let useCase = AmountFormattingUseCaseImpl(locale: Locale(identifier: "en_US"))
        let formatted = useCase(input)
        #expect(formatted == expected, "[en_US] Failed for input: \(input), got: \(formatted)")
    }
}
