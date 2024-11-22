//
//  CustomizationTextView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 22/11/24.
//

import SwiftUI
import AVFoundation

struct CustomizationTextView: View {
    @ObservedObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var keyboardHelper: KeyboardHelper
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    @State var currentText: String
    @Binding var isParaphrasingPresented: Bool
    @State var isLimitReached: Bool
    private let wordLimit = 15
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    @State private var typingTimer: Timer? = nil
    
    var body: some View {
        ZStack {
            if let page = viewModel.selectedPage {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: Binding(
                        get: { currentText },
                        set: { newValue in
                            let words = newValue.split(separator: " ")
                            if words.count <= 15 {
                                currentText = newValue
                                isLimitReached = false
                            } else {
                                // Keep only the first 15 words
                                currentText = words.prefix(15).joined(separator: " ")
                                isLimitReached = true
                                
                                // Show feedback to user
                                withAnimation {
                                    // Reset the limit reached state after a delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        isLimitReached = false
                                    }
                                }
                            }
                            resetTypingTimer()
                        }
                    ))
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.horizontal, 27 * widthRatio)
                    .padding(.vertical, 15 * heightRatio)
                    .padding(.top, 28 * heightRatio)
                    .frame(width: 760 * widthRatio, height: 168 * heightRatio)
                    .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("FSBlack"))
                    .lineLimit(2)
                    
                    if currentText.isEmpty {
                        Text("Masukkan teks di sini")
                            .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("FSGrey").opacity(0.5))
                            .padding(.horizontal, 30 * widthRatio)
                            .padding(.vertical, 15 * heightRatio)
                            .padding(.top, (28 + 8) * heightRatio)
                            .allowsHitTesting(false)
                    }
                }
                .overlay(
                    Group {
                        if viewModel.selectedPage?.pageTextClassification == "Instructive" {
                            TextBoxBackgroundView()
                                .stroke(Color(.fsPrimaryOrange5), lineWidth: 2 * widthRatio)
                                .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                        } else if viewModel.selectedPage?.pageTextClassification == "Descriptive" {
                            TextBoxBackgroundView()
                                .stroke(Color(.fsBorderBlue7), lineWidth: 2 * widthRatio)
                                .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                        } else {
                            TextBoxBackgroundView()
                                .stroke(Color(.fsBlack), lineWidth: 2 * widthRatio)
                                .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                        }
                    }
                )
                .overlay(alignment: .topLeading) {
                    HStack(spacing: 4 * widthRatio) {
                        Text("\(wordCount)/15 kata")
                            .font(Font.custom("Fredoka", size: 16 * widthRatio))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(isLimitReached ? Color("FSPrimaryOrange5") : Color("FSGrey"))
                            .animation(.easeInOut(duration: 0.2), value: isLimitReached)
                        
                        //                                if isLimitReached {
                        //                                    Image(systemName: "exclamationmark.circle.fill")
                        //                                        .foregroundColor(Color("FSPrimaryOrange5"))
                        //                                        .transition(.scale.combined(with: .opacity))
                        //                                }
                    }
                    .padding(.horizontal, 30 * widthRatio)
                    .padding(.top, 8 * heightRatio)
                }
                .overlay(alignment: .bottomTrailing) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40 * heightRatio)
                            .foregroundStyle(.clear)
                            .frame(width: 123 * widthRatio, height: 40 * heightRatio)
                            .highlight(
                                order: 5,
                                title: "Gunakan AI",
                                description: "Optimisasi konten menggunakan parafrase dengan AI.",
                                cornerRadius: 40 * heightRatio,
                                style: .continuous,
                                position: .topCenter
                            )
                        //TODO: Handle delay for paraphrasing
                        if (viewModel.selectedPage?.pageTextClassification == "Instructive" || viewModel.selectedPage?.pageTextClassification == "Descriptive"){
                            Button(action: {
                                isParaphrasingPresented = true
                                viewModel.paraphraseModalIsLoading = true
                                Task {
                                    do {
                                        let _ = try await viewModel.getParaphrasing(for: currentText)
                                        keyboardHelper.isKeyboardShown = false
                                        viewModel.paraphraseModalIsLoading = false
                                    } catch {
                                        print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                        viewModel.paraphraseModalIsLoading = false
                                    }
                                }
                            }, label: {
                                HStack(spacing: 8 * widthRatio) {
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 16 * heightRatio))
                                        .fontWeight(.medium)
                                    Text("Optimalkan")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .fontWeight(.medium)
                                }
                                .foregroundStyle(Color(.fsBlue9))
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 40 * heightRatio)
                                        .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2 * widthRatio)
                                        .background(
                                            RoundedRectangle(cornerRadius: 40 * heightRatio)
                                                .fill(Color.white)
                                        )
                                )
                                .padding()
                            })
                        }
                    }
                }
                .onAppear {
                    currentText = page.pageText.first?.componentContent ?? ""
                }
                .onChange(of: page.pageText.first?.componentContent) {
                    currentText = page.pageText.first?.componentContent ?? ""
                }
                .overlay(alignment: .topLeading) {
                    HStack {
                        if viewModel.selectedPage?.pageTextClassification == "Instructive" {
                            Image(systemName: "exclamationmark.triangle")
                                .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                .foregroundStyle(Color(.fsOrange))
                            Text("Instruksional")
                                .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                .foregroundStyle(Color(.fsOrange))
                        }
                        else if viewModel.selectedPage?.pageTextClassification == "Descriptive" {
                            Image(systemName: "hand.thumbsup")
                                .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                .foregroundStyle(Color(.fsBlue9))
                            Text("Deskriptif")
                                .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                .foregroundStyle(Color(.fsBlue9))
                        }
                    }
                    .padding(.top, 8 * heightRatio)
                    .padding(.leading, 136 * widthRatio)
                }
                RoundedRectangle(cornerRadius: 10 * heightRatio)
                    .foregroundStyle(.clear)
                    .frame(width: 760 * widthRatio, height: 170 * heightRatio)
                    .highlight(
                        order: 4,
                        title: "Edit Teks",
                        description: "Tekan untuk mengedit teks jika dibutuhkan dan atur sesuai kebiasaan anak.",
                        cornerRadius: 10 * heightRatio,
                        style: .continuous,
                        position: .topCenter
                    )
            }
        }
    }
    
    private func resetTypingTimer() {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            Task {
                do {
                    
                    let result = try await viewModel.getTextClassification(for: currentText)
                    // Uncomment to assign the result if needed
                    // currentText = result
                    await viewModel.selectedPage?.pageTextClassification = result.trimmingCharacters(in: .whitespacesAndNewlines)
                    await viewModel.updatePage()
                } catch {
                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                    // Handle error here, possibly by setting an error message in viewModel
                }
            }
            updatePageText() // Call this after the async operation if order matters
        }
    }
    
    
    private var wordCount: Int {
        currentText.split(separator: " ").count
    }
    
    func updatePageText() {
        if let selectedPage = viewModel.selectedPage, !selectedPage.pageText.isEmpty {
            selectedPage.pageText.first?.componentContent = currentText
        } else {
            viewModel.selectedPage?.pageText = []
            viewModel.selectedPage?.pageText.append(TextComponentEntity(componentId: UUID(),
                                                                        componentContent: currentText,
                                                                        componentCategory: "Text"
                                                                       ))
        }
    }
}
