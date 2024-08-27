import SwiftUI

struct PlusIconWidget: View {
    var size: CGFloat = 65

    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(.red)
    }
}

#Preview {
    PlusIconWidget()
}
