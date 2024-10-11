//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryView: View {
    @StateObject private var viewModel: PlayStoryViewModel
    
    init(templateRepository: TemplateRepository, templateId: UUID, pageId: UUID) {
        _viewModel = StateObject(wrappedValue: PlayStoryViewModel(templateRepository: templateRepository, templateId: templateId, pageId: pageId))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                Spacer()
                HStack {
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 31 * widthRatio, height: 26 * heightRatio)
                    }
                    Spacer()
                    Text(viewModel.templateName)
                        .font(.system(size: 26 * heightRatio))
                        .fontWeight(.medium)
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame(width: 33 * widthRatio, height: 26 * heightRatio)
                    }
                }
                Spacer().frame(height: 21 * heightRatio)
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                Spacer().frame(height: 55 * heightRatio)
                Text(viewModel.pageText)
                    .font(.system(size: 32 * heightRatio))
                    .fontWeight(.bold)
                Spacer().frame(height: 55 * heightRatio)
                
                HStack {
                    Button(action: {
                        viewModel.goToPreviousPage()
                    }) {
                        Text("Previous")
                            .font(.system(size: 18 * heightRatio))
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .disabled(viewModel.currentPageIndex == 0)
                    
                    Spacer().frame(width: 20 * widthRatio)
                    
                    Button(action: {
                        viewModel.goToNextPage()
                    }) {
                        Text("Next")
                            .font(.system(size: 18 * heightRatio))
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .disabled(viewModel.currentPageIndex >= viewModel.templatePages.count - 1)
                }
                .padding(.bottom, 20 * heightRatio)
            }
            .padding(47 * heightRatio)
        }
    }
}



#Preview {
    PlayStoryView(
        templateRepository: JSONTemplateRepository(),
        templateId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab")!,
        pageId: UUID(uuidString: "ff76e366-d832-45ca-8237-d81ebe7f6f22")!
    )
}
