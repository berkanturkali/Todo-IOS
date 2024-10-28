//

import Foundation
import Combine

class AddTodoScreenViewModel: ObservableObject {
    
    @Published var selectedCategory: Category = .all
    
    @Published var notifyMe: Bool = false
    
    @Published var theTask: String = ""
    
    @Published var showPicker: Bool = false
    
    @Published var pickerList: [String] = []
    
    @Published var clickedItem: AddNewTodoClickedItem? = nil
    
    @Published var isCheckmarkActive: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $clickedItem
            .compactMap {
                $0
            }
            .map { clickedItem -> [String] in
                switch clickedItem {
                case .categories:
                    return Category.allCases.map(\.title)
                case .importance:
                    return Importance.allCases.map(\.value)
                }
            }
            .sink { [weak self] list in
                self?.pickerList = list
                self?.showPicker.toggle()
            }
            .store(in: &cancellables)
    }
    
    func onCheckmarkClicked() {
        
    }
    
}
