import UIKit
import AVFoundation
import Metal
import os.log

class CameraViewController: UIViewController {

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.skanit", category: "CameraViewController")

    private var captureSession: AVCaptureSession!
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], autoreleaseFrequency: .workItem)

    private var videoDataOutput: AVCaptureVideoDataOutput!
    private var depthDataOutput: AVCaptureDepthDataOutput!
    private var outputSynchronizer: AVCaptureDataOutputSynchronizer?

    private var textureCache: CVMetalTextureCache?

    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CVMetalTextureCacheCreate(nil, nil, MTLCreateSystemDefaultDevice()!, nil, &textureCache)

        setupCaptureSession()
    }

    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        
        sessionQueue.async {
            self.configureSession()
        }
    }

    private func configureSession() {
        guard let videoDevice = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front) else {
            logger.error("TrueDepth camera is not available on this device")
            return
        }

        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            captureSession.beginConfiguration()
            
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
            } else {
                logger.error("Could not add video device input to the session")
                captureSession.commitConfiguration()
                return
            }

            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            
            if captureSession.canAddOutput(videoDataOutput) {
                captureSession.addOutput(videoDataOutput)
            } else {
                logger.error("Could not add video data output to the session")
                captureSession.commitConfiguration()
                return
            }

            depthDataOutput = AVCaptureDepthDataOutput()
            depthDataOutput.isFilteringEnabled = false

            if captureSession.canAddOutput(depthDataOutput) {
                captureSession.addOutput(depthDataOutput)
            } else {
                logger.error("Could not add depth data output to the session")
                captureSession.commitConfiguration()
                return
            }

            if let connection = depthDataOutput.connection(with: .depthData) {
                connection.isEnabled = true
            } else {
                logger.error("No AVCaptureConnection")
                captureSession.commitConfiguration()
                return
            }

            outputSynchronizer = AVCaptureDataOutputSynchronizer(dataOutputs: [videoDataOutput, depthDataOutput])
            outputSynchronizer!.setDelegate(self, queue: sessionQueue)

            let depthFormats = videoDevice.activeFormat.supportedDepthDataFormats
            let filtered = depthFormats.filter {
                CMFormatDescriptionGetMediaSubType($0.formatDescription) == kCVPixelFormatType_DepthFloat16
            }
            
            let selectedFormat = filtered.max(by: {
                CMVideoFormatDescriptionGetDimensions($0.formatDescription).width < CMVideoFormatDescriptionGetDimensions($1.formatDescription).width
            })

            try videoDevice.lockForConfiguration()
            videoDevice.activeDepthDataFormat = selectedFormat
            videoDevice.unlockForConfiguration()
            
            captureSession.commitConfiguration()
            
            self.captureSession.startRunning()
            self.logger.info("Capture session started.")
            
            DispatchQueue.main.async {
                self.setupPreviewLayer()
            }
            
        } catch {
            logger.error("Error setting up capture session: \(error.localizedDescription)")
            captureSession.commitConfiguration()
            return
        }
    }

    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        logger.info("Preview layer setup completed successfully.")
    }

    private func visualizeDepthData(_ depthData: AVDepthData) {
        let depthMap = depthData.depthDataMap
        
        var ciImage = CIImage(cvPixelBuffer: depthMap)
        
        let rotationTransform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
        ciImage = ciImage.transformed(by: rotationTransform)
        
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: kCIInputSaturationKey)
        
        if let outputImage = filter?.outputImage {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                DispatchQueue.main.async {
                    let imageView = UIImageView(frame: self.view.bounds)
                    imageView.image = UIImage(cgImage: cgImage)
                    self.view.addSubview(imageView)
                }
            }
        } else {
            logger.error("Failed to create grayscale image from depth data")
        }
    }

}

extension CameraViewController: AVCaptureDataOutputSynchronizerDelegate {
    func dataOutputSynchronizer(_ synchronizer: AVCaptureDataOutputSynchronizer, didOutput synchronizedDataCollection: AVCaptureSynchronizedDataCollection) {
        if let syncedDepthData = synchronizedDataCollection.synchronizedData(for: depthDataOutput) as? AVCaptureSynchronizedDepthData {
            let depthData = syncedDepthData.depthData
            visualizeDepthData(depthData)
        }
    }
}
