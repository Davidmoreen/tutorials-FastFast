import Foundation

struct Fast: Equatable {
    let startDate: Date
    let selectedFastLengthSeconds: Int
    let endDate: Date?

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: startDate)
    }

    var elapsedString: String? {
        guard let endDate else { return nil }
        return DateUtil.elapsedString(start: startDate, end: endDate)
    }
}
