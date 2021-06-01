import Foundation

class WebViewViewModel: ObservableObject {
    
    @Published var address = "https://duckduckgo.com"
    @Published var isEditing = false
    
    var title: String? {
        let url = URL(string: address)
        return url?.absoluteString
    }
    
    @Published var goToPage = false
    @Published var goForward = false
    @Published var goBack = false
    
    func refresh() {
        
    }
    
    func 
    
}
