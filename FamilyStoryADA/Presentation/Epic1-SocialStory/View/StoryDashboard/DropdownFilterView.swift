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
                    .font(Font.custom("Fredoka", size: 16 * heightRatio))
                    .foregroundStyle(Color("FSBlack"))
            }
            Button(action: {
                
                selectedOption = .oldest
                viewModel.selectedOption = .oldest
                viewModel.sortDisplayedStories()  // Trigger sorting in the ViewModel
            }) {
                Text(SortOption.oldest.rawValue)
                    .font(Font.custom("Fredoka", size: 16 * heightRatio))
                    .foregroundStyle(Color("FSBlack"))
            }
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20 * heightRatio)
                    .fill(Color(.fsBlue3))
                    .frame(width: 117 * widthRatio, height: 28 * heightRatio)
                HStack {
                    Text(selectedOption.rawValue)
                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                        .foregroundStyle(Color("FSBlack"))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12 * heightRatio))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("FSBlack"))
                }
            }
            .frame(width: 117 * widthRatio, height: 28 * heightRatio)
        }
    }
}

