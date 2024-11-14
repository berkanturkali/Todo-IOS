//

import Foundation
import SwiftUI

struct PieChartData : Identifiable {
    let id = UUID()
    
    let title: String
    
    let value: Double
    
    let color: Color
}
