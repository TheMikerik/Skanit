import SwiftUI

struct CustomNavLink<Destination: View>: View {
    
    let destination: Destination
    
    init(destination: Destination) {
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(
            destination:
                CustomNavBarContainerView(content: {
                    destination
                }).navigationBarHidden(true)
        ) {
            Image(systemName: "plus")
                .font(.system(size: 24))
                .frame(width: 80, height: 80)
                .background(Color(.systemGray6))
                .foregroundColor(.black)
                .clipShape(Circle())
                .shadow(radius: 6)
        }
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(
            destination: Text("Desti")
        )
    }
}
