import UIKit
import AVFoundation
import os.log

class CameraViewController: UIViewController {

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.skanit", category: "CameraViewController")

    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front) else {
            logger.error("TrueDepth camera is not available on this device")
            fatalError("TrueDepth camera is not available on this device")
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            } else {
                logger.error("Unable to add camera input to capture session.")
                fatalError("Unable to add camera input")
            }
        } catch {
            logger.error("Error setting up camera input: \(error.localizedDescription)")
            fatalError("Error setting up camera input: \(error)")
        }

        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
        } else {
            logger.error("Unable to add photo output to capture session.")
            fatalError("Unable to add photo output")
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        logger.info("Camera setup completed successfully.")
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
            self.logger.info("Capture session started.")
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.capturePhoto()
        }
    }

    func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
        logger.info("Photo capture initiated.")
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            logger.error("Error capturing photo: \(error.localizedDescription)")
            return
        }

        guard let photoData = photo.fileDataRepresentation() else {
            logger.error("Error getting photo data from capture.")
            return
        }

        if let depthData = photo.depthData {
            let depthMap = depthData.depthDataMap
            logger.info("Depth data captured successfully.")
        }

        if let image = UIImage(data: photoData) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            logger.info("Photo saved to photo library.")
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            logger.error("Error saving photo to library: \(error.localizedDescription)")
        } else {
            logger.info("Photo saved successfully to library.")
        }
    }
}
