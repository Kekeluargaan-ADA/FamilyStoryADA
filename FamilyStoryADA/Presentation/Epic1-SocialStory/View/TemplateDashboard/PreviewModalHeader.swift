//
//  Untitled.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//
import SwiftUI

struct PreviewModalHeader: View {
    @State var isPresented: Bool
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
            
            ZStack{
                Button(action: {
                    isPresented = false
                }) {
                    ZStack{
                        Circle()
                            .frame(width: 64 * widthRatio, height: 64 * heightRatio)
                            .foregroundStyle(Color(.fsSecondaryBlue4))
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 22 * widthRatio, height: 22 * heightRatio)
                            .foregroundStyle(Color(.fsBlue9))
                    }
                }
                .frame(width: widthRatio, alignment: .leading)
                .padding()
                Text("Cara Menyikat Gigi")
                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.fsBlack))
                    .frame(width: widthRatio * 0.5, alignment: .center)
            }
            .frame(height: 100 * heightRatio) // You can adjust the height as needed
    }
}


#Preview {
    PreviewModalHeader(isPresented: true, widthRatio: 1, heightRatio: 1)
}
