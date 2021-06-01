import SwiftUI

struct BottomToolbar: ToolbarContent {
    var backwardAction: () -> Void
    var forwardAction: () -> Void
    var reloadAction: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button(action: { backwardAction() }, label: {
                Image(systemName: "arrow.backward")
            })
         
            Spacer()
            Button(action: { reloadAction() }, label: {
                Image(systemName: "arrow.clockwise")
            })
            
            Spacer()
            Button(action: { forwardAction() }, label: {
                Image(systemName: "arrow.forward")
            })
            
        }
    }
    
}
