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
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundStyle(Color("FSYellow4"))
                Text("\(order)")
                    .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("FSBlack"))
            }
            .frame(width: 32, height: 32)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 124, height: 123)
                    .foregroundStyle(Color("FSYellow2").gradient.shadow(.inner(color: Color("FSBlack").opacity(0.1), radius: 15)))
                
                switch answerCardStatus {
                case .revealed:
                    if let image = imagePath {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 124, height: 123)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                    }
                case .checked:
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 124, height: 123)
                        .foregroundStyle(Color("FSYellow2"))
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
                        .frame(width: 124, height: 123)
                        .foregroundStyle(Color("FSPrimaryOrange5"))
                        .shadow(color: Color("FSPrimaryOrange5"), radius: 8)
                    Text("?")
                        .font(Font.custom("Fredoka", size: 40, relativeTo: .largeTitle))
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
    MiniGameAnswerCardView(order: 1, imagePath: UIImage(imageLiteralResourceName: "MenggosokGigiScene1"), answerCardStatus: .blank)
}
