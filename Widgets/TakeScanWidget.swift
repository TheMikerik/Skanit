import SwiftUI

struct TakeScanWidget: View {
    var buttonSize: CGFloat = 70
    var borderWidth: CGFloat = 10
    var borderColor: Color = .red
    var shadowColor: Color = .black
    var shadowRadius: CGFloat = 10

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .stroke(borderColor, lineWidth: borderWidth)
                .frame(width: buttonSize, height: buttonSize)
                .background(
                    Circle().fill(Color.clear)
                )
        }
    }
}

#Preview {
    TakeScanWidget(action: {})
}
