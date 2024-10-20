//
//  DroppableBoxView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import SwiftUI

struct DroppableBoxView: View {
    var order: Int
    var imagePath: UIImage
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundStyle(Color("FSYellow4"))
                Text("\(order)")
                    .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                    .fontWeight(.bold)
                    .foregroundStyle(Color("FSBlack"))
            }
            .frame(width: 40, height: 40)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 166, height: 166)
                    .foregroundStyle(Color("FSYellow2").gradient.shadow(.inner(color: Color("FSBlack").opacity(0.1), radius: 15)))
                
                Image(uiImage: imagePath)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 166, height: 166)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(Color.black, lineWidth: 2)
//                    .frame(width: 166, height: 166)
            }
        }
    }
}

#Preview {
    DroppableBoxView(order: 1, imagePath: UIImage(imageLiteralResourceName: "DummyImage"))
}
