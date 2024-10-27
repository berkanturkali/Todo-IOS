//

import SwiftUI

struct AddTodoScreen: View {
    
    @State var selectedCategory: Category = .all
    
    @State var notifyMe: Bool = true
    
    @State var theTask: String = ""
    
    @State private var showPicker = false
    
    private let characterLimit = 100
    
    private let categories = Category.allCases.map {
        $0.title
    }
    
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack(spacing: 32) {
                ZStack {
                    BackButton()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(LocalizedStrings.addNewTodo)
                        .font(.custom(Typeface.semibold, size: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.top)
                
                ScrollView {
                    VStack(spacing: 32) {
                        TodoSection(title: LocalizedStrings.category, icon: "square.grid.2x2") {
                            DropDownItem(selectedValue: selectedCategory.title) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    showPicker.toggle()
                                }
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.importance, icon: "exclamationmark") {
                            DropDownItem(selectedValue: selectedCategory.title) {
                                // show importance number picker
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.date, icon: "calendar.badge.clock") {
                            DropDownItem(selectedValue: selectedCategory.title) {
                                // show importance number picker
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.time, icon: "clock") {
                            DropDownItem(selectedValue: selectedCategory.title) {
                                // show importance number picker
                            }
                        }
                        
                        SwitchSectionItem(label: LocalizedStrings.notifyMe, isOn: $notifyMe)
                        
                        TodoSection(title: LocalizedStrings.yourTask, icon: "pencil.and.list.clipboard") {
                            
                            VStack(spacing: 12) {
                                
                                TextEditor(text: $theTask)
                                    .onChange(of: theTask) {
                                        if (theTask.count > characterLimit) {
                                            theTask = String(theTask.prefix(characterLimit))
                                        }
                                    }
                                    .padding()
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 150)
                                    .modifier(BackgroundModifier(shadowX: 8, shadowY: 8))
                                    .accentColor(.text)
                                
                                Text(String(format: LocalizedStrings.xCharactersRemaining, (characterLimit - theTask.count)))
                                    .font(.custom(Typeface.semibold, size: 12))
                                    .foregroundColor(theTask.count > characterLimit - 10 ? .red : .text)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    
                }
            }
            .blurOnAlert(isAlertVisible: showPicker)
            
            TodoPickerView(isVisible: $showPicker, options: categories) {_ in
                
            }
            
        }
        
    }
}

#Preview {
    AddTodoScreen()
}
