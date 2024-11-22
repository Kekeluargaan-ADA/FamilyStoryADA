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
    @Binding var isVideoReadyToPlay: Bool
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
                                    isIntroduction: true,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                } else if page.picturePath != "" {
                    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                    order: page.order+1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    isIntroduction: true,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                } else {
                    DraggedPageView(order: page.order+1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    isIntroduction: true,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                }
            }
            
            ForEach(Array(draggedPages), id: \.id) { page in
                if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                    DraggedPageView(imagePath: image,
                                    order: page.order + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    isIntroduction: false,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                    .listRowBackground(Color(.fsBlue6))
                } else if page.picturePath != "" {
                    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                    order: page.order + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    isIntroduction: false,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                    .listRowBackground(Color(.fsBlue6))
                } else {
                    DraggedPageView(order: page.order  + introPages.count + 1,
                                    isSelected: viewModel.selectedPage?.pageId == page.id,
                                    isIntroduction: false,
                                    widthRatio: widthRatio,
                                    heightRatio: heightRatio
                    )
                    .onTapGesture {
                        if page.id != viewModel.selectedPage?.pageId {
                            viewModel.selectPage(page: page)
                            viewModel.isVideoReadyToPlay = false
                        }
                    }
                    .listRowInsets(edgeInset)
                    .listRowBackground(Color(.fsBlue6))
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
                    viewModel.isVideoReadyToPlay = false
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
        .listStyle(PlainListStyle())
        .padding(.top, 0 * heightRatio)
        .padding(.horizontal, 20 * widthRatio)
        .padding(.leading, 5  * widthRatio)
        .padding(.bottom, 150 * heightRatio)
        .scrollIndicators(.hidden)
    }
}
