//
//  DroppableBoxView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import SwiftUI

struct DroppableBoxView: View {
    var order: Int
    var imagePath: String
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundStyle(.tertiary)
                Text("\(order)")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
            .frame(width: 40, height: 40)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 166, height: 166)
                    .foregroundStyle(.secondary)
                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        Rectangle()
                    )
                    .frame(width: 166, height: 166)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 166, height: 166)
            }
        }
    }
}

#Preview {
    DroppableBoxView(order: 1, imagePath: "DummyImage")
}
