import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = WebViewViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBarView(searchText: $viewModel.address) {
                    viewModel.send(action: .goToPage)
                }
                .padding(.top, 8)
            
                if viewModel.shouldShowProgressBar {
                    ProgressView(value: viewModel.progress)
                        .padding(.horizontal, 8)
                        .foregroundColor(.accentColor)
                }
               
                Divider()
                WebView(viewModel: viewModel)
            }
            .navigationBarHidden(true)
            .toolbar {
                BottomToolbar(
                    backwardAction: { viewModel.send(action: .backward) },
                    forwardAction: { viewModel.send(action: .forward) },
                    reloadAction: { viewModel.send(action: .reload) }
                )
            }
        }
        .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title: Text("Error!"),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("Ok"), action: {
                    viewModel.error = nil
                })
            )
        }
        .onAppear {
            searchText = viewModel.address
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
