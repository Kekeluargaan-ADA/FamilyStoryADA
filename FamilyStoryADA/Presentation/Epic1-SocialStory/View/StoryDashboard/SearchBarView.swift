//
//  SearchBarView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText = ""

        var body: some View {
            HStack {
                TextField("Cari berdasarkan judul, kategori,...", text: $searchText)
                    .padding(10)
                    .cornerRadius(25)
                    .foregroundColor(.gray)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
            }
            .padding(.horizontal, 16)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(25)
        }
}

#Preview {
    SearchBarView()
}
