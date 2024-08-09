import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = false
    @State private var showMenuButton: Bool = false
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(
                showBackButton: showBackButton,
                showMenuButton: showMenuButton,
                title: title,
                subtitle: subtitle
            )
            content
                .frame(
                    maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                    maxHeight: .infinity
                )
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: {
            value in self.title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: {
            value in self.subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonPreferenceKey.self, perform: {
            value in self.showBackButton = value
        })
        .onPreferenceChange(CustomNavBarMenuButtonPreferenceKey.self, perform: {
            value in self.showMenuButton = value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.green.ignoresSafeArea()
            
            Text("Hello")
                .foregroundColor(.white)
                .customNavigationTitle("New title")
                .customNavigationSubtitle("idk subtitle")
        }
    }
}
