//
//  NewStoryCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct NewStoryCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(width: 354, height: 320)
                    .foregroundColor(.gray.opacity(0.5))
                
                VStack {
                    Circle()
                        .frame(width: 52, height: 52)
                        .foregroundColor(.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        )
                    
                    Text("Create story")
                        .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    NewStoryCardView()
}
