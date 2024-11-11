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
                    .onTapGesture {
                        if currentHighlightOrder >= highlightOrder.count - 1 {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showView = false
                            }
                            onFinished()
                        } else {
                            withAnimation(.interactiveSpring(response: 0.3,
                                                             dampingFraction: 0.7,
                                                             blendDuration: 0.7)) {
                                //                                showTitle = false
                                currentHighlightOrder += 1
                            }
                            
                            //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            //                                showTitle = true
                            //                            }
                        }
                    }
                    .onAppear {
                        showTitle = true
                        print(highlightRect.midX)
                        print(highlightRect.midY)
                    }
                
                // Overlayed text for title and description
                if showTitle {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundStyle(Color("FSWhite"))
                            .frame(width: 300, height: 160)
                            .shadow(radius: 10)
                        VStack(alignment: .leading) {
                            Text(highlight.title)
                                .font(.headline)
                                .foregroundStyle(Color("FSBlack"))
                                .padding(10)
                            //                                .cornerRadius(8)
                        }
                    }
                    .frame(width: 300, height: 160)
                                        .offset(x: PositionStyle.calculateXOffset(for: highlight.position, highlightRect: highlightRect, width: geometry.size.width),
                                                y: PositionStyle.calculateYOffset(for: highlight.position, highlightRect: highlightRect, height: geometry.size.height))
                    //                    .offset(
                    //                        x: highlightRect.midX - geometry.size.width / 2 + highlightRect.width / 2 + 150,
                    //                        y: highlightRect.midY - geometry.size.height / 2
                    //                    )
//                    .offset(
//                        x: highlightRect.midX - geometry.size.width / 2,
//                        y: highlightRect.midY - geometry.size.height / 2  + highlightRect.height / 2 + 80
//                    )
                    //                    .offset(
                    //                        x: -( highlightRect.width / 2 + 150/2),
                    //                        y: highlightRect.midY
                    //                    )
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
