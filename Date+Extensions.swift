import SwiftUI

extension Date{
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    var isPastHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{
        let calender = Calendar.current
        let startOfDate = calender.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calender.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        
        (0..<7).forEach {index in
            if let weekDay = calender.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay)) 
            }    
            
        }
        
        return week
        
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
}
