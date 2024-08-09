import SwiftUI

struct PlusIconWidget: View {
    var size: CGFloat = 80

    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(.gray)
    }
}

#Preview {
    PlusIconWidget()
}
