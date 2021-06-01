import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let webView = WKWebView()
    @ObservedObject var viewModel: WebViewViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        
        if let url = viewModel.url {
            webView.load(URLRequest(url: url))
        } 
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = viewModel.url else { return }
        
        switch viewModel.action {
        case .backward:
            viewModel.action = nil
            if uiView.canGoBack {
                uiView.goBack()
            }
        case .forward:
            viewModel.action = nil
            if uiView.canGoForward {
                uiView.goForward()
            }
        case .reload:
            viewModel.action = nil
            uiView.reload()
        case .goToPage:
            viewModel.action = nil
            uiView.load(URLRequest(url: url))
        default:
            break
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        private let parent: WebView
        private var viewModel: WebViewViewModel
        private var estimatedProgressObserver: NSKeyValueObservation?

        init(_ parent: WebView, viewModel: WebViewViewModel) {
            self.parent = parent
            self.viewModel = viewModel
            super.init()
            
            estimatedProgressObserver = parent.webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
                guard let self = self else { return }
                self.viewModel.progress = Float(webView.estimatedProgress)
            }
        }

        deinit {
            estimatedProgressObserver = nil
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            viewModel.address = webView.url?.absoluteString ?? ""
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            viewModel.error = .default(description: error.localizedDescription)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.error = .default(description: error.localizedDescription)
        }
        
    }
    
}
