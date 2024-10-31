//

import SwiftUI
import Charts

struct StatisticItem: View {
    
    let data: [Int] = [5, 2, 3, 4]
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Chart(data, id: \.self) { item in
                        SectorMark(
                            angle: .value(
                                "Count",
                                item
                            ),
                            innerRadius:
                                    .ratio(
                                        0.3
                                    ),
                            outerRadius: .ratio(0.95),
                            angularInset: 2
                        )
                    }
                    .frame(width: 80, height: 80)
                    .modifier(
                        BackgroundModifier(
                            radius: 80,
                            shadowX: 6,
                            shadowY: 4
                        )
                    )
                    .scaledToFit()
                    
                    
                    VStack {
                        ForEach(1...5, id:\.self) {i in
                            Text(" Text \(i)")
                                .font(.custom(Typeface.medium, size: 12))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                VStack(spacing: 14) {
                    ForEach(1...5, id: \.self) {_ in
                        StatisticSection()
                    }
                }                
            }
        }
        .padding(.vertical, 32)
        .modifier(BackgroundModifier())
        
    }
}

#Preview {
    StatisticItem()
}
