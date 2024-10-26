//

import SwiftUI

struct FiltersScreen: View {
    
    @State var selectedFilter: Filter? = nil
    
    @State var isCheckMarkActive: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                FilterTopBar(isCheckMarkActive: $isCheckMarkActive)
                    .padding(.top, 12)
                
                VStack(spacing: 20) {
                    ForEach(Filter.allCases, id: \.self) { filter in
                        FilterItem(filter: filter, isSelected: selectedFilter == filter)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                isCheckMarkActive = selectedFilter != filter
                                if(selectedFilter == filter) {
                                    selectedFilter = nil
                                    return
                                }
                                selectedFilter = filter
                            }
                    }
                }
                .frame(maxHeight: .infinity,alignment: .top)
            }
        }
    }
}

#Preview {
    FiltersScreen()
}
