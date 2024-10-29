import PhotosUI
import SwiftUI


struct ImageInputModal: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @StateObject var viewModel = CameraViewModel()  // Shared ViewModel
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                VStack {
                    HStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    templateViewModel.isImageInputModalPresented.toggle()
                                    //                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .blue) // Use fixed height for button
                                }
                                Spacer()
                            }
                            Text(templateViewModel.selectedTemplate?.templateName ?? "")
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
                                ChangePictureButton()
                            }
                    } else {
                        // Placeholder if no image is found
                        Rectangle()
                            .frame(width: 300, height: 400)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton()
                            }
                    }
                    
                    HStack {
                        if templateViewModel.isEditingTextField {
                            // Show TextField for editing name
                            TextField("Enter name", text: $templateViewModel.childName)
                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                            
                        } else {
                            Text(templateViewModel.childName)
                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                        }
                        
                        Button(action: {
                            templateViewModel.isEditingTextField.toggle()  // Toggle editing state
                        }) {
                            Image(systemName: "pencil")
                                .frame(width: 22,height: 22)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        templateViewModel.editNewStory(imageName: viewModel.saveImage())
                        templateViewModel.isImageInputModalPresented = false
                        templateViewModel.isPagePreviewModalPresented = false
                        dismiss()
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
    @EnvironmentObject var viewModel: CameraViewModel  // Shared ViewModel
    
    var body: some View {
        VStack {
            Menu {
                Button(action: {
                    viewModel.isPhotoCaptured = false
                    viewModel.showingImagePicker = true
                }) {
                    Label("Choose Photo", systemImage: "photo")
                }
                
                Button(action: {
                    viewModel.isPhotoCaptured = false
                    viewModel.navigateToCamera = true
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
            NavigationLink(destination: CameraView.shared.environmentObject(viewModel), isActive: $viewModel.navigateToCamera) {
            }
            .onChange(of: viewModel.navigateToCamera) { value in
                if !value, viewModel.isPhotoCaptured, viewModel.savedImage != nil {
                    // Show crop view once an image is selected
                    viewModel.showCropView = true
                }
            }
        }
        .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: {
            if viewModel.isPhotoCaptured, let selectedImage = viewModel.savedImage {
                // Show crop view once an image is selected
                viewModel.showCropView = true
            }
        }) {
            ImagePicker()
                .environmentObject(viewModel)
        }
        
        // Show the cropping view when image is selected
        NavigationLink(
            destination: CropImageView(croppingStyle: .portrait)
                .environmentObject(viewModel),
            isActive: $viewModel.showCropView,
            label: {
                EmptyView()
            }
        )
    }
}



//
//#Preview {
//    @Previewable @State var isPresented = true  // State for preview purposes
//    ImageInputModal(isPresented: $isPresented)
//}
