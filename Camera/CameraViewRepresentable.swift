import SwiftUI
import UIKit

struct CameraViewRepresentable: UIViewControllerRepresentable {
    
    class Coordinator: ObservableObject {
        var parent: CameraViewRepresentable
        
        init(parent: CameraViewRepresentable) {
            self.parent = parent
        }
        
        var cameraViewController: CameraViewController?
        
        func capturePhoto() {
            cameraViewController?.capturePhoto()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraVC = CameraViewController()
        context.coordinator.cameraViewController = cameraVC
        return cameraVC
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }
}
