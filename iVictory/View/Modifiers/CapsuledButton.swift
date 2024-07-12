
import SwiftUI

struct CapsuledButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .bold()
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(.capsule)
            .shadow(color: .white, radius: 10)
    }
}
