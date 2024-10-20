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
                .foregroundStyle(Color("FSBlue1"))
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(width: 354, height: 320)
                    .foregroundColor(Color("FSBorderBlue7"))
                
                VStack {
                    Circle()
                        .frame(width: 52, height: 52)
                        .foregroundColor(Color("FSSecondaryBlue4"))
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("FSBlue9"))
                        )
                    
                    Text("Create story")
                        .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                        .fontWeight(.medium)
                        .foregroundColor(Color("FSBlue9"))
                }
            }
        }
    }
}

#Preview {
    NewStoryCardView()
}
