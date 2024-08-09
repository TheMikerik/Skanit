import SwiftUI

struct ScanCardWidget: View {
    let width: CGFloat
    let height: CGFloat
    var isFavourite: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: isFavourite ? "star.fill" : "star")
                    .foregroundColor(isFavourite ? .yellow : .gray)
            }
            .padding([.leading, .top, .trailing], 16)
            Spacer()
        }
        .frame(width: width, height: height)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5, x: 4, y: 4)
    }
}


#Preview {
    ScanCardWidget(width: 200, height: 100, isFavourite: true)
}
