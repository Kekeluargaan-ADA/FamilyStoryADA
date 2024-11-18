//
//  DraggablePageReorderedCustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 08/11/24.
//

import SwiftUI

struct DraggablePageReorderedCustomizationView: View {
    @EnvironmentObject var viewModel: PageCustomizationViewModel
    @Binding var draggedPages: [DraggablePage]
    @Binding var introPages: [DraggablePage]
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    let edgeInset = EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
    
    var body: some View {
        List {
            ForEach(Array(introPages), id: \.id) { page in
                if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                    DraggedPageView(imagePath: image,
                                    order: page.order+1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                } else if page.picturePath != "" {
                    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                    order: page.order+1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                } else {
                    DraggedPageView(order: page.order+1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                }
            }
            
            ForEach(Array(draggedPages), id: \.id) { page in
                if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                    DraggedPageView(imagePath: image,
                                    order: page.order + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                } else if page.picturePath != "" {
                    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                    order: page.order + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                } else {
                    DraggedPageView(order: page.order  + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        viewModel.selectPage(page: page)
                    }
                    .listRowInsets(edgeInset)
                }
            }
            .onMove { indexSet, destination in
                draggedPages.move(fromOffsets: indexSet, toOffset: destination)
                viewModel.reorderPage()
            }
            
            // add button only appear if visible page is below 10
            if  viewModel.isAddButtonAppeared() {
                Button(action: {
                    viewModel.addNewBlankPage()
                }, label: {
                    AddNewPageButtonView(widthRatio: widthRatio, heightRatio: heightRatio)
                })
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(edgeInset)
            }
        }
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle()) // Use PlainListStyle to remove default padding around the List
        .padding(.top, 0 * heightRatio) // Removes top padding
        .padding(.horizontal, 20 * widthRatio)
        .padding(.leading, 5  * widthRatio)
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    DraggablePageReorderedCustomizationView()
//}
