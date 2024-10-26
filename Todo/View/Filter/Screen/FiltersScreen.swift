//

import SwiftUI

struct FiltersScreen: View {
    
    let appliedFilter: Filter
    
    @State var selectedFilter: Filter = .all
    
    @State var isCheckMarkActive: Bool = false
    
    let onCheckMarkTapped: (Filter) -> Void

    
    var body: some View {
        ZStack {
            
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                FilterTopBar(
                    isCheckMarkActive: $isCheckMarkActive,
                    onCheckMarkTapped: {
                        onCheckMarkTapped(selectedFilter)
                    }
                )
                .padding(.top, 24)
                
                VStack(spacing: 20) {
                    ForEach(Filter.allCases, id: \.self) { filter in
                        FilterItem(
                            filter: filter,
                            isSelected: selectedFilter == filter
                        )
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                selectedFilter = filter
                                isCheckMarkActive = selectedFilter != appliedFilter
                            }
                    }
                }
                .frame(maxHeight: .infinity,alignment: .top)
            }
            .modifier(
                BackgroundModifier(
                    strokeColor: .gray.opacity(
                        0.5
                    ),
                    strokeWidth: 1,
                    shadowX: 0,
                    shadowY: 0
                )
            )
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            selectedFilter = appliedFilter
        }
    }
}

#Preview {
    FiltersScreen(
        appliedFilter: Filter.all,
        onCheckMarkTapped: { _ in }
    )
}
