//

import Foundation

struct Todo: Hashable, Codable {
    let _id: String
    let category: String
    let date: Double
    let todo: String
    let completed: Bool
    let important: Bool
    
    var categoryEnum: Category {
        return Category(rawValue: category.lowercased())!
    }
    
    var formattedDate: String {
        formatDate()
    }
    
    private func convertSecondsToDate() -> Date {
        return Date(timeIntervalSince1970: date)
    }
    
    private func formatDate() -> String {
        let mDate = convertSecondsToDate()
        let calendar = Calendar.current
        
        let now = Date()
        
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: now)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: mDate)
        
        if(calendar.isDateInToday(mDate)){
            return "Today"
        } else if(calendar.isDateInYesterday(mDate)) {
            return "Yesterday"
        } else if (calendar.isDateInTomorrow(mDate)){
            return "Tomorrow"
        } else if(dateComponents.year == nowComponents.year && dateComponents.month == nowComponents.month) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "d MMM"
            
            return dateFormatter.string(from: mDate)
        } else {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "d MMM yyyy"
            return dateFormatter.string(from: mDate)
        }
    }
    
    
    
    static var mockTodo: Todo {
        return Todo(
            _id: UUID().uuidString,
            category: Category.all.title,
            date: 12312312,
            todo: "Get Married",
            completed: true,
            important: true
        )
    }
}
