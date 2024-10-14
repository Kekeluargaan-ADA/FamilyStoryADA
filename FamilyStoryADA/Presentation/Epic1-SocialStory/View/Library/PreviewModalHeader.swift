//
//  Untitled.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//
import SwiftUI

struct PreviewModalHeader: View {
    @State var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                // Button aligned to the left
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundStyle(.gray)
                }
                .frame(width: geometry.size.width * 0.375, alignment: .leading) // 15% width for the button
                
                // Text centered
                Text("Cara Menyikat Gigi")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32))
                    .bold()
                    .frame(width: geometry.size.width * 0.625, alignment: .leading) // 70% width for the text
            }
            .padding()
//            .background(.red) // Background color for better visibility
        }
        .frame(height: 100) // You can adjust the height as needed
    }
}


#Preview {
    PreviewModalHeader(isPresented: true)
}
