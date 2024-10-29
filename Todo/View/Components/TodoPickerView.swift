//

import SwiftUI

struct TodoPickerView: View {
    
    @State var selectedValue: String
    
    @State private var pickerOffset: CGFloat = UIScreen.main.bounds.height
    
    @Binding var isVisible: Bool
    
    let title: String
    
    let options: [String]
    
    let onDoneButtonPressed: (String) -> Void
    
    var body: some View {
        if isVisible {
            ZStack {
                
                Picker("Value", selection: $selectedValue) {
                    ForEach(options, id: \.self) { option in
                        Text("\(option)").tag(option)
                            .font(.custom(Typeface.medium, size: 18))
                    }
                    
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .overlay {
                    ZStack {
                        
                        Text(title)
                            .padding(.horizontal)
                            .background(Color.background)
                            .padding(.vertical)
                            .font(.custom(Typeface.semibold, size: 18))

                        Image(systemName: "checkmark")
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                withAnimation {
                                    pickerOffset = UIScreen.main.bounds.height
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    isVisible.toggle()
                                    onDoneButtonPressed(selectedValue)
                                }
                            }
                            .padding()
                            .font(.title3)
                            .foregroundColor(.text)
                            .fontWeight(.medium)
                    
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .modifier(BackgroundModifier(radius: 18, shadowX: 8, shadowY: -12))
                .onAppear {
                    withAnimation(.snappy) {
                        pickerOffset = 0
                    }
                }
                .offset(y: pickerOffset)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.background.opacity(0.2))
            .onTapGesture {
                withAnimation {
                    pickerOffset = UIScreen.main.bounds.height
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isVisible.toggle()
                }
                
            }
            .animation(.snappy, value: isVisible)
            
        }
    }
}

#Preview {
    TodoPickerView(
        selectedValue: "",
        isVisible: .constant(true),
        title: AddNewTodoClickedItem.categories.title,
        options: Category.allCases.map { category in
            category.title
        }) { _ in
            
        }
}
