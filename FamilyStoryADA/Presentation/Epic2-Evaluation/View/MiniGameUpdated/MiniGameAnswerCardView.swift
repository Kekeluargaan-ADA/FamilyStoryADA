//
//  MiniGameAsnwerCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

enum AnswerCardStatus {
    case blank, revealed, checked
}

struct MiniGameAnswerCardView: View {
    var order: Int
    @State var imagePath: UIImage?
    var answerCardStatus: AnswerCardStatus
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundStyle(Color("FSYellow4"))
                Text("\(order)")
                    .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("FSBlack"))
            }
            .frame(width: 32 * widthRatio, height: 32 * heightRatio)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12 * heightRatio)
                    .frame(width: 124 * widthRatio, height: 123 * heightRatio)
                    .foregroundStyle(Color("FSYellow2").gradient.shadow(.inner(color: Color("FSBlack").opacity(0.1), radius: 15 * heightRatio)))
                
                switch answerCardStatus {
                case .revealed:
                    if let image = imagePath {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 124 * widthRatio, height: 123 * heightRatio)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                            )
                    }
                case .checked:
                    RoundedRectangle(cornerRadius: 12 * heightRatio)
                        .frame(width: 124 * widthRatio, height: 123 * heightRatio)
                        .foregroundStyle(Color("FSYellow2"))
                    RoundedRectangle(cornerRadius: 12 * heightRatio)
                        .stroke(style: StrokeStyle(lineWidth: 3 * widthRatio, dash: [5]))
                        .frame(width: 124 * widthRatio, height: 123 * heightRatio)
                        .foregroundStyle(Color("FSPrimaryOrange5"))
                        .shadow(color: Color("FSPrimaryOrange5"), radius: 8 * heightRatio)
                    Text("?")
                        .font(Font.custom("Fredoka", size: 40 * heightRatio, relativeTo: .largeTitle))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("FSPrimaryOrange5"))
                default:
                    EmptyView()
                }
            }
        }
        .onAppear {
            print(order)
        }
    }
}

#Preview {
    MiniGameAnswerCardView(order: 1, imagePath: UIImage(imageLiteralResourceName: "ss01-animated-scene01"), answerCardStatus: .blank, widthRatio: 1, heightRatio: 1)
}
