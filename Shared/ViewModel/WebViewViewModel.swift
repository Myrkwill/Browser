import Foundation

class WebViewViewModel: ObservableObject {
    
    enum Action {
        case goToPage
        case backward
        case forward
        case reload
    }
    
    enum SearchMachine: String {
        case duckduckgo = "https://duckduckgo.com"
        case google = "https://google.com"
    }
    
    @Published var address = SearchMachine.duckduckgo.rawValue
    @Published var progress: Float = 0.0
    @Published var action: Action?
    @Published var error: BrowserError?
    @Published var searchMachine: SearchMachine = .duckduckgo
    
    var url: URL? {
        if address.isEmpty, let url = URL(string: searchMachine.rawValue) {
            return url
        } else if let url = URL(string: address), url.host != nil {
            return url
        } else if let url = URL(string: searchMachine.rawValue + "?/q" + address) {
            return url
        } else {
            return nil
        }
    }
    
    var shouldShowProgressBar: Bool {
        progress >= 0.0 && progress < 1.0
    }
    
    func send(action: Action) {
        self.action = action
    }
    
}
