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
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            viewModel.switchFlash()
                        }, label: {
                            Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                .font(.system(size: 20 * heightRatio, weight: .medium, design: .default))
                        })
                        .padding(.leading, 20 * widthRatio)
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
                            
                            if isFocused {
                                FocusView(position: $focusLocation, heightRatio: heightRatio, widthRatio: widthRatio)
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
                            Spacer()
                            CaptureButton(heightRatio: heightRatio, widthRatio: widthRatio) {
                                Task {
                                    viewModel.captureImage()
                                    viewModel.isPhotoCaptured = true
                                }
                            }
                            Spacer()
                            CameraSwitchButton(heightRatio: heightRatio, widthRatio: widthRatio) {
                                viewModel.switchCamera()
                            }
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
            }
            .onChange(of: viewModel.savedImage) { _, value in
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
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    
    var body: some View {
        Group {
            if let photo = selectedImage {
                Image(uiImage: photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60 * widthRatio, height: 60 * heightRatio)
                    .clipShape(RoundedRectangle(cornerRadius: 10 * heightRatio, style: .continuous))
                
            } else {
                Image(systemName: "photo.fill")
                    .frame(width: 50 * widthRatio, height: 50 * heightRatio, alignment: .center)
                    .foregroundStyle(.white)
            }
        }
    }
}

struct CaptureButton: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 70 * widthRatio, height: 70 * heightRatio, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 59 * widthRatio, height: 59 * heightRatio, alignment: .center)
                )
        }
    }
}

struct CameraSwitchButton: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45 * widthRatio, height: 45 * heightRatio, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        }
    }
}

struct FocusView: View {
    @Binding var position: CGPoint
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    
    var body: some View {
        Circle()
            .frame(width: 70 * widthRatio, height: 70 * heightRatio)
            .foregroundColor(.clear)
            .border(Color.yellow, width: 1.5 * widthRatio)
            .position(x: position.x, y: position.y)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
