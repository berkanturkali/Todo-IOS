//

import Foundation


@MainActor
class ProfileScreenViewModel: ObservableObject {
    
    private let todoService = TodoService.shared
    
    @Published var showLoadingOnTheProfileSection: Bool = false
    
    @Published var showLoadingOnTheStatsSection: Bool = false
    
    @Published var profileInfo: FetchProfileResponseModel? = nil
    
    @Published var stats: [Stat] = []
    
    @Published var errorMessage: String? = nil
    
    init() {
        Task {
            await fetcProfile()
            await fetchAllStats()
        }
        
    }
    
    func fetcProfile() async {
        guard !showLoadingOnTheProfileSection else { return }
        
        do {
            showLoadingOnTheProfileSection = true
            
            let response = try await todoService.fetchProfile()
            
            profileInfo = response
        } catch {
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
            print(errorMessage)
        }
        
        showLoadingOnTheProfileSection = false
        
    }
    
    func fetchAllStats() async {
        guard !showLoadingOnTheStatsSection else { return }
        
        showLoadingOnTheStatsSection = true
        
        do {
            let response = try await todoService.fetchAllStats()
            
            stats = response
        } catch {
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
            print(errorMessage)
        }
        
        showLoadingOnTheStatsSection = false
    }
    
}
