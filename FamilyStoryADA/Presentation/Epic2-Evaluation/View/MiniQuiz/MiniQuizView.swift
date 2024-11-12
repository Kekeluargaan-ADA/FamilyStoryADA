////
////  MiniQuizView.swift
////  FamilyStoryADA
////
////  Created by Nathanael Juan Gauthama on 11/10/24.
////
//
//import SwiftUI
//
//struct MiniQuizView: View {
//    @StateObject var viewModel: MiniQuizViewModel
//    @Environment(\.dismiss) var dismiss
//    private let textToSpeechHelper = TextToSpeechHelper()
//    var instruction = "Urutkan kartu di bawah sesuai dengan urutan yang benar."
//    init(story: StoryEntity) {
//        _viewModel = StateObject(wrappedValue: MiniQuizViewModel(story: story))
//    }
//    
//    var body: some View {
//        VStack {
//            Spacer(minLength: 47)
//            PlayStoryNavigationView(heightRatio: 1, title: viewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
//                dismiss()
//            }, onTapAudioButton: {
//                textToSpeechHelper.speakIndonesian(instruction)
//            })
//                .padding(.horizontal, 46)
//            Spacer(minLength: 60)
//            Text(instruction)
//                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
//                .fontWeight(.semibold)
//                .foregroundStyle(Color("FSBlack"))
//            Spacer(minLength: 50)
//            
//            DroppableArrayView()
//            .padding(.horizontal, 49)
//            Spacer(minLength: 53)
//            ZStack {
//                RoundedRectangle(cornerRadius: 16)
//                    .foregroundStyle(Color("FSWhite"))
//                    .shadow(radius: 4, x: 0, y: 4)
//                ScrollView(.horizontal) {
//                    HStack (spacing: 15) {
//                        ForEach(viewModel.draggedPages, id: \.id) { page in
//                            
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .foregroundStyle(Color("FSYellow2"))
//                                    .shadow(radius: 4, x: 0, y: 4)
//                                if let imageAppStorage = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
//                                    Image(uiImage: imageAppStorage)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 123, height: 123)
//                                        .clipShape(
//                                            RoundedRectangle(cornerRadius: 12)
//                                        )
//                                } else {
//                                    Image(page.picturePath)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 123, height: 123)
//                                        .clipShape(
//                                            RoundedRectangle(cornerRadius: 12)
//                                        )
//                                }
//                                
//                            }
//                            .frame(width: 123, height: 123)
//                            .draggable(page)
//                        }
//                    }
//                    .padding(.horizontal, 49)
//                    .padding(.vertical, 42)
//                }
//            }
//            .frame(width: 913, height: 207)
//            Spacer()
//        }
//        .ignoresSafeArea()
//        .sheet(isPresented: $viewModel.isAllCorrect, content: {
//            ZStack {
//                Color("FSYellow1")
//                MiniQuizModalView()
//            }
//            .onAppear(perform: {textToSpeechHelper.stopSpeaking()})
//                .presentationDetents([.height(700)])
//        })
//        .onChange(of: viewModel.isDismissed) { value in
//            if value {
//                dismiss()
//            }
//        }
//        .background(Color("FSYellow1"))
//        .environmentObject(viewModel)
//        .navigationBarBackButtonHidden()
//    }
//}
//
////#Preview {
////    MiniQuizView()
////}
