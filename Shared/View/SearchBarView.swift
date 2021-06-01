import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    @State private var isEditing = false
    @State private var plainText = ""
    
    private let searchTextPlaceholder = "Search or enter website name"
        
    var body: some View {
        HStack {
            TextField(searchTextPlaceholder, text: $searchText, onCommit: commitAction)
            .padding(6)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    if isEditing {
                        clearButtonAction
                    }
                }
            )
            .padding(.horizontal, 8)
            .onTapGesture(perform: onTapTextFieldAction)
            
            if isEditing {
                cancelButtonAction
            }
        }
    }
    
}

// MARK: Views
extension SearchBarView {
    
    var clearButtonAction: some View {
        Button(action: {
            plainText = searchText
            searchText = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
    }
    
    var cancelButtonAction: some View {
        Button(action: {
            withAnimation {
                self.isEditing = false
            }

            searchText = plainText
            self.endTextEditing()
        }) {
            Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
        .animation(.default)
    }
    
}

// MARK: Methods
extension SearchBarView {
    
    private func commitAction() {
        self.endTextEditing()
        withAnimation {
            self.isEditing = false
        }
        onSearch()
    }
    
    private func onTapTextFieldAction() {
        withAnimation {
            self.isEditing = true
        }
    }
    
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), onSearch: {})
    }
}

