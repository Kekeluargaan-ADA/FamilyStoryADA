//
//  LibraryPreviewModality.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import SwiftUI

//struct LibraryPreviewModality: View {
//    @State private var isPresentingModal = false
//
//    var body: some View {
//        VStack {
//            Text("Main View")
//                .font(.largeTitle)
//
//            Button(action: {
//                isPresentingModal = true
//            }) {
//                Text("Show Modal")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .sheet(isPresented: $isPresentingModal) {
//                PagePreviewModalView(isPresented: $isPresentingModal)
//            }
//        }
//    }
//}

struct PagePreviewModalView: View {
    @Binding var isPresented: Bool
    let items = Array(1...10) // Example data
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            PreviewModalHeader(isPresented: isPresented) // Updated to pass a binding

            HStack {
                Rectangle()
                    .frame(width: 280, height: 172)
                    .foregroundStyle(.gray)
                VStack {
                    Text("Brief singkat terkait ini tentang apa brief singkat terkait ini tentang apa brief")
                    Button(action: {
                        // Action for using the template
                    }) {
                        Text("Gunakan Template")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .frame(width: 280, height: 172)
            }
            .padding(25)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        VStack {
                            Text("Preview Page \(item)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 280, height: 200)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .frame(width: 650)
        }
    }
}


#Preview{
    @Previewable @State var isPresented = true // State for preview purposes
//    LibraryPreviewModality(isPresented: $isPresented)
    PagePreviewModalView(isPresented: $isPresented)
}
