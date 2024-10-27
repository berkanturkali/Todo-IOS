//

import SwiftUI

struct AddTodoScreen: View {
    
    @StateObject private var viewModel = AddTodoScreenViewModel()
    
    private let characterLimit = 100
    
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
                            DropDownItem(selectedValue: viewModel.selectedCategory.title) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    viewModel.clickedItem = .categories
                                }
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.importance, icon: "exclamationmark") {
                            DropDownItem(selectedValue: viewModel.selectedCategory.title) {
                                viewModel.clickedItem = .importance
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.date, icon: "calendar.badge.clock") {
                            DropDownItem(selectedValue: viewModel.selectedCategory.title) {
                                // show importance number picker
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.time, icon: "clock") {
                            DropDownItem(selectedValue: viewModel.selectedCategory.title) {
                                // show importance number picker
                            }
                        }
                        
                        SwitchSectionItem(label: LocalizedStrings.notifyMe, isOn: $viewModel.notifyMe)
                        
                        TodoSection(title: LocalizedStrings.yourTask, icon: "pencil.and.list.clipboard") {
                            
                            VStack(spacing: 12) {
                                
                                TextEditor(text: $viewModel.theTask)
                                    .onChange(of: viewModel.theTask) {
                                        if (viewModel.theTask.count > characterLimit) {
                                            viewModel.theTask = String(viewModel.theTask.prefix(characterLimit))
                                        }
                                    }
                                    .padding()
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 150)
                                    .modifier(BackgroundModifier(shadowX: 8, shadowY: 8))
                                    .accentColor(.text)
                                
                                Text(String(format: LocalizedStrings.xCharactersRemaining, (characterLimit - viewModel.theTask.count)))
                                    .font(.custom(Typeface.semibold, size: 12))
                                    .foregroundColor(viewModel.theTask.count > characterLimit - 10 ? .red : .text)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    
                }
            }
            .blurOnAlert(isAlertVisible: viewModel.showPicker)
            
            TodoPickerView(isVisible: $viewModel.showPicker, options: viewModel.pickerList) { _ in
                
            }
            
        }
        
    }
}

#Preview {
    AddTodoScreen()
}
