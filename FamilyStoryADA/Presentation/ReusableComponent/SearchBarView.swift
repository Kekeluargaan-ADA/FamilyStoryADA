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
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("FSSecondaryBlue4"))
                .cornerRadius(60 * heightRatio)
            HStack {
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(searchPlaceholder)
                            .font(Font.custom("Fredoka", size: 20 * heightRatio))
                            .foregroundStyle(Color("FSBlue9"))
                    }
                    TextField(searchPlaceholder, text: $searchText, onCommit: {
                        onCommit()
                    })
                    .font(Font.custom("Fredoka", size: 20 * heightRatio))
                    .foregroundStyle(Color("FSBlue9"))
                    .textFieldStyle(PlainTextFieldStyle())
                }
                Button(action: {
                    onCommit()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color("FSBlue9"))
                        .font(.system(size: 24 * heightRatio))
                        .bold()
                }
            }
            .padding(.horizontal, 24 * widthRatio)
        }
        .frame(width: 540 * widthRatio, height: 60 * heightRatio)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchBarView(searchText: $searchText, onCommit: {}, searchPlaceholder: "Caris", widthRatio: 1, heightRatio: 1)
}
