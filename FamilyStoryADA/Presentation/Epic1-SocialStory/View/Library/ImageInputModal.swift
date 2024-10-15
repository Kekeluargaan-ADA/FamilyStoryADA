//
//  Page.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//


import SwiftUI

struct ImageInputModal: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            PreviewModalHeader(isPresented: isPresented)
            
        }
    }
}


#Preview{
//    @Previewable @State var isPresented = true // State for preview purposes
//    LibraryPreviewModality(isPresented: $isPresented)
//    PreviewImageModal(isPresented: $isPresented)
}
