import PhotosUI
import SwiftUI


struct ImageInputModal: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CameraViewModel()  // Shared ViewModel
    @Binding var isPresented: Bool
    @State private var isEditing: Bool = false
    @State private var name: String = "Hendra"
    @State private var showCropView = false  // Manage crop view state
    @State private var selectedImage: UIImage?  // Manage selected image
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                VStack {
                    HStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    isPresented.toggle()
                                    //                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .blue) // Use fixed height for button
                                }
                                Spacer()
                            }
                            Text("Cara Menyikat Gigi")
                                .font(
                                    Font.custom("Fredoka", size: 32)
                                        .weight(.semibold)
                                )
                                .foregroundColor(Color("FSBlack"))
                        }
                        .padding()
                    }
                    Text("Foto ini akan digunakan pada bagian intro dan closing dari story ini.")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(.fsBlack))
                        .frame(width: 381,height: 50, alignment: .center)
                    // Display saved image if exists, otherwise show placeholder
                    if let uiImage = viewModel.savedImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton(showCropView: $showCropView, selectedImage: $selectedImage, viewModel: viewModel)
                            }
                    } else {
                        // Placeholder if no image is found
                        Rectangle()
                            .frame(width: 300, height: 400)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton(showCropView: $showCropView, selectedImage: $selectedImage, viewModel: viewModel)
                            }
                    }
                    
                    HStack {
                        if isEditing {
                            // Show TextField for editing name
                            TextField("Enter name", text: $name)
                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                            
                        } else {
                            Text(name)
                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                        }
                        
                        Button(action: {
                            isEditing.toggle()  // Toggle editing state
                        }) {
                            Image(systemName: "pencil")
                                .frame(width: 22,height: 22)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        // Action for the "Next" button
                    }) {
                        Text("Lanjut")
                            .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.fsWhite))
                            .frame(width: 160,height: 60)
                            .background(Color(.fsBlue9))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding()
                    .frame(width: 728, alignment: .trailing)
                    
                }
                .frame(width: 728,height: 743)
                .background(Color(.fsBlue1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
            .navigationViewStyle(.stack)
            .environmentObject(viewModel)
        }
    }
}

struct ChangePictureButton: View {
    @Binding var showCropView: Bool
    @Binding var selectedImage: UIImage?
    @ObservedObject var viewModel: CameraViewModel  // Shared ViewModel
    
    @State private var navigateToCamera = false  // For taking a photo
    @State private var showingImagePicker = false  // To show image picker sheet
    
    var body: some View {
        VStack {
            Menu {
                Button(action: {
                    showingImagePicker = true
                }) {
                    Label("Choose Photo", systemImage: "photo")
                }
                
                Button(action: {
                    navigateToCamera = true
                }) {
                    Label("Take Photo", systemImage: "camera")
                }
            } label: {
                Text("Ubah foto")
                    .font(Font.custom("Fredoka", size: 16, relativeTo: .callout))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(.fsBlack))
                    .frame(width: 140,height: 40)
                    .padding()
                    .background(Color(.fsSecondaryBlue4))  // Custom background color
                    .cornerRadius(40)
            }
            .padding(.bottom, 20)
            
            // NavigationLink for CameraView
            NavigationLink(destination: CameraView(), isActive: $navigateToCamera) {
                EmptyView()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: {
            if let selectedImage = selectedImage {
                // Show crop view once an image is selected
                showCropView = true
            }
        }) {
            ImagePicker(selectedImage: $selectedImage)
        }
        
        // Show the cropping view when image is selected
        NavigationLink(
            destination: CropImageView(selectedImage: $selectedImage, showCropView: $showCropView, viewModel: viewModel),
            isActive: $showCropView,
            label: {
                EmptyView()
            }
        )
    }
}




#Preview {
    @Previewable @State var isPresented = true  // State for preview purposes
    ImageInputModal(isPresented: $isPresented)
}
