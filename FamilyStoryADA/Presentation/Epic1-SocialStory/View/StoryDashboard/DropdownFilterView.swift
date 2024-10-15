//
//  DropdownFilterView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct DropdownFilterView: View {
    
    @Binding var selectedOption: SortOption

        var body: some View {
            Menu {
                Button(action: {
                    selectedOption = SortOption.newest
                }) {
                    Text(SortOption.newest.rawValue)
                }
                Button(action: {
                    print("Oldest")
                    selectedOption = SortOption.oldest
                    print(selectedOption)
                }) {
                    Text(SortOption.oldest.rawValue)
                }
            } label: {
                HStack {
                    Text(selectedOption.rawValue)
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
    DropdownFilterView(selectedOption: .constant(.oldest))
}
