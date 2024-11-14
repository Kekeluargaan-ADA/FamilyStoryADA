import PhotosUI
import SwiftUI

struct ImageInputModal: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @FocusState private var isTextFieldFocused: Bool
    @StateObject private var keyboardHelper = KeyboardHelper()
    @StateObject var viewModel = CameraViewModel()  // Shared ViewModel
    @StateObject var storyViewModel = StoryViewModel()
    @State var editedText = ""
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                
                VStack {
                    HStack {
                        ZStack {
                            if templateViewModel.isEditingStoryName {
                                // Editable TextField with auto-save on every keystroke
                                TextField("\(templateViewModel.selectedTemplate!.templateName)", text: $editedText)
                                    .font(Font.custom("Fredoka", size: 32).weight(.semibold))
                                    .foregroundColor(Color("FSBlack"))
                                    .multilineTextAlignment(.center)
                                    .onChange(of: editedText) { newValue in
                                        editedText = newValue
                                    }
                                
                                    .focused($isTextFieldFocused) // Bind focus state to TextField
                                    .onAppear {
                                        // Set focus when entering edit mode to show the keyboard
                                        isTextFieldFocused = true
                                    }
                                    .onChange(of: isTextFieldFocused) { focused in
                                        if !focused {
                                            // Exit edit mode when TextField loses focus (keyboard is dismissed)
                                            templateViewModel.isEditingStoryName = false
                                        }
                                    }
                            } else {
                                // Non-editable Text view
                                Text(editedText)
                                    .font(Font.custom("Fredoka", size: 32).weight(.semibold))
                                
                                    .foregroundColor(Color("FSBlack"))
                                    .onTapGesture {
                                        // Enable editing mode and load text into editedText
                                        templateViewModel.isEditingStoryName = true
                                        isTextFieldFocused = true
                                        //                                        editedText = templateViewModel.selectedTemplate?.templateName ?? ""
                                    }
                            }
                            HStack {
                                Button(action: {
                                    templateViewModel.isEditingStoryName = false
                                    templateViewModel.chosenImage = nil
                                    templateViewModel.isImageInputModalPresented.toggle()
                                }) {
                                    ButtonCircle(widthRatio: 1.0, heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .blue)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    }.onAppear(){
                        editedText = templateViewModel.selectedTemplate?.templateName ?? ""
                    }

                    
                    Text("Pilih foto anak untuk perkenalan dan penutup.")
                        .font(Font.custom("Fredoka", size: 20))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(.fsBlack))

                    Spacer().frame(height: 28)
                    
                    VStack {
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
                                TextField("Masukkan nama", text: $templateViewModel.childName)
                                    .background(Color("FSWhite"))
                                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.fsBlack))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 200)
                                
                            } else {
                                if templateViewModel.childName.isEmpty {
                                    Text("Masukkan nama")
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
                        Spacer().frame(height: 20)
                        if templateViewModel.chosenImage == nil || templateViewModel.childName.isEmpty {
                            HStack {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundStyle(Color("FSPrimaryOrange5"))
                                Text("Foto dan nama wajib diisi.")
                                  .font(Font.custom("SF Pro", size: 16))
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color("FSPrimaryOrange5"))
                            }

                        }

                        Button(action: {
                            
                            viewModel.savedImage = templateViewModel.chosenImage
                            templateViewModel.editNewStory(imageName: viewModel.saveImage())
                            templateViewModel.isImageInputModalPresented = false
                            templateViewModel.isPagePreviewModalPresented = false
                            templateViewModel.isTemplateClosed = true
                            if editedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                editedText = templateViewModel.selectedTemplate!.templateName
                            }
                            templateViewModel.createdStory?.storyName = editedText
                            storyViewModel.updateStory(story: templateViewModel.createdStory!)
                            dismiss()
                        }) {
                            Text("Lanjut")
                                .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                .fontWeight(.medium)
                                .foregroundStyle(Color(.fsWhite))
                                .frame(width: 160, height: 60)
                                .background(templateViewModel.chosenImage != nil && !templateViewModel.childName.isEmpty ? Color(.fsBlue9) : Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .disabled(templateViewModel.chosenImage == nil || templateViewModel.childName.isEmpty)
                        .padding()
                        .frame(width: 728, alignment: .trailing)
                    }
                    .background(
                        // Overlay that detects taps outside the TextField
                        Group {
                            if templateViewModel.isEditingStoryName {
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        templateViewModel.isEditingStoryName = false
                                    }
                            }
                        }
                        
                    )
                }
                .offset(y: keyboardOffset)
                
            }
            .frame(width: 728,height: 743)
            .background(Color(.fsBlue1))
            .cornerRadius(20)
            .padding()
            
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
        
        NavigationLink (
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
    
    private var keyboardOffset: CGFloat {
        guard keyboardHelper.isKeyboardShown else { return 0 }
        if templateViewModel.isEditingTextField {
            return -126
        } else if templateViewModel.isEditingStoryName {
            return 200
        }
        return 0
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
                    Label("Pilih foto", systemImage: "photo")
                }
                
                Button(action: {
                    viewModel.isPhotoCaptured = false
                    viewModel.navigateToCamera = true
                }) {
                    Label("Ambil foto", systemImage: "camera")
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
//                                                                      viewModel.showCropView = true
                                   //TODO: Fix crop view for this, for now lets say langsung foto
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
#Preview {
    ImageInputModal()
}
