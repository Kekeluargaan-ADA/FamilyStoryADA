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
    
    var body: some View {
        HStack {
            TextField("Cari berdasarkan judul, kategori,...", text: $searchText, onCommit: {
                onCommit()
            })
                .padding(10)
                .cornerRadius(25)
                .foregroundStyle(Color("FSBlue9"))
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("FSBlue9"))
                .padding(.trailing, 10)
        }
        .padding(.horizontal, 16)
        .background(Color("FSSecondaryBlue4"))
        .cornerRadius(25)
    }
}
