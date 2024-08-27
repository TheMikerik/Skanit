import SwiftUI

struct ScannerView: View {
    var body: some View {
        ZStack {
            CameraViewRepresentable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                PlusIconWidget()
                Spacer()
                TakeScanWidget()
                    .padding(.bottom, 15)
            }
        }
    }
}

#Preview {
    ScannerView()
}
