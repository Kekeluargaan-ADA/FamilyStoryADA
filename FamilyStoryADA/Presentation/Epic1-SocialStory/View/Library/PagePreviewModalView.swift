//
//  LibraryPreviewModality.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import SwiftUI

struct PagePreviewModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var template: TemplateEntity
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(width: 728, height: 743) // Fixed dimensions
                    .foregroundStyle(Color("FSBlue1"))
                    .cornerRadius(20)
                    .overlay(
                        VStack {
                            HStack {
                                ZStack {
                                    HStack {
                                        Button(action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            ButtonCircle(heightRatio: 1.0, buttonImage: "xmark", buttonColor: .blue) // Use fixed height for button
                                        }
                                        Spacer()
                                    }
                                    Text("Cara Menyikat Gigi")
                                        .font(
                                            Font.custom("Fredoka", size: 32)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(Color("FSBlack"))
                                }
                            }
                            Spacer().frame(height: 24)
                            
                            BriefSquareView(heightRatio: 1.0, widthRatio: 1.0) // Use fixed values
                            
                            Spacer().frame(height: 24)
                            ScrollView {
                                LazyVGrid(
                                    columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)],
                                    spacing: 16
                                ) {
                                    ForEach(1...6, id: \.self) { step in
                                        StepsSquareView(heightRatio: 1.0, widthRatio: 1.0) // Use fixed values
                                    }
                                }
                            }
                            .padding(.horizontal, 45)
                        }
                        .padding(24)
                    )
            }
            .frame(width: 2000,height: 2000)
            .background(.clear.opacity(0.4))
        }
    }
}
