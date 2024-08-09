import SwiftUI

struct GalleryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Section(header: Text("Favourite")
                            .font(.headline)
                            .padding(.leading)
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach(0..<5) { index in
                                ScanCardWidget(
                                    width: UIScreen.main.bounds.width - 169,
                                    height: ((UIScreen.main.bounds.width - 169) * 9) / 16,
                                    isFavourite: true
                                )
                                .padding(.bottom, 20)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
            
                Section(header: Text("All Scans")
                            .font(.headline)
                            .padding(.leading)
                ) {
                    CarLayoutManager()
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    GalleryView()
}
