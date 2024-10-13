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
            Rectangle()
            ZStack {
                // Dashed border
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(width: 354, height: 320)
                    .foregroundColor(.gray.opacity(0.5))
                
                VStack {
                    // Plus icon inside a circle
                    Circle()
                        .frame(width: 52, height: 52)
                        .foregroundColor(.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        )
                    
                    // Text below the plus icon
                    Text("Create story")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    NewStoryCardView()
}
