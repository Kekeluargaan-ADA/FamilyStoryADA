//
//  SearchBarView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onCommit: () -> Void
    var searchPlaceholder: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("FSSecondaryBlue4"))
                .cornerRadius(60)
            HStack {
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(searchPlaceholder)
                            .font(Font.custom("Fredoka", size: 20))
                            .foregroundStyle(Color("FSBlue9"))
                    }
                    TextField(searchPlaceholder, text: $searchText, onCommit: {
                        onCommit()
                    })
                    .font(Font.custom("Fredoka", size: 20))
                    .foregroundStyle(Color("FSBlue9"))
                    .textFieldStyle(PlainTextFieldStyle())
                }
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color("FSBlue9"))
                    .font(.system(size: 24))
                    .bold()
            }
            .padding(.horizontal, 24)
        }
        .frame(width: 540, height: 60)

    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchBarView(searchText: $searchText, onCommit: {}, searchPlaceholder: "Caris")
}
