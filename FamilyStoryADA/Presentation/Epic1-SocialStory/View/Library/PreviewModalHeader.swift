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
            
            ZStack{
                Button(action: {
                    isPresented = false
                }) {
                    ZStack{
                        Circle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(Color(.fsSecondaryBlue4))
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(Color(.fsBlue9))
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding()
                Text("Cara Menyikat Gigi")
                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.fsBlack))
                    .frame(width: geometry.size.width * 0.5, alignment: .center)
            }
        }
        .frame(height: 100) // You can adjust the height as needed
    }
}


#Preview {
    PreviewModalHeader(isPresented: true)
}
