//
//  TenplateCardView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//
import SwiftUI

struct TemplateCardView: View {
    var template: TemplateEntity
    @State private var isModalPresented = false

    var body: some View {
        Rectangle()
            .foregroundStyle(Color("FSWhite").shadow(.drop(radius: 4, x: 0, y: 4)))
            .frame(width: 354, height: 280)
            .cornerRadius(12)
            .overlay(
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        Image(template.templateCoverImagePath)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    Spacer()
                    HStack {
                        Text(template.templateName)
                            .bold()
                            .font(.system(size: 24))
                        Spacer()
                        Text("3 mins")
                            .font(.system(size: 16))
                    }
                    .padding(12)
                    Spacer().frame(height: 19)
                }
            )
            .onTapGesture {
                isModalPresented = true
            }
            .sheet(isPresented: $isModalPresented) {
                PagePreviewModalView(isPresented: $isModalPresented)
            }
    }
}
