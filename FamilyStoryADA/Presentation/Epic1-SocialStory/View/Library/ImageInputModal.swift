import SwiftUI

struct ImageInputModal: View {
    @StateObject var viewModel = CameraViewModel()  // You are initializing a new instance, but we can remove this for better consistency
    @Binding var isPresented: Bool
    @State private var isEditing: Bool = false  // To track if the text is being edited
    @State private var name: String = "Hendra"  // The editable text

    var body: some View {
        NavigationView {
            VStack {
                PreviewModalHeader(isPresented: isPresented)
                
                Text("Intinya kasih tau ni foto buat dipake di dalem story")
                
                // Rectangle becomes a NavigationLink to CameraView
                NavigationLink(destination: CameraView()) {
//                    Text(viewModel.savedImageFilename)
                    if let path = viewModel.savedImageFilename {
                        // Display the image path (filename)
                        Text("Image saved at: \(path)")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding()
                    } else {
                        Rectangle()
                            .frame(width: 360, height: 450)
                            .foregroundColor(.gray)
                            .overlay(
                                Text("Tap to open Camera")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            )
                    }
                }
                
                HStack {
                    if isEditing {
                        // Show a TextField when editing
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)  // Set width to fit inside HStack
                    } else {
                        // Show the regular Text when not editing
                        Text(name)
                    }
                    
                    // Button to toggle between editing and non-editing
                    Button(action: {
                        isEditing.toggle()  // Toggle the editing state
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Button(action: {
                    // Your action for the next button
                }) {
                    Text("Lanjut")
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(width: 360, alignment: .trailing)
            }
            .padding()
        }
        .navigationViewStyle(.stack)
        // Ensure that the `viewModel` is received from outside if injected
        .environmentObject(viewModel)
    }
}

#Preview {
    @Previewable @State var isPresented = true  // State for preview purposes
    ImageInputModal(isPresented: $isPresented)
}

