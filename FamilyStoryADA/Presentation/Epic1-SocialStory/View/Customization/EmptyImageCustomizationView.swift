//
//  EmptyImageCustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct EmptyImageCustomizationView: View {
    @EnvironmentObject var keyboardHelper: KeyboardHelper
    @Binding var isParaphrasingPresented: Bool
    @ObservedObject var viewModel: PageCustomizationViewModel
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack {
            if keyboardHelper.isKeyboardShown || isParaphrasingPresented {
                RoundedRectangle(cornerRadius: 12 * heightRatio)
                    .fill(Color("FSWhite").shadow(.drop(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)))
                    .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2 * widthRatio)
                    .mask(Rectangle().padding(.top, 390 * heightRatio))
            } else {
                RoundedRectangle(cornerRadius: 12 * heightRatio)
                    .fill(Color("FSWhite").shadow(.drop(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)))
                    .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2 * widthRatio)
            }
            VStack(spacing: 8 * heightRatio) {
                Image(systemName: "photo")
                    .font(.system(size: 36 * heightRatio))
                    .foregroundStyle(Color("FSBlue9"))
                Text("Upload Photo")
                    .font(.system(size: 24 * heightRatio, weight: .medium))
                    .foregroundStyle(Color("FSBlue9"))
            }
        }
        .frame(width: 760 * widthRatio, height: 468 * heightRatio)
    }
}
