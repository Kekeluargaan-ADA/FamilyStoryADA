//
//  Page.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import PhotosUI
import SwiftUI

struct ImageInputModal: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CameraViewModel()  // Shared ViewModel
    @Binding var isPresented: Bool
    @State private var isEditing: Bool = false
    @State private var name: String = "Hendra"
    @State private var showCropView = false  // Manage crop view state
    @State private var selectedImage: UIImage?  // Manage selected image

    var body: some View {
        NavigationView {
            VStack {
                PreviewModalHeader(isPresented: isPresented)

                Text("Foto ini akan digunakan pada bagian intro dan closing dari story ini.")

                // Display saved image if path exists, otherwise show placeholder
                if let uiImage = viewModel.savedImage {
                    // Display the image
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                        .overlay(alignment: .bottom) {
                            ChangePictureButton(showCropView: $showCropView, selectedImage: $selectedImage, viewModel: viewModel)
                        }
                } else {
                    // Placeholder if no image is found
                    Rectangle()
                        .frame(width: 300, height: 400)
                        .foregroundColor(.gray)
                        .overlay(alignment: .bottom) {
                            ChangePictureButton(showCropView: $showCropView, selectedImage: $selectedImage, viewModel: viewModel)
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
}



#Preview {
    @Previewable @State var isPresented = true  // State for preview purposes
    ImageInputModal(isPresented: $isPresented)
}


struct ChangePictureButton: View {
    @Binding var showCropView: Bool
    @Binding var selectedImage: UIImage?
    @ObservedObject var viewModel: CameraViewModel  // Use ObservedObject to bind the shared viewModel

    @State private var navigateToCamera = false  // For taking a photo
    @State private var showingImagePicker = false  // To show image picker sheet

    var body: some View {
        VStack {
            Menu {
                // Button to show the image picker sheet
                Button(action: {
                    showingImagePicker = true
                }) {
                    Label("Choose Photo", systemImage: "photo")
                }

                // Button to trigger navigation to CameraView
                Button(action: {
                    navigateToCamera = true
                }) {
                    Label("Take Photo", systemImage: "camera")
                }
            } label: {
                Text("Ubah foto")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(.fsSecondaryBlue4))  // Custom background color
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            // NavigationLink for CameraView
            NavigationLink(destination: CameraView(), isActive: $navigateToCamera) {
                EmptyView()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: {
            if selectedImage != nil {
                // Show crop view once an image is selected
                showCropView = true
            }
        }) {
            ImagePicker(selectedImage: $selectedImage)
        }
        NavigationLink(
            destination: cropView(),
            isActive: $showCropView,
            label: {
                EmptyView()
            }
        )
    }

    // Function to load and present CropView after image selection
    @ViewBuilder
    private func cropView() -> some View {
        if let selectedImage = selectedImage {
            CropView(image: selectedImage, croppingStyle: .default, croppingOptions: .init()) { image in
                // Handle cropped image here
                viewModel.capturedImage = nil
                viewModel.photosPickerItem = nil

                // Save image and get the filename
                let filename = CameraDelegate.saveImageToAppStorage(image.image)
                viewModel.savedImageFilename = filename
                viewModel.savedImage = CameraDelegate.loadImageFromAppStorage(named: filename)
                // Save the image to gallery
                print("INI FILE NAME :\(filename)")
                CameraDelegate.saveImageToGallery(image.image)

                // Dismiss crop view after saving
                showCropView = false
            } didCropImageToRect: { _ in
                // Handle additional crop rect logic if needed
            } didFinishCancelled: { _ in
                // Handle cancel action
                viewModel.capturedImage = nil
                viewModel.photosPickerItem = nil
                showCropView = false
            }
            .ignoresSafeArea()
        } else {
            EmptyView()
        }
    }
}



