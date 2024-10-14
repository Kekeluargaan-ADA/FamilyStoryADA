//
//  LibraryPreviewModality.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import SwiftUI

struct LibraryPreviewModality: View {
    @State private var isPresentingModal = false

    var body: some View {
        VStack {
            Text("Main View")
                .font(.largeTitle)

            Button(action: {
                isPresentingModal = true
            }) {
                Text("Show Modal")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isPresentingModal) {
                ModalView(isPresented: $isPresentingModal)
            }
        }
    }
}

struct ModalView: View {
        @Binding var isPresented: Bool
    let items = Array(1...10) // Example data
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            HStack(){
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 64,height: 64)
                        .foregroundStyle(.gray)
                        .padding()
                }
                Spacer()
                Text("Cara Menyikat Gigi")
                    .font(.system(size: 32))
                    .padding()
                    .bold()
                Spacer()
            }
            
            HStack{
                Rectangle()
                    .frame(width: 280,height: 172)
                    .foregroundStyle(.gray)
                VStack{
                    Text("Brief singkat terkait ini tentang apa brief singkat terkait ini tentang apa brief")
                    Button(action: {
                    }) {
                        Text("Gunakan Template")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }.frame(width:280,height: 172)
            }.padding(25)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        VStack {
                            Text("Preview Page \(item)")
                                .font(.headline)
                                .foregroundColor(.white)
//                                .padding()
                                .frame(width: 280, height: 200)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
//                .padding()
            }.frame(width: 650)
            
        }
    }
}

#Preview{
//    @State var isPresented = true // State for preview purposes
//    LibraryPreviewModality(isPresented: $isPresented)
    LibraryPreviewModality()
}
