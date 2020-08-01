//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

/// Decodes `String` values of format `y-MM-dd` as a `Date`.
///
/// `@YearMonthDayDate` decodes string values of format `y-MM-dd` as a `Date`. Encoding the `Date` will encode the value back into the original string format.
///
/// For example, decoding json data with a `String` representation  of `"2001-01-01"` produces a valid `Date` representing January 1st, 2001.
public struct YearMonthDayStrategy: DateValueCodableStrategy {
    private static let dateFormatter = DateFormatter().then {
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.dateFormat = "y-MM-dd"
    }
    
    public static func decode(_ value: String) throws -> Date {
        if let date = YearMonthDayStrategy.dateFormatter.date(from: value) {
            return date
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format!"))
        }
    }
    
    public static func encode(_ date: Date) -> String {
        return YearMonthDayStrategy.dateFormatter.string(from: date)
    }
}
