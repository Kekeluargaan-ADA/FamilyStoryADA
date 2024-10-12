//
//  MiniQuizView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import SwiftUI

struct MiniQuizView: View {
    @State var draggablePage = DraggablePage.loadDummyData()
    @State var droppableBox = DraggablePage.loadEmptyArray()
    var body: some View {
        VStack {
            Text("Urutkan kartu di bawah sesuai dengan urutan yang benar.")
                .font(.headline)
                .foregroundStyle(.black)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(droppableBox.enumerated()), id: \.offset) { index, page in
                        DroppableBoxView(order: index+1, imagePath: page.picturePath)
                            .dropDestination(for: DraggablePage.self) { droppedPage, location in
                                
                                for page in droppedPage {
                                    guard !droppableBox.contains(where: {$0.id == page.id}) && droppableBox[index].picturePath == "" else { return false }
                                    
                                    draggablePage.removeAll(where: { $0.id == page.id })
                                    
                                    droppableBox[index] = page
                                }
                                return true
                            } isTargeted: { isTargeted in
                                
                            }
                    }
                }
            }
            
            HStack {
                ForEach(draggablePage, id: \.id) { page in
                    Image(page.picturePath)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 123, height: 123)
                        .draggable(page)
                }
            }
            Spacer()
            
        }
    }
}

#Preview {
    MiniQuizView()
}
