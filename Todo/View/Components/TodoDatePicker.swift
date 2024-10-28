//

import SwiftUI

struct TodoDatePicker: View {
    
    @State private var selectedDate = Date()
    
    let calendar = Calendar.current
    
    var today: Date {
        calendar.startOfDay(for: Date())
    }
    
    var endOfYear: Date? {
        calendar
            .date(
                from: DateComponents(
                    year: calendar.component(
                        .year,
                        from: today
                    ),
                    month: 12,
                    day: 31
                )
            )
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .font(.title3)
                    .bold()
                
                Text(LocalizedStrings.date)
                    .font(
                        .custom(
                            Typeface.semibold,
                            size: 18
                        )
                    )
            }
            
            Spacer()
            DatePicker(
                "",
                selection: $selectedDate,
                in: today...(
                    endOfYear ?? today
                ),
                displayedComponents: .date
            )
            .font(.custom(Typeface.black, size: 14))
            .modifier(BackgroundModifier(radius: 12, shadowX: 2, shadowY: 2))
      
            .labelsHidden()
            .accentColor(.text)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 24)
        .padding(.vertical)
        .modifier(BackgroundModifier(radius: 12, shadowX: 2, shadowY: 2))
        .padding(.horizontal, 6)
        
    }
    
}


#Preview {
    TodoDatePicker()
}
