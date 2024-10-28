//

import SwiftUI

struct AddTodoScreen: View {
    
    @StateObject private var viewModel = AddTodoScreenViewModel()
    
    private let characterLimit = 100
    
    @State var showDatePicker = false
    
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack(spacing: 16) {
                VStack {
                    ZStack {
                        BackButton()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Text(LocalizedStrings.addNewTodo)
                            .font(.custom(Typeface.semibold, size: 20))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Image(systemName: "checkmark")
                            .font(.title3)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .foregroundColor(viewModel.isCheckmarkActive ? .text : .text.opacity(0.5))
                            .onTapGesture {
                                if(viewModel.isCheckmarkActive) {
                                    viewModel.onCheckmarkClicked()
                                }
                            }
                        
                    }
                    .padding(.top)
                    Divider()
                }
                
                ScrollView {
                    VStack(spacing: 32) {
                        TodoSection(title: LocalizedStrings.category, icon: "square.grid.2x2") {
                            AddNewTodoListItem(selectedValue: viewModel.selectedCategory.title) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    viewModel.clickedItem = .categories
                                }
                            }
                        }
                        
                        TodoSection(title: LocalizedStrings.importance, icon: "exclamationmark") {
                            AddNewTodoListItem(selectedValue: viewModel.selectedCategory.title) {
                                viewModel.clickedItem = .importance
                            }
                        }
                        
                        TodoDatePicker()
                        
                        TodoTimePicker()
                        
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
                .scrollIndicators(.hidden)
            }
            .blurOnAlert(isAlertVisible: viewModel.showPicker)
            
            TodoPickerView(
                isVisible: $viewModel.showPicker,
                title: viewModel.clickedItem?.title ?? "",
                options: viewModel.pickerList
            ) { _ in
                
            }
            
        }
        
    }
}

#Preview {
    AddTodoScreen()
}
