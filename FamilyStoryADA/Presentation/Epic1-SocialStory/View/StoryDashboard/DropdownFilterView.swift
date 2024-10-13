//
//  DropdownFilterView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct DropdownFilterView: View {
    //TODO: Pass things in viewmodel
    @State private var selectedOption = "Terbaru"
    @State private var options = ["Terbaru", "Popular", "Harga Terendah", "Harga Tertinggi"]

        var body: some View {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption)
                        .font(.system(size: 16, weight: .medium))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
            }
        }
}

#Preview {
    DropdownFilterView()
}
