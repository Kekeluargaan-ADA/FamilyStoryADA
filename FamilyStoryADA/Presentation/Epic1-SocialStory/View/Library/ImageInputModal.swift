import SwiftUI

struct ImageInputModal: View {
    @Binding var isPresented: Bool
    @State private var isEditing: Bool = false // To track if the text is being edited
    @State private var name: String = "Hendra" // The editable text

    var body: some View {
        NavigationStack {
            VStack {
                PreviewModalHeader(isPresented: isPresented)
                
                Text("Intinya kasih tau ni foto buat dipake di dalem story")
                
                // Rectangle becomes a NavigationLink to CameraView
                NavigationLink(destination: CameraView()) {
                    Rectangle()
                        .frame(width: 360, height: 450)
                        .foregroundColor(.gray)
                        .overlay(
                            Text("Tap to open Camera")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }

                HStack {
                    if isEditing {
                        // Show a TextField when editing
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200) // Set width to fit inside HStack
                    } else {
                        // Show the regular Text when not editing
                        Text(name)
                    }
                    
                    // Button to toggle between editing and non-editing
                    Button(action: {
                        isEditing.toggle() // Toggle the editing state
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
    }
}

#Preview {
    @Previewable @State var isPresented = true // State for preview purposes
    ImageInputModal(isPresented: $isPresented)
}
