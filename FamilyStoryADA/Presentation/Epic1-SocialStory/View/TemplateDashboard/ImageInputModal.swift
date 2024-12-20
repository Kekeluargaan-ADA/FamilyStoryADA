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
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    ZStack {
                        if templateViewModel.isEditingStoryName {
                            // Editable TextField with auto-save on every keystroke
                            TextField("\(templateViewModel.selectedTemplate!.templateName)", text: $templateViewModel.templateEditName)
                                .font(Font.custom("Fredoka", size: 32 * heightRatio).weight(.semibold))
                                .foregroundColor(Color("FSBlack"))
                                .multilineTextAlignment(.center)
                                .onChange(of: templateViewModel.templateEditName) { _, newValue in
                                    templateViewModel.templateEditName = newValue
                                }
                            
                                .focused($isTextFieldFocused) // Bind focus state to TextField
                                .onAppear {
                                    // Set focus when entering edit mode to show the keyboard
                                    isTextFieldFocused = true
                                }
                                .onChange(of: isTextFieldFocused) { _, focused in
                                    if !focused {
                                        // Exit edit mode when TextField loses focus (keyboard is dismissed)
                                        templateViewModel.isEditingStoryName = false
                                    }
                                }
                        } else {
                            // Non-editable Text view
                            Text(templateViewModel.templateEditName)
                                .font(Font.custom("Fredoka", size: 32 * heightRatio).weight(.semibold))
                            
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
                                templateViewModel.childName = ""
                                templateViewModel.isImageInputModalPresented.toggle()
                            }) {
                                ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .blue)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 24 * widthRatio)
                .padding(.top, 24 * heightRatio)
                
                
                Text("Pilih foto anak untuk perkenalan dan penutup.")
                    .font(Font.custom("Fredoka", size: 20 * heightRatio))
                    .fontWeight(.medium)
                    .foregroundStyle(Color(.fsBlack))
                
                Spacer().frame(height: 28 * heightRatio)
                
                VStack {
                    if let uiImage = templateViewModel.chosenImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300 * widthRatio, height: 400 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .overlay(alignment: .bottom) {
                                ChangePictureButton(widthRatio: widthRatio, heightRatio: heightRatio)
                                    .environmentObject(viewModel)
                                    .environmentObject(templateViewModel)
                            }
                    } else {
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
                            ZStack {
                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                    .fill(Color("FSWhite").shadow(.drop(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)))
                                    .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2 * widthRatio)
                                
                                VStack(spacing: 8 * heightRatio) {
                                    Image(systemName: "photo")
                                        .font(.system(size: 36 * heightRatio))
                                        .foregroundStyle(Color("FSBlue9"))
                                    Text("Upload Foto")
                                        .font(Font.custom("Fredoka", size: 24 * heightRatio))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color("FSBlue9"))
                                }
                            }
                            .frame(width: 300 * widthRatio, height: 400 * heightRatio)
                        }
                    }
                    
                    HStack {
                        if templateViewModel.isEditingTextField {
                            // Show TextField for editing name
                            TextField("Nama anak", text: $templateViewModel.childName)
                                .background(Color("FSWhite"))
                                .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.fsBlack))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200 * widthRatio, height: 32 * heightRatio)
                                .onSubmit {
                                    templateViewModel.isEditingTextField = false
                                }
                                .onChange(of: keyboardHelper.isKeyboardShown) { _, value in
                                    if value == false {
                                        templateViewModel.isEditingTextField = false
                                    }
                                }
                                .padding(.top, 10 * heightRatio)
                            
                        } else {
                            if templateViewModel.childName.isEmpty {
                                Text("Nama anak")
                                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.fsBlack))
                                    .onTapGesture {
                                        templateViewModel.isEditingTextField.toggle()
                                    }
                            } else {
                                Text(templateViewModel.childName)
                                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
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
                                .font(.system(size: 20 * heightRatio))
                                .fontWeight(.bold)
                                .frame(width: 22 * widthRatio, height: 22 * heightRatio)
                                .foregroundColor(Color(.fsGrey))
                        }
                    }
                    Spacer().frame(height: 20 * heightRatio)
                    if templateViewModel.chosenImage == nil || templateViewModel.childName.isEmpty {
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundStyle(Color("FSPrimaryOrange5"))
                            Text("Foto dan nama wajib diisi.")
                                .font(Font.custom("SF Pro", size: 16 * heightRatio))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("FSPrimaryOrange5"))
                        }
                        
                    } else {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 16 * heightRatio)
                    }
                    
                    Button(action: {
                        
                        viewModel.savedImage = templateViewModel.chosenImage
                        templateViewModel.editNewStory(imageName: viewModel.saveImage())
                        templateViewModel.isImageInputModalPresented = false
                        templateViewModel.isPagePreviewModalPresented = false
                        templateViewModel.isTemplateClosed = true
                        if templateViewModel.templateEditName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            templateViewModel.templateEditName = templateViewModel.selectedTemplate!.templateName
                        }
                        templateViewModel.createdStory?.storyName = templateViewModel.templateEditName
                        storyViewModel.updateStory(story: templateViewModel.createdStory!)
                        dismiss()
                    }) {
                        Text("Lanjut")
                            .font(Font.custom("Fredoka", size: 20 * heightRatio, relativeTo: .title3))
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.fsWhite))
                            .frame(width: 160 * widthRatio, height: 60 * heightRatio)
                            .background(templateViewModel.chosenImage != nil && !templateViewModel.childName.isEmpty ? Color(.fsBlue9) : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 40 * heightRatio))
                    }
                    .disabled(templateViewModel.chosenImage == nil || templateViewModel.childName.isEmpty)
                    .frame(width: 728 * widthRatio, alignment: .trailing)
                    .padding()
                    .padding(.trailing, 56 * widthRatio)
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
            .frame(width: 728 * widthRatio, height: 743 * heightRatio)
            .background(Color(.fsBlue1))
            .cornerRadius(20 * heightRatio)
            .padding()
            
        }
        .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: {
            if viewModel.isPhotoCaptured, let _ = viewModel.savedImage {
                // Show crop view once an image is selected
                viewModel.showCropView = true
                viewModel.isPhotoCaptured = false
            }
        }) {
            ImagePicker()
                .environmentObject(viewModel)
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
        
        // NavigationLink for CameraView
        NavigationLink(destination: CameraView.shared
            .environmentObject(viewModel),
                       isActive: $viewModel.navigateToCamera) {
        }
                       .onChange(of: viewModel.navigateToCamera) { _, value in
                           if !value, viewModel.isPhotoCaptured, let selectedImage = viewModel.savedImage {
                               // Show crop view once an image is selected
                               templateViewModel.chosenImage = selectedImage
                               viewModel.savedImage = selectedImage
                               //                                                                      viewModel.showCropView = true
                               //TODO: Fix crop view for this, for now lets say langsung foto
                               viewModel.isPhotoCaptured = false
                               
                           }
                       }
        
        NavigationLink (
            destination: CropImageView(croppingStyle: .portrait)
                .environmentObject(viewModel),
            isActive: $viewModel.showCropView,
            label: {
                EmptyView()
            }
        ).onChange(of: viewModel.showCropView) { _, value in
            if !value, let croppedImage = viewModel.savedImage {
                templateViewModel.chosenImage = croppedImage
                
            }
        }
    }
    
    private var keyboardOffset: CGFloat {
        guard keyboardHelper.isKeyboardShown else { return 0 }
        if templateViewModel.isEditingTextField {
            return -126 * heightRatio
        } else if templateViewModel.isEditingStoryName {
            return 200 * heightRatio
        }
        return 0
    }
}

struct ChangePictureButton: View {
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @State var isMenuPresented: Bool = false
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
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
                    .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(.fsBlack))
                    .frame(width: 140 * widthRatio, height: 40 * heightRatio)
                    .background(isMenuPresented ? Color(.fsActiveYellow) : Color(.fsSecondaryBlue4))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 40 * heightRatio)
                    )
            }
            .padding(.bottom, 20 * heightRatio)
            .onAppear {
                isMenuPresented = false
            }
            .onTapGesture {
                isMenuPresented.toggle()
            }
            
            
        }
        
        
    }
}



//
#Preview {
    ImageInputModal(widthRatio: 1, heightRatio: 1)
}
