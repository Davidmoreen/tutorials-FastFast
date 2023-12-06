import Foundation

struct DateUtil {
    static let FIVE_SECONDS = 5
    static let FOUR_HOURS_IN_SECONDS = 4 * 60 * 60
    static let EIGHT_HOURS_IN_SECONDS = 8 * 60 * 60
    static let TWELVE_HOURS_IN_SECONDS = 12 * 60 * 60
    static let SIXTEEN_HOURS_IN_SECONDS = 16 * 60 * 60
    static let TWENTYFOUR_HOURS_IN_SECONDS = 24 * 60 * 60

    static func elapsedString(start: Date, end: Date = Date()) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: start, to: end)

        var timeDifferenceString = ""

        if let hours = components.hour {
            timeDifferenceString += "\(hours)h "
        }

        if let minutes = components.minute {
            timeDifferenceString += "\(minutes)m "
        }

        if let seconds = components.second {
            timeDifferenceString += "\(seconds)s"
        }

        return timeDifferenceString.trimmingCharacters(in: .whitespaces)
    }
}
