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
    
    var body: some View {
            VStack {
                ForEach(introPages, id: \.id) { page in
                    if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                        DraggedPageView(imagePath: image,
                                        order: page.order+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else if page.picturePath != "" {
                        DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                        order: page.order+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else {
                        DraggedPageView(order: page.order+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    }
                }
                
                ForEach(draggedPages, id: \.id) { page in
                    if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                        DraggedPageView(imagePath: image,
                                        order: page.order + introPages.count + 1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else if page.picturePath != "" {
                        DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                        order: page.order + introPages.count + 1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else {
                        DraggedPageView(order: page.order  + introPages.count + 1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
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
                        AddNewPageButtonView()
                    })
                }
            }
            .listRowBackground(Color.clear)
            .background(Color.clear)
        }
}

//#Preview {
//    DraggablePageReorderedCustomizationView()
//}
