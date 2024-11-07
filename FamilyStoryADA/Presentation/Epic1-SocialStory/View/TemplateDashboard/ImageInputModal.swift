import PhotosUI
import SwiftUI


struct ImageInputModal: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @StateObject var viewModel = CameraViewModel()  // Shared ViewModel
    @StateObject private var keyboardHelper = KeyboardHelper()  // Keyboard Helper
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                
                VStack {
                    HStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    templateViewModel.chosenImage = nil
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
                    if let uiImage = templateViewModel.chosenImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton()
                                    .environmentObject(viewModel)
                                    .environmentObject(templateViewModel)
                            }
                    } else {
                        // Placeholder if no image is found
                        Rectangle()
                            .frame(width: 300, height: 400)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton()
                                    .environmentObject(viewModel)
                                    .environmentObject(templateViewModel)
                            }
                    }
                    
                    HStack {
                        if templateViewModel.isEditingTextField {
                            // Show TextField for editing name
                            TextField("Enter name", text: $templateViewModel.childName)
                                .background(Color("FSWhite"))
                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                            
                        } else {
                            if templateViewModel.childName.isEmpty {
                                Text("Enter name")
                                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.fsBlack))
                                    .onTapGesture {
                                        templateViewModel.isEditingTextField.toggle()
                                    }
                            } else {
                                Text(templateViewModel.childName)
                                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.fsBlack))
                                    .onTapGesture {
                                        templateViewModel.isEditingTextField.toggle()
                                    }
                            }
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
                        viewModel.savedImage = templateViewModel.chosenImage
                        templateViewModel.editNewStory(imageName: viewModel.saveImage())
                        templateViewModel.isImageInputModalPresented = false
                        templateViewModel.isPagePreviewModalPresented = false
                        templateViewModel.isTemplateClosed = true
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
                .offset(y: keyboardHelper.isKeyboardShown ? -126 : 0)
                
                // Show the cropping view when image is selected
                
            }
            .frame(width: 728,height: 743)
            .background(Color(.fsBlue1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            
            NavigationLink(
                destination: CropImageView(croppingStyle: .portrait)
                    .environmentObject(viewModel),
                isActive: $viewModel.showCropView,
                label: {
                    EmptyView()
                }
            ).onChange(of: viewModel.showCropView) { value in
                if !value, let croppedImage = viewModel.savedImage {
                    templateViewModel.chosenImage = croppedImage
                    
                }
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
}

struct ChangePictureButton: View {
    @EnvironmentObject var viewModel: CameraViewModel  // Shared ViewModel
    @EnvironmentObject var templateViewModel: TemplateViewModel  // Shared ViewModel
    
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
            NavigationLink(destination: CameraView.shared
                .environmentObject(viewModel),
                           isActive: $viewModel.navigateToCamera) {
            }
                           .onChange(of: viewModel.navigateToCamera) { value in
                               if !value, viewModel.isPhotoCaptured, let selectedImage = viewModel.savedImage {
                                   // Show crop view once an image is selected
                                   templateViewModel.chosenImage = selectedImage
                                   viewModel.savedImage = selectedImage
//                                   viewModel.showCropView = true //TODO: Fix crop view for this, for now lets say langsung foto
                                   viewModel.isPhotoCaptured = false
                                   
                               }
                           }
            
        }
        .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: {
            if viewModel.isPhotoCaptured, let selectedImage = viewModel.savedImage {
                // Show crop view once an image is selected
                viewModel.showCropView = true
                viewModel.isPhotoCaptured = false
            }
        }) {
            ImagePicker()
                .environmentObject(viewModel)
        }
        
    }
}



//
//#Preview {
//    @Previewable @State var isPresented = true  // State for preview purposes
//    ImageInputModal(isPresented: $isPresented)
//}
