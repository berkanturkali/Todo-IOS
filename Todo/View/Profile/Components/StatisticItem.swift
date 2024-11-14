//

import SwiftUI
import Charts

struct StatisticItem: View {
    
    let stat: Stat
    
    let importantColor = Color(red: 0.91, green: 0.59, blue: 0.48)
    let normalColor = Color(red: 1.0, green: 0.85, blue: 0.73)
    let completedColor = Color(red: 0.6, green: 0.98, blue: 0.6)
    let activeColor = Color(red: 0.53, green: 0.81, blue: 0.92)
    
    private func getPieChartData() -> [PieChartData] {
        let data = [
            PieChartData(
                title: LocalizedStrings.active,
                value: Double(
                    stat.active ?? 0
                ),
                color: activeColor
            ),
            PieChartData(
                title: LocalizedStrings.completed,
                value: Double(
                    stat.completed ?? 0
                ),
                color: completedColor
            ),
            PieChartData(
                title: LocalizedStrings.important,
                value: Double(
                    stat.important ?? 0
                ),
                color: importantColor
            ),
            PieChartData(
                title: LocalizedStrings.normal,
                value: Double(
                    stat.notImportant ?? 0
                ),
                color: normalColor
            )
        ]
        
        return data
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 32) {
                    ZStack {
                        Chart(getPieChartData()) { item in
                            SectorMark(
                                angle: .value("Value", item.value),
                                innerRadius: .ratio(0.6)
                            )
                            .foregroundStyle(item.color)
                        }
                        
                        .frame(width: 120, height: 120)
                        .modifier(
                            BackgroundModifier(
                                radius: 80,
                                shadowX: 6,
                                shadowY: 4
                            )
                        )
                        .scaledToFit()
                        
                        VStack {
                            if let category = stat.category {
                                Text(
                                    category.capitalized
                                )
                                .font(
                                    .custom(
                                        Typeface.medium,
                                        size: 9
                                    )
                                )
                                .foregroundColor(
                                    .text
                                )
                            }
                            
                            Text(
                                String(
                                    format: LocalizedStrings.totalWithCount,
                                    stat.total ?? 0
                                )
                            )
                            .font(.custom(Typeface.medium, size: 10))
                            .foregroundColor(.text)
                        }
                        
                    }
                    
                    
                    VStack(alignment: .leading) {
                        ForEach(getPieChartData()) { item in
                            HStack {
                                Circle()
                                    .fill(item.color)
                                    .frame(width: 12, height: 12)
                                    .modifier(
                                        ShadowModifier(
                                            x: 2,
                                            y: 1.5
                                        )
                                    )
                                
                                Text(item.title)
                                    .font(.custom(Typeface.medium, size: 14))
                                    .foregroundColor(.text)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                VStack(spacing: 14) {
                    
                    if let _ = stat.active {
                        StatisticSection(
                            title: LocalizedStrings.active,
                            value: "\(stat.active!)"
                        )
                    }
                    
                    if let _ = stat.completed {
                        StatisticSection(
                            title: LocalizedStrings.completedStatisticTitle,
                            value: "\(stat.completed!)"
                        )
                    }
                    
                    if let _ = stat.important {
                        StatisticSection(
                            title: LocalizedStrings.important,
                            value: "\(stat.important!)"
                        )
                    }
                    
                    if let _ = stat.notImportant {
                        StatisticSection(
                            title: LocalizedStrings.normal,
                            value: "\(stat.notImportant!)"
                        )
                    }
                    
                    
                }
            }
        }
        .padding(.vertical, 32)
        .modifier(BackgroundModifier())
        
    }
}

#Preview {
    StatisticItem(
        stat: .init(
            total: 5,
            important: 2,
            notImportant: 1,
            completed: 2,
            active: 0,
            category: "Shopping"
        )
    )
}
