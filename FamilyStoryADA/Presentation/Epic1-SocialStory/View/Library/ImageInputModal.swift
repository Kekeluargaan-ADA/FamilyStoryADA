//
//  Page.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//


import SwiftUI

struct ImageInputModal: View {
    @StateObject var viewModel = CameraViewModel()
    @Binding var isPresented: Bool
    @State private var isEditing: Bool = false
    @State private var name: String = "Hendra"
    
    var body: some View {
        NavigationView {
            VStack {
                PreviewModalHeader(isPresented: isPresented)
                
                Text("Foto ini akan digunakan pada bagian intro dan closing dari story ini.")
                
                // Display saved image if path exists, otherwise show placeholder
                if let imagePath = viewModel.savedImageFilename,
                   let uiImage = loadImageFromAppStorage(named: imagePath) {
                    // Display the image
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                        .overlay(alignment: .bottom) {
                            ChangePictureButton()
                        }
                } else {
                    // Placeholder if no image is found
                    Rectangle()
                        .frame(width: 300, height: 400)
                        .foregroundColor(.gray)
                        .overlay(alignment: .bottom) {
                            ChangePictureButton()
                        }
                }
                
                HStack {
                    if isEditing {
                        // Show TextField for editing name
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    } else {
                        Text(name)
                    }
                    
                    Button(action: {
                        isEditing.toggle()  // Toggle editing state
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                Button(action: {
                    // Your action for the next button
                }) {
                    Text("Lanjut")
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color(.fsBlue9))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(width: 360, alignment: .trailing)
            }
            .background(Color(.fsBlue1))
            .padding()
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
    
    // Function to load the image from app storage
    func loadImageFromAppStorage(named imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        
        // Get the path to the app's Documents directory
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // Append the image name to the directory path
        let imagePath = documentDirectory.appendingPathComponent(imageName)
        
        // Check if the image file exists at the path
        if fileManager.fileExists(atPath: imagePath.path) {
            return UIImage(contentsOfFile: imagePath.path)
        } else {
            print("Image not found at path: \(imagePath.path)")
            return nil
        }
    }
}


#Preview {
    @Previewable @State var isPresented = true  // State for preview purposes
    ImageInputModal(isPresented: $isPresented)
}


struct ChangePictureButton: View {
    @State private var navigateToCamera = false  // For taking a photo
    @State private var navigateToPhotoPicker = false  // For choosing a photo
    @State private var isTapped = false
    var body: some View {
        Menu {
                    Button(action: {
                        // Trigger navigation to PhotoPickerView when "Choose Photo" is tapped
                        navigateToPhotoPicker = true
                    }) {
                        Label("Choose Photo", systemImage: "photo")
                    }
                    Button(action: {
                        // Trigger navigation to CameraView when "Take Photo" is tapped
                        navigateToCamera = true
                    }) {
                        Label("Take Photo", systemImage: "camera")
                    }
                } label: {
                    Text("Ubah foto")
                        .foregroundColor(.black)
                        .padding()
                        .background(isTapped ? Color(.fsYellow) : Color(.fsSecondaryBlue4))  // Change background color when tapped
                        .cornerRadius(10)
                        .onTapGesture {
                            isTapped = true  // Change color to indicate tap
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isTapped = false  // Reset color after a short delay
                            }
                        }
                }
                .padding(.bottom, 20)
                
                // NavigationLink for CameraView
                NavigationLink(destination: CameraView()
                    .onDisappear {
                        // Reset the state when navigating back
                        navigateToCamera = false
                    }, isActive: $navigateToCamera) {
                        EmptyView()
                    }

                // NavigationLink for PhotoPickerView
                NavigationLink(destination: PhotoPickerViews()
                    .onDisappear {
                        // Reset the state when navigating back
                        navigateToPhotoPicker = false
                    }, isActive: $navigateToPhotoPicker) {
                        EmptyView()
                    }
            }
}

struct PhotoPickerViews: View {
    var body: some View {
        Text("Photo Picker View")
    }
}
