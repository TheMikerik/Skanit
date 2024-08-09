import SwiftUI

struct FloatingActionButton: View {
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                ARView()
            }).navigationBarHidden(true),
            label:  {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.bottom, 16)
    }
}

#Preview {
    FloatingActionButton()
}
