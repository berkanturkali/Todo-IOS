//

import Foundation
import Combine

@MainActor
class AddTodoScreenViewModel: ObservableObject {
    
    @Published var selectedCategory: Category = .all
    
    @Published var selectedImportance: Importance = .normal
    
    @Published var notifyMe: Bool = false
    
    @Published var theTask: String = ""
    
    @Published var showPicker: Bool = false
    
    @Published var pickerList: [String] = []
    
    @Published var clickedItem: AddNewTodoClickedItem? = nil
    
    @Published var selectedValueOfPicker: String = ""
    
    @Published var messageWithCallback: MessageWithCallback? = nil
    
    @Published var showAlert: Bool = false
    
    @Published var selectedDate = Date()
    
    @Published var selectedTime = Date()
    
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let todoService = TodoService.shared
    
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $clickedItem
            .compactMap {
                $0
            }
            .map { [weak self] clickedItem -> [String] in
                switch clickedItem {
                case .categories:
                    self?.selectedValueOfPicker = self?.selectedCategory.title ?? ""
                    return Category.allCases.map(\.title)
                case .importance:
                    self?.selectedValueOfPicker = self?.selectedImportance.value ?? ""
                    return Importance.allCases.map(\.value)
                }
            }
            .sink { [weak self] list in
                self?.pickerList = list
                self?.showPicker.toggle()
            }
            .store(in: &cancellables)
        
        $messageWithCallback
            .map { $0 != nil }
            .assign(to: \.showAlert, on: self)
            .store(in: &cancellables)
        
    }
    
    func onCheckmarkClicked() async {
        
        guard !isLoading else { return }
        
        let todoIsValid = !theTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        guard todoIsValid else {
            messageWithCallback = MessageWithCallback(
                message: LocalizedStrings.taskCanNotBeEmpty
            ) {
                self.messageWithCallback = nil
            }
            return
        }
        
        let requestModel = AddNewTodoRequestModel(
            category: selectedCategory.rawValue,
            date: mapDateAndTimeToTimeStamp(),
            todo: theTask,
            important: getImportance(),
            notifyMe: notifyMe
        )
        
        do {
            
            isLoading = true
            let response = try await todoService.addNewTodo(body: requestModel)
            messageWithCallback = MessageWithCallback(message: response) {
                self.messageWithCallback = nil
                self.resetTheScreen()
                
            }
            
        } catch {
            messageWithCallback = MessageWithCallback(message: NetworkManager.shared.handleNetworkError(error as! NetworkError)) {
                self.messageWithCallback = nil
            }
        }
        isLoading = false
        
    }
    
    private func mapDateAndTimeToTimeStamp() -> Int {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(
            [
                .year,
                .month,
                .day
            ],
            from: selectedDate
        )
        
        let timeComponents = calendar.dateComponents(
            [
                .hour,
                .minute
            ],
            from: selectedTime
        )
        
        var combinedComponents = DateComponents()
        
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return Int(calendar.date(from: combinedComponents)?.timeIntervalSince1970 ?? 0)
    }
    
    private func getImportance() -> Bool {
        switch selectedImportance {
        case .normal:
            false
        case .important:
            true
        }
    }
    
    private func resetTheScreen() {
        selectedDate = Date()
        selectedTime = Date()
        selectedImportance = .normal
        selectedCategory = .all
        notifyMe = false
        theTask = ""
        clickedItem = nil
    }
    
}
