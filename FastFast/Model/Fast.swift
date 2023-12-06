import Foundation

struct Fast {
    let startDate: Date
    let selectedFastLength: Int
    let endDate: Date?

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: startDate)
    }

    var elapsedString: String? {
        guard let endDate else { return nil }
        return DateUtil.elapsedString(start: startDate, end: endDate)
    }
}
