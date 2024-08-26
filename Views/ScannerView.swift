import SwiftUI

struct ScannerView: View {
    @StateObject private var cameraCoordinator = CameraViewRepresentable.Coordinator(parent: CameraViewRepresentable())

    var body: some View {
        ZStack {
            CameraViewRepresentable()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(cameraCoordinator) // Pass coordinator to the representable

            VStack {
                Spacer()
                PlusIconWidget()
                Spacer()
                TakeScanWidget(action: {
                    // Trigger photo capture
                    cameraCoordinator.capturePhoto()
                }).padding(.bottom, 15)
            }
        }
    }
}

#Preview {
    ScannerView()
}
