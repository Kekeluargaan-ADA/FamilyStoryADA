import SwiftUI
import Foundation

struct ParaphraseModal: View {
    @StateObject var viewModel: PageCustomizationViewModel
    @Binding var isParaphrasingPresented: Bool
    @State var selectedOption: String?
     // State to track loading

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top, spacing: 16) {
                // Close button (xmark)
                Button(action: {
                    isParaphrasingPresented.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(Font.system(size: 22))
                        .foregroundColor(Color.gray)
                        .padding()
                })

                VStack(alignment: .leading, spacing: 8) {
                    // Title with icon
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(Font.system(size: 32))
                            .foregroundColor(Color.purple)
                        Text("Parafrase")
                            .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("FSBlack"))
                    }

                    // Loading indicator or paraphrased text options
                    if viewModel.paraphraseModalIsLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .frame(width: 980, alignment: .center)
                    } else {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(viewModel.paraphrasedOptions, id: \.self) { paraphrasedText in
                                ParaphraseOptionButton(option: paraphrasedText, selectedOption: $selectedOption)
                            }
                        }
                        .frame(width: 980)
                        .foregroundColor(.black)
                    }

                    HStack(spacing: 16) {
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
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.clockwise")
                                    .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                    .fontWeight(.medium)
                                Text("Rephrase")
                                    .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                    .fontWeight(.medium)
                            }
                            .font(.body)
                            .frame(width: 160, height: 60)
                            .background(Color(.fsSecondaryBlue4))
                            .foregroundColor(Color(.fsBlue9))
                            .cornerRadius(20)
                        }

                        // Select Button
                        Button(action: {
                            if let option = selectedOption {
                                viewModel.selectedPage?.pageText.first?.componentContent = option
                                isParaphrasingPresented = false
                            }
                        }) {
                            Text("Pilih")
                                .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                .fontWeight(.medium)
                                .frame(width: 160, height: 60)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    .frame(width: 980, alignment: .bottomTrailing)
                }

                Spacer()
            }
        }
        .frame(width: 1150, height: 400, alignment: .topLeading)
        .cornerRadius(20)
    }
}

struct ParaphraseOptionButton: View {
    let option: String
    @Binding var selectedOption: String?

    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack {
                Text(option)
                    .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                    .fontWeight(selectedOption == option ? .medium : .regular)
                    .foregroundColor(Color("FSBlack"))
                Spacer()
                if selectedOption == option {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color(.fsBlue9))
                        .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                        .fontWeight(.medium)
                }
            }
            .frame(width: 980, height: 20, alignment: .leading)
            .padding()
            .cornerRadius(8)
            .background(selectedOption == option ? Color(.fsBlue1) : Color.white)
        }
        Divider()
    }
}
