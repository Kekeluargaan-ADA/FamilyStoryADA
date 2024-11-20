//
//  AddNewPageButtonView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct AddNewPageButtonView: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8 * heightRatio)
                .foregroundStyle(Color("FSBorderBlue7"))
            Image(systemName: "plus")
                .resizable()
                .frame(width: 34 * widthRatio, height: 38 * heightRatio)
                .foregroundStyle(Color("FSBlue9"))
        }
        .frame(width: 152 * widthRatio, height: 93.37 * heightRatio)
    }
}

#Preview {
    AddNewPageButtonView(widthRatio: 1, heightRatio: 1)
}
