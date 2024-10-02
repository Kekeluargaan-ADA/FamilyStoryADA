//
//  CameraManager.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 02/10/24.
//

import SwiftUI
import Foundation
import AVFoundation

enum CameraStatus {
    case configured
    case unconfigured
    case unauthorized
    case failed
}

class CameraManager: ObservableObject {
    @Published var status = CameraStatus.unconfigured
    
    // camera settings
    let session = AVCaptureSession()
    // photo capture
    let photoOutput = AVCapturePhotoOutput()
    // camera video input handler
    var videoDeviceInput: AVCaptureDeviceInput?
    
    private let sessionQueue = DispatchQueue(label: Project.bundleIdentifier + ".camera.sessionQueue")
    
    // Configure camera capture session
    func configureCaptureSession () {
        sessionQueue.async { [weak self] in
            guard let self, self.status == .unconfigured else { return }
            
            self.session.beginConfiguration()
            self.session.sessionPreset = .photo
            self.setVideoInput()
            self.setPhotoOutput()
            self.session.commitConfiguration()
            
            self.startCapture()
            
        }
    }
    
    // Setup video input from camera
    private func setVideoInput() {
        do{
            //TODO: Check position
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            guard let camera else {
                print ("Camera: No camera found")
                status = .unconfigured
                session.commitConfiguration()
                return
            }
            
            let videoInput = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(videoInput) {
                print("Camera: Added video input to session")
                session.addInput(videoInput)
                videoDeviceInput = videoInput
                status = .configured
            } else {
                print("Camera: Couldn't add video input to session")
                status = .unconfigured
                session.commitConfiguration()
                return
            }
        } catch {
            print("Camera: Error setting video input: \(error)")
            status = .failed
            session.commitConfiguration()
            return
        }
    }
    
    // Configure photo output
    private func setPhotoOutput() {
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            photoOutput.maxPhotoDimensions = .init(width: 1080, height: 1920) // TODO: Adjust dimension
            status = .configured
        } else {
            print("Camera: Couldn't add photo output to session")
            status = .failed
            session.commitConfiguration()
            return
        }
        
    }
    
    private func startCapture() {
        if status == .configured {
            self.session.startRunning()
        } else if status == .unconfigured || status == .unauthorized {
            DispatchQueue.main.async {
                // TODO: Handle error capture
                print("Camera: Couldn't start capture")
            }
        }
    }
    
    private func stopCapture() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
}
