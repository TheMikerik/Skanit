import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let showMenuButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            if showMenuButton {
                menuButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton.opacity(0)
            }
            if showMenuButton {
                backButton.opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.clear.ignoresSafeArea(edges: .top)
        )
    }
}

#Preview {
    VStack {
        CustomNavBarView(
            showBackButton: false,
            showMenuButton: false,
            title: "Test",
            subtitle: "subtitle"
        )
        Spacer()
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(
            action: {
                presentationMode.wrappedValue.dismiss()
            },
            label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
        )
    }
    
    private var menuButton: some View {
        Button(
            action: {
                
            },
            label: {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.black)
            }
        )
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            if let subtitle = subtitle {
                Text(subtitle)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}
