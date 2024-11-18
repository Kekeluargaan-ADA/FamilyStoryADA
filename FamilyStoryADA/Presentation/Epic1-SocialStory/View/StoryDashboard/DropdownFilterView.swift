//
//  DropdownFilterView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct DropdownFilterView: View {
    
    @ObservedObject var viewModel: StoryViewModel
    @Binding var selectedOption: SortOption
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        Menu {
            Button(action: {
                selectedOption = .newest
                viewModel.selectedOption = .newest
                viewModel.sortDisplayedStories()  // Trigger sorting in the ViewModel
            }) {
                Text(SortOption.newest.rawValue)
            }
            Button(action: {
                
                selectedOption = .oldest
                viewModel.selectedOption = .oldest
                viewModel.sortDisplayedStories()  // Trigger sorting in the ViewModel
            }) {
                Text(SortOption.oldest.rawValue)
            }
        } label: {
            HStack {
                Text(selectedOption.rawValue)
                    .font(.system(size: 16 * heightRatio, weight: .medium))
                    .foregroundStyle(Color("FSBlack"))
                Image(systemName: "chevron.down")
                    .font(.system(size: 12 * heightRatio, weight: .medium))
            }
            .padding()
            .background(Color("FSBlue1"))
            .frame(width: 117 * widthRatio, height: 28 * heightRatio)
            .cornerRadius(20 * heightRatio)
        }
    }
}

