import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomNavView {
            GeometryReader { geometry in
                ZStack {
                    GalleryView()
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            CustomNavLink(
                                destination: ScannerView()
                                    .customNavigationTitle("Scanner")
                                    .customNavigationBackButtonHidden(false)
                            )
                            .padding(.bottom, 18)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .customNavigationTitle("Gallery")
            .customNavigationMenuButtonHidden(false)
        }
    }
}

#Preview {
    ContentView()
}
