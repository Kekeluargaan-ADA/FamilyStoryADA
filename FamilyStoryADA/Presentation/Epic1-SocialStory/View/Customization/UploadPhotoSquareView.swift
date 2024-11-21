//
//  UploadPhotoPage.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct UploadPhotoSquareView: View {
    @State private var isModalPresented = false
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        
        ZStack {
            Button(action: {
                withAnimation {
                    isModalPresented.toggle()
                }
            }) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                    .cornerRadius(12 * heightRatio)
                    .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                .inset(by: 1)
                                .stroke(Color("FSBorderBlue7"))
                            VStack {
                                Image(systemName: "photo")
                                    .foregroundStyle(Color("FSBlue9"))
                                    .font(.system(size: 26 * heightRatio))
                                    .bold()
                                Spacer().frame(height: 8 * heightRatio)
                                Text("Upload Foto")
                                    .font(.system(size: 24 * heightRatio))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("FSBlue9"))
                            }
                        }
                    )
            }
            .buttonStyle(.plain)
            if isModalPresented {
                
                UploadPhotoModalView(widthRatio: widthRatio, heightRatio: heightRatio)
                
            }
        }
    }
}

#Preview {
    UploadPhotoSquareView(widthRatio: 1, heightRatio: 1)
}
