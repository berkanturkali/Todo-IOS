//

import SwiftUI

struct TodoTimePicker: View {
    
    @Binding var selectedTime: Date
    
    @Binding var timeRange: ClosedRange<Date>
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "clock")
                    .font(.title3)
                    .bold()
                
                Text(LocalizedStrings.time)
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
                selection: $selectedTime,
                in: timeRange,
                displayedComponents: .hourAndMinute
            )
            .modifier(BackgroundModifier(radius: 12, shadowX: 2, shadowY: 2))
            .labelsHidden()
            .accentColor(.text)
        }
        
        .padding(.horizontal, 24)
        .padding(.vertical)
        .modifier(BackgroundModifier(radius: 12, shadowX: 2, shadowY: 2))
        .padding(.horizontal, 6)
    }
}
