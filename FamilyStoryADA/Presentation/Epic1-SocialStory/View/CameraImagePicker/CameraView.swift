//  ContentView.swift
//  CustomCameraApp
//
//  Created by Amisha Italiya on 03/10/23.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CameraViewModel
    @State private var isFocused = false
    @State private var isScaled = false
    @State private var focusLocation: CGPoint = .zero
    @State private var isPresented = true
    @State private var currentZoomFactor: CGFloat = 1.0
    
    private var didCrop: ((CropView.CroppedRect) -> ())?
    private var didCancel: (() -> ())?
    
    public static var shared = CameraView() // MARK: Turn off due to constant camera turning on
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            viewModel.switchFlash()
                        }, label: {
                            Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                .font(.system(size: 20, weight: .medium, design: .default))
                        })
                        .accentColor(viewModel.isFlashOn ? .yellow : .white)
                        
                        ZStack {
                            CameraPreview(session: viewModel.session, position: viewModel.cameraManager.position) { tapPoint in
                                isFocused = true
                                focusLocation = tapPoint
                                viewModel.setFocus(point: tapPoint)
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                            .gesture(MagnificationGesture()
                                .onChanged { value in
                                    self.currentZoomFactor += value - 1.0 // Calculate the zoom factor change
                                    self.currentZoomFactor = min(max(self.currentZoomFactor, 0.5), 10)
                                    self.viewModel.zoom(with: currentZoomFactor)
                                })
                            .onAppear(){
                                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                                UIViewController.attemptRotationToDeviceOrientation()
                            }
                            
                            if isFocused {
                                FocusView(position: $focusLocation)
                                    .scaleEffect(isScaled ? 0.8 : 1)
                                    .onAppear {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                            self.isScaled = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                                self.isFocused = false
                                                self.isScaled = false
                                            }
                                        }
                                    }
                            }
                        }
                        
                        VStack {
                            //                            CroppedPhotosPicker(selection: $viewModel.capturedImage, isCapturedImage: $viewModel.isPhotoCaptured, photosPickerItem: $viewModel.photosPickerItem) {
                            //                                PhotoThumbnail(selectedImage: $viewModel.capturedImage)
                            //                            }
//                            NavigationLink(destination: {
//                                ImagePicker()
//                                    .environmentObject(viewModel)
//                            }, label: {
//                                PhotoThumbnail(selectedImage: $viewModel.savedImage)
//                            })
//                            .onAppear() {
//                                viewModel.savedImage = nil
//                            }
                            Spacer()
                            CaptureButton {
                                Task {
                                    viewModel.captureImage()
                                    viewModel.isPhotoCaptured = true
                                }
                            }
                            Spacer()
                            CameraSwitchButton { viewModel.switchCamera() }
                        }
                        .padding(20)
                    }
                }
                
            }
            .alert(isPresented: $viewModel.showAlertError) {
                Alert(title: Text(viewModel.alertError.title), message: Text(viewModel.alertError.message), dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle), action: {
                    viewModel.alertError.primaryAction?()
                }))
            }
            .alert(isPresented: $viewModel.showSettingAlert) {
                Alert(title: Text("Warning"), message: Text("Application doesn't have all permissions to use camera and microphone, please change privacy settings."), dismissButton: .default(Text("Go to settings"), action: {
                    self.openSettings()
                }))
            }
            .onAppear {
                viewModel.setupBindings()
                viewModel.requestCameraPermission()
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                UIViewController.attemptRotationToDeviceOrientation()
            }
            .onChange(of: viewModel.savedImage) { value in
                guard value != nil && viewModel.isPhotoCaptured else { return }
//                if viewModel.cameraManager.position == .front {
//                    viewModel.cameraManager.position = .back
//                }
                viewModel.navigateToCamera = false
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Create a separate function for the crop view navigation
    //    func cropView() -> some View {
    //        if let selectedImage = viewModel.capturedImage {
    //            return AnyView(
    //                CropView(image: selectedImage.image, croppingStyle: .default, croppingOptions: .init()) { image in
    //                    viewModel.capturedImage = nil
    //                    viewModel.photosPickerItem = nil
    //
    //                    // Save image and get the filename
    //                    let filename = CameraDelegate.saveImageToAppStorage(image.image)
    //                    viewModel.savedImageFilename = filename
    //                    viewModel.savedImage = CameraDelegate.loadImageFromAppStorage(named: filename)
    //                    // Trigger didCrop closure (if you want to pass it elsewhere)
    //                    self.didCrop?(CropView.CroppedRect(rect: image.rect, angle: image.angle))
    //
    //                    // Save the image to gallery
    //                    CameraDelegate.saveImageToGallery(image.image)
    //
    //                    //dismiss
    //                    viewModel.isPhotoCaptured = false
    //                    dismiss()
    //                } didCropImageToRect: { _ in
    //
    //                } didFinishCancelled: { _ in
    //                    viewModel.capturedImage = nil
    //                    viewModel.photosPickerItem = nil
    //                    viewModel.isPhotoCaptured = false
    //                }
    //                .ignoresSafeArea()
    //            )
    //        } else {
    //            return AnyView(
    //                EmptyView()
    //                    .onAppear(){
    //                        dismiss()
    //                }
    //                    .environmentObject(viewModel)   //Inject view model with the saved filename
    //                )
    //        }
    //    }
    
    
    
    func openSettings() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func handleDidCrop(croppedRect: CropView.CroppedRect) {
        viewModel.isPhotoCaptured = true
        print("Photo taken from crop")
    }
}

struct PhotoThumbnail: View {
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        Group {
            if let photo = selectedImage {
                Image(uiImage: photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            } else {
                Image(systemName: "photo.fill")
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundStyle(.white)
            }
        }
    }
}

struct CaptureButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 70, height: 70, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 59, height: 59, alignment: .center)
                )
        }
    }
}

struct CameraSwitchButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        }
    }
}

struct FocusView: View {
    
    @Binding var position: CGPoint
    
    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
            .foregroundColor(.clear)
            .border(Color.yellow, width: 1.5)
            .position(x: position.x, y: position.y)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
