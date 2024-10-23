//  CameraViewModel.swift
//  CustomCameraApp
//
//  Created by Amisha Italiya on 04/10/23.
//

import SwiftUI
import Combine
import Photos
import AVFoundation
import PhotosUI

class CameraViewModel: ObservableObject {
    
    @ObservedObject var cameraManager = CameraManager()
    @Published var isFlashOn = false
    @Published var showAlertError = false
    @Published var showSettingAlert = false
    @Published var isPermissionGranted: Bool = false
    @Published var isImagePickerOpened: Bool = false
    @Published var isPhotoCaptured: Bool = false
    @Published var savedImage: UIImage?
    @Published var photosPickerItem: PhotosPickerItem?
    
    @Published var navigateToCamera = false  // For taking a photo
    @Published var showingImagePicker = false  // To show image picker sheet
    @Published var showCropView = false  // Manage crop view state
    
    var alertError: AlertRequest!
    var session: AVCaptureSession = .init()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        session = cameraManager.session
    }
    
    deinit {
        cameraManager.stopCapturing()
    }
    
    func setupBindings() {
        cameraManager.$shouldShowAlertView.sink { [weak self] value in
            self?.alertError = self?.cameraManager.alertError
            self?.showAlertError = value
        }
        .store(in: &cancelables)
        
        cameraManager.$capturedImage.sink { [weak self] image in
            if let existImage = image {
                self?.savedImage = existImage
            }
        }.store(in: &cancelables)
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isGranted in
            guard let self else { return }
            if isGranted {
                self.configureCamera()
                DispatchQueue.main.async {
                    self.isPermissionGranted = true
                }
            }
        }
    }
    
    func configureCamera() {
        checkForDevicePermission()
        cameraManager.configureCaptureSession()
    }
    
    func checkForDevicePermission() {
        let videoStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        DispatchQueue.main.async { [weak self] in
            if videoStatus == .authorized {
                self?.isPermissionGranted = true
            } else if videoStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
            } else if videoStatus == .denied {
                self?.isPermissionGranted = false
                self?.showSettingAlert = true
            }
        }
    }
    
    func switchCamera() {
        cameraManager.position = cameraManager.position == .back ? .front : .back
        cameraManager.switchCamera()
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        cameraManager.toggleTorch(tourchIsOn: isFlashOn)
    }
    
    func zoom(with factor: CGFloat) {
        cameraManager.setZoomScale(factor: factor)
    }
    
    func setFocus(point: CGPoint) {
        cameraManager.setFocusOnTap(devicePoint: point)
    }
    
    func captureImage() {
        self.savedImage = nil
        requestGalleryPermission()
        let permission = checkGalleryPermissionStatus()
        if permission.rawValue != 2 {
            cameraManager.captureImage() { status in
                self.isPhotoCaptured = status
            }
        }
    }
    
    func requestGalleryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                break
            case .denied:
                self.showSettingAlert = true
            default:
                break
            }
        }
    }
    
    func checkGalleryPermissionStatus() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    public func saveImage() -> String? {
        if let image = self.savedImage {
            let filename = CameraDelegate.saveImageToAppStorage(image)
            // Save the image to the gallery
            CameraDelegate.saveImageToGallery(image)
            return filename
        } else {
            return nil
        }
    }
}
