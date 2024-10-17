//
//  AddNewPageButtonView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct AddNewPageButtonView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color("FSBorderBlue7"))
            Image(systemName: "plus")
                .resizable()
                .frame(width: 34, height: 38)
                .foregroundStyle(Color("FSBlue9"))
        }
        .frame(width: 152, height: 93.37)
    }
}

#Preview {
    AddNewPageButtonView()
}
