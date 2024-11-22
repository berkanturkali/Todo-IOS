//

import SwiftUI

struct DeleteOptionsScreen: View {
    
    @State var selectedOption: DeleteOptions = .deleteAll
    
    let onDoneButtonPressed: (DeleteOptions) -> Void
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                DeleteOptionsTopBar() {
                    print(
                        "on done button pressed selected option : \(selectedOption.value)"
                    )
                    onDoneButtonPressed(selectedOption)
                }
                    .padding(.top, 24)
                
                VStack(spacing: 4) {
                    ForEach(DeleteOptions.allCases, id: \.self) { option in
                        DeleteOptionItem(
                            option: option,
                            isSelected: selectedOption == option
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, selectedOption == option ? 30 : 0)
                        .onTapGesture {
                            print("selected option : \(option.value)")
                            selectedOption = option
                        }
                        .scaleEffect(selectedOption == option ? 1.1 : 0.9)
                        .animation(.easeInOut(duration: 0.15), value: selectedOption)
                    }
                }
                .frame(maxHeight : .infinity, alignment: .top)
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
    }
}

#Preview {
    DeleteOptionsScreen() { option in
        
    }
}
