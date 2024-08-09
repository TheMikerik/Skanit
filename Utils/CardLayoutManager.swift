import SwiftUI

struct CarLayoutManager: View {
    let screenWidth = UIScreen.main.bounds.width
    let padding: CGFloat = 16
    let cardRatio: CGFloat = 9 / 16
    let largeCardRatio: CGFloat = 0.65
    let smallCardRatio: CGFloat = 0.35
    
    var body: some View {
        VStack(spacing: 20) {
            // Full-width card
            ScanCardWidget(
                width: screenWidth - 2 * padding,
                height: (screenWidth - 2 * padding) * cardRatio,
                isFavourite: false
            )
            
            // First row: 65% and 35% cards
            HStack(spacing: 16) {
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * largeCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * smallCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
            }
            
            // Second row: 35% and 65% cards
            HStack(spacing: 16) {
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * smallCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * largeCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
            }
            
            // Third row: three equally spaced cards
            HStack(spacing: 16) {
                ForEach(0..<3) { _ in
                    ScanCardWidget(
                        width: (screenWidth - 4 * padding) / 3,
                        height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                        isFavourite: false
                    )
                }
            }
            
            // Full-width card
            ScanCardWidget(
                width: screenWidth - 2 * padding,
                height: (screenWidth - 2 * padding) * cardRatio,
                isFavourite: false
            )
            
            // Fourth row: 65% and 35% cards
            HStack(spacing: 16) {
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * largeCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * smallCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
            }
            
            // Fifth row: 35% and 65% cards
            HStack(spacing: 16) {
                ScanCardWidget(
                    width: (screenWidth - 3 * padding) * smallCardRatio,
                    height: ((screenWidth - 3 * padding) * largeCardRatio) * cardRatio,
                    isFavourite: false
                )
                Spacer()
            }
        }
        .padding(.horizontal, padding)
    }
}
