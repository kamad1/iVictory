
import Foundation

final class DateHelper {
    static let shared = DateHelper(); private init() { }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy\nHH:mm"
        return dateFormatter.string(from: date)
    }
}

