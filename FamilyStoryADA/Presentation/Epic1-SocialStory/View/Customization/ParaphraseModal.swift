import SwiftUI
import Foundation

struct ParaphraseModal: View {
    @StateObject var viewModel: PageCustomizationViewModel
    @Binding var isParaphrasingPresented: Bool
    @State var selectedOption: String?
    let widthRatio: CGFloat
    let heightRatio: CGFloat
     // State to track loading

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top, spacing: 16 * widthRatio) {
                // Close button (xmark)
                Button(action: {
                    isParaphrasingPresented.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(Font.system(size: 22 * heightRatio))
                        .foregroundColor(Color.gray)
                        .padding()
                })

                VStack(alignment: .leading, spacing: 8 * heightRatio) {
                    // Title with icon
                    HStack(spacing: 8 * widthRatio) {
                        Image(systemName: "sparkles")
                            .font(Font.system(size: 32 * heightRatio))
                            .foregroundColor(Color.purple)
                        Text("Rekomendasi kalimat")
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("FSBlack"))
                    }

                    // Loading indicator or paraphrased text options
                    if viewModel.paraphraseModalIsLoading {
                        LottieView(animationName: "load-state-icon", width: 68 * widthRatio, height: 72 * heightRatio)
                    } else {
                        VStack(alignment: .leading, spacing: 4 * heightRatio) {
                            ForEach(viewModel.paraphrasedOptions, id: \.self) { paraphrasedText in
                                ParaphraseOptionButton(option: paraphrasedText, selectedOption: $selectedOption, widthRatio: widthRatio, heightRatio: heightRatio)
                            }
                        }
                        .frame(width: 980 * widthRatio)
                        .foregroundColor(.black)
                    }

                    HStack(spacing: 16 * widthRatio) {
                        // Rephrase Button
                        Button(action: {
                            viewModel.paraphraseModalIsLoading = true // Start loading
                            Task {
                                do {
                                    let result = try await viewModel.getParaphrasing(for: viewModel.selectedPage!.pageText.first!.componentContent)
                                    // Update view model's options here
                                    viewModel.paraphraseModalIsLoading = false // Stop loading after fetching
                                } catch {
                                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                    viewModel.paraphraseModalIsLoading = false // Stop loading on error
                                }
                            }
                        }) {
                            HStack(spacing: 4 * widthRatio) {
                                Image(systemName: "arrow.clockwise")
                                    .font(Font.system(size: 20 * heightRatio))
                                    .fontWeight(.medium)
                                Text("Refresh")
                                    .font(Font.custom("Fredoka", size: 20 * heightRatio, relativeTo: .title3))
                                    .fontWeight(.medium)
                            }
                            .font(.body)
                            .frame(width: 160 * widthRatio, height: 60 * heightRatio)
                            .background(Color(.fsSecondaryBlue4))
                            .foregroundColor(Color(.fsBlue9))
                            .cornerRadius(20 * heightRatio)
                        }

                        // Select Button
                        Button(action: {
                            if let option = selectedOption {
                                viewModel.selectedPage?.pageText.first?.componentContent = option
                                // TODO: Refactor this
                                Task {
                                    do {
                                        let result = try await viewModel.getTextClassification(for: option)
                                        viewModel.selectedPage?.pageTextClassification = result.trimmingCharacters(in: .whitespacesAndNewlines)
                                    } catch {
                                        print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                        // Handle error here, possibly by setting an error message in viewModel
                                    }
                                }
                                isParaphrasingPresented = false
                            }
                        }) {
                            Text("Pilih")
                                .font(Font.custom("Fredoka", size: 20 * heightRatio, relativeTo: .title3))
                                .fontWeight(.medium)
                                .frame(width: 160 * widthRatio, height: 60 * heightRatio)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(20 * heightRatio)
                        }
                    }
                    .frame(width: 980 * widthRatio, alignment: .bottomTrailing)
                }

                Spacer()
            }
        }
        .frame(width: 1150 * widthRatio, height: 400 * heightRatio, alignment: .topLeading)
        .cornerRadius(20 * heightRatio)
    }
}

struct ParaphraseOptionButton: View {
    let option: String
    @Binding var selectedOption: String?
    let widthRatio: CGFloat
    let heightRatio: CGFloat

    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack {
                Text(option)
                    .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                    .fontWeight(selectedOption == option ? .medium : .regular)
                    .foregroundColor(Color("FSBlack"))
                Spacer()
                if selectedOption == option {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color(.fsBlue9))
                        .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                        .fontWeight(.medium)
                }
            }
            .frame(width: 980 * widthRatio, height: 20 * heightRatio, alignment: .leading)
            .padding()
            .cornerRadius(8 * heightRatio)
            .background(selectedOption == option ? Color(.fsBlue1) : Color.white)
        }
        Divider()
    }
}
