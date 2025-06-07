import Foundation

/// Protocol for formatting ingredient amounts localized (e.g. 1, 1.5, 0.8)
protocol AmountFormattingUseCase {
    func callAsFunction(_ amount: Double) -> String
}

struct AmountFormattingUseCaseImpl: AmountFormattingUseCase {
    let locale: Locale
    let fractionDigits: Int

    init(locale: Locale = .current, fractionDigits: Int = 2) {
        self.locale = locale
        self.fractionDigits = fractionDigits
    }

    func callAsFunction(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: amount)) ?? String(amount)
    }
}
