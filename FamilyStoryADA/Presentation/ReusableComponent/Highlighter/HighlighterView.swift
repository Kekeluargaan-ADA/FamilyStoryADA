//
//  ShowcaseView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/11/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func highlight(order: Int, title: String, description: String, cornerRadius: CGFloat, style: RoundedCornerStyle, scale: CGFloat = 1, position: PositionStyle) -> some View {
        self
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor, title: title, description: description, cornerRadius: cornerRadius, style: style, scale: scale, position: position)
                return [order:highlight]
            }
    }
}

struct HighlightRoot: ViewModifier {
    var showHighlights: Bool
    var onFinished: () -> ()
    
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlightOrder: Int = 0
    @State private var showView: Bool = true
    @Namespace private var animation
    @State private var showTitle: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlightOrder), showHighlights, showView {
                    if let highlight = preferences[highlightOrder[currentHighlightOrder]] {
                        HighlightView(highlight)
                    }
                }
            }
    }
    
    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        GeometryReader { geometry in
            let highlightRect = geometry[highlight.anchor]
            let safeArea = geometry.safeAreaInsets
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                // Darkened background with cutout for highlight
                Rectangle()
                    .fill(Color.black.opacity(0.5))
                    .reverseMask {
                        Rectangle()
                            .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
                            .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                            .scaleEffect(highlight.scale)
                            .clipShape(RoundedRectangle(
                                cornerRadius: highlight.cornerRadius,
                                style: highlight.style
                            ))
                            .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
                    }
                    .ignoresSafeArea()
                    .onAppear {
                        showTitle = true
                    }
                
                // Overlayed text for title and description
                if showTitle {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13 * heightRatio)
                            .foregroundStyle(Color("FSWhite"))
                            .frame(width: 300 * widthRatio, height: 160 * heightRatio)
                            .shadow(radius: 10 * heightRatio)
                        VStack(alignment: .leading, spacing: 8 * heightRatio) {
                            Text(highlight.title)
                                .font(Font.custom("Fredoka", size: 20 * heightRatio, relativeTo: .title3))
                                .fontWeight(.medium)
                                .foregroundStyle(Color("FSBlack"))
                                .multilineTextAlignment(.leading)
                            Text(highlight.description)
                                .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                                .fontWeight(.regular)
                                .foregroundStyle(Color("FSBlack"))
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            HStack {
                                Text("\(currentHighlightOrder + 1) / \(highlightOrder.count)")
                                    .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                                    .fontWeight(.regular)
                                    .foregroundStyle(Color("FSGrey4"))
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if currentHighlightOrder >= highlightOrder.count - 1 {
                                    Text("Selesai")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                                        .fontWeight(.regular)
                                        .foregroundStyle(Color("FSBlue9"))
                                        .multilineTextAlignment(.leading)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                showView = false
                                            }
                                            onFinished()
                                        }
                                } else {
                                    HStack(spacing: 32 * widthRatio) {
                                        Text("Skip")
                                            .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color("FSGrey"))
                                            .multilineTextAlignment(.leading)
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.25)) {
                                                    showView = false
                                                }
                                                onFinished()
                                            }
                                        Text("Next")
                                            .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color("FSBlue9"))
                                            .multilineTextAlignment(.leading)
                                            .onTapGesture {
                                                withAnimation(.interactiveSpring(response: 0.3,
                                                                                 dampingFraction: 0.7,
                                                                                 blendDuration: 0.7)) {
                                                    currentHighlightOrder += 1
                                                }
                                            }
                                    }
                                }
                                
                            }
                        }
                        .padding(.horizontal, 16 * widthRatio)
                        .padding(.top, 16 * heightRatio)
                        .padding(.bottom, 12 * heightRatio)
                    }
                    .frame(width: 300 * widthRatio, height: 160 * heightRatio)
                    .offset(x: PositionStyle.calculateXOffset(for: highlight.position, highlightRect: highlightRect, width: geometry.size.width),
                            y: PositionStyle.calculateYOffset(for: highlight.position, highlightRect: highlightRect, height: geometry.size.height))
                    .transition(.opacity)
                    .animation(.easeInOut, value: showTitle)
                }
            }
        }
    }
}
extension View {
    @ViewBuilder
    func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: alignment) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}

fileprivate struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int:Highlight] = [:]
    
    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}
