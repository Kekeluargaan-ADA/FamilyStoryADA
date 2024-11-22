//
//  CutomizationContentView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 01/11/24.
//

import SwiftUI
import AVKit

struct CustomizationContentView: View {
    @ObservedObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var keyboardHelper: KeyboardHelper
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    @State var currentText: String
    @Binding var isParaphrasingPresented: Bool
    @State var isLimitReached: Bool
    private let wordLimit = 15
    
    @State private var typingTimer: Timer? = nil
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack{
            if let page = viewModel.selectedPage {
                VStack(alignment: .center, spacing: 32 * heightRatio) {
                    CustomizationMediaView(viewModel: viewModel, isParaphrasingPresented: $isParaphrasingPresented, widthRatio: widthRatio, heightRatio: heightRatio)
                    CustomizationTextView(viewModel: viewModel, currentText: currentText, isParaphrasingPresented: $isParaphrasingPresented, isLimitReached: isLimitReached, widthRatio: widthRatio, heightRatio: heightRatio)
                    
                }
                
                .disabled(isParaphrasingPresented)
                .offset(y: !viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented) ? -404 * heightRatio : 0)
            }
        }
        
    }
}
