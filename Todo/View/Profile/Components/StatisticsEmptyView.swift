//

import SwiftUI

struct StatisticsEmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.pie.fill")
                .font(.system(size: 80))

            Text(LocalizedStrings.nothingToSeeHere)
                .font(.custom(Typeface.semibold, size: 20))
                .multilineTextAlignment(.center)

        }
        .foregroundColor(.text.opacity(0.5))
    }
}

#Preview {
    StatisticsEmptyView()
}
