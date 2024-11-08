//
//  PageCustomizationViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import Foundation
import UIKit
import AVFoundation

// TODO: PINDAHIN KE MANAGER KALO LOGIC BUSINESS

class PageCustomizationViewModel: Imageable, ObservableObject {
    @Published var story: StoryEntity
    @Published var introPages: [DraggablePage] = []
    @Published var draggedPages: [DraggablePage] = []
    @Published var selectedPage: PageEntity?
    @Published var isMiniQuizOpened: Bool = false
    @Published var isPlayStoryOpened: Bool = false
    @Published var isMediaOverlayOpened: Bool = false
    @Published var isGotoCameraView: Bool = false
    @Published var isGotoImagePicker: Bool = false
    @Published var isGotoScrapImage: Bool = false
    @Published var isDeleteSelected: Bool = false
    @Published var videoPlayer: AVPlayer = AVPlayer()
    @Published var paraphrasedOptions: [String] = []
    @Published var paraphraseModalIsLoading: Bool = false
    
    var pageUsecase: PageUsecase
    var storyUsecase: StoryUsecase
    var componentUsecase: ComponentUsecase
    
    init(story: StoryEntity) {
        self.story = story
        self.pageUsecase = ImplementedPageUsecase.shared
        self.storyUsecase = ImplementedStoryUsecase.shared
        self.componentUsecase = ImplementedComponentUsecase.shared
        
        self.selectedPage = story.pages.first(where: {$0.pageType == "Introduction" || $0.pageType == "Instruction"})
        
        self.introPages = DraggablePage.fetchIntroductionPages(story: story)
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
    }
    
    //make new blank page
    public func addNewBlankPage() {
        let newPage = PageEntity(pageId: UUID(),
                                 pageType: "Instruction",
                                 pageText: [],
                                 pagePicture: [],
                                 pageVideo: [],
                                 pageSoundPath: "",
                                 pageTextClassification: ""
        )
        
        let closingFirstIndex = story.pages.firstIndex(where: {$0.pageType == "Closing"})
        
        if pageUsecase.addPage(page: newPage) == newPage.pageId {
            story.pages.insert(newPage, at: (closingFirstIndex ?? story.pages.count - 1))
            if storyUsecase.updateStory(story: story) {
                self.draggedPages = DraggablePage.fetchDraggedPage(story: self.story)
                
                self.selectedPage = newPage
                if selectedPage == nil {
                    if let firstPage = story.pages.first(where: {$0.pageType == "Instruction" || $0.pageType == "Introduction"}) {
                        self.selectedPage = firstPage
                    }
                }
            }
        }
    }
    
    // move page
    public func movePage(_ page: DraggablePage, toIndex newIndex: Int) {
        var nextIndex = newIndex
        if let currentIndex = draggedPages.firstIndex(where: { $0.id == page.id }) {
            if currentIndex == newIndex {return}
            if currentIndex > newIndex {nextIndex += 1}
            self.draggedPages.remove(at: currentIndex)
            let validIndex = min(max(nextIndex, 0), draggedPages.count)
            draggedPages.insert(page, at: validIndex)
            
            reorderStoryPages()
        }
    }
    
    private func reorderStoryPages() {
        var reorderedPages = [PageEntity]()
        
        reorderedPages.append(contentsOf: story.pages.filter({ $0.pageType == "Opening" || $0.pageType == "Introduction"}))
        
        for draggedPage in draggedPages {
            if let matchingPage = story.pages.first(where: { $0.pageId == draggedPage.id }) {
                reorderedPages.append(matchingPage)
            }
        }
        
        reorderedPages.append(contentsOf: story.pages.filter({ $0.pageType == "Closing"}))
        
        story.pages = reorderedPages
        
        if storyUsecase.updateStory(story: story) {
            self.draggedPages = DraggablePage.fetchDraggedPage(story: self.story)
        }
    }
    
    // when user select page
    public func selectPage(page: DraggablePage) {
        // TODO: save previously selected picture
        updatePage()
        if let page = story.pages.first(where: {$0.pageId == page.id}) {
            self.selectedPage = page
        }
    }
    
    // when user want to delete page
    // TODO: Delete all component and ratio
    public func deletePage() {
        if let page = selectedPage {
            if let storyIndex = story.pages.firstIndex(where: {page.pageId == $0.pageId}) {
                //remove page swiftdata
                guard pageUsecase.removePage(pageId: page.pageId) else { return }
                
                //remove page in story entity
                story.pages.removeAll(where: {$0.pageId == page.pageId})
                //update pageid in story swiftdata, by updating
                if storyUsecase.updateStory(story: story) {
                    //update draggedPage
                    self.introPages = DraggablePage.fetchIntroductionPages(story: self.story)
                    self.draggedPages = DraggablePage.fetchDraggedPage(story: self.story)
                    guard !story.pages.isEmpty else {
                        selectedPage = nil
                        return
                    }
                    // old next page algorithm
                    //                    if storyIndex > 0 {
                    //                        selectedPage = story.pages[storyIndex - 1]
                    //                    } else {
                    //                        selectedPage = story.pages[storyIndex]
                    //                    }
                    
                    // new next page algorithm
                    if storyIndex < story.pages.count, story.pages[storyIndex].pageType != "Closing" {
                        // next index is selectedPage
                        selectedPage = story.pages[storyIndex]
                    } else if storyIndex - 1 >= 0, story.pages[storyIndex - 1].pageType != "Opening" {
                        // previous index is selectedPage
                        selectedPage = story.pages[storyIndex - 1]
                    } else {
                        self.selectedPage = story.pages.first(where: {$0.pageType == "Introduction" || $0.pageType == "Instruction"})
                    }
                }
                
            }
        }
    }
    
    public func updatePage() {
        if let currentPage = self.selectedPage {
            updateTextComponent(page: currentPage)
            updateMedia(page: currentPage)
            _ = pageUsecase.editPage(page: currentPage)
            _ = storyUsecase.updateStory(story: self.story)
        }
    }
    
    private func updateTextComponent(page: PageEntity) {
        if let text = page.pageText.first {
            if text.componentContent.isEmpty, componentUsecase.removeComponent(componentId: text.componentId) {
                page.pageText = []
                page.pageTextClassification = ""
            } else if componentUsecase.updateComponent(component: text), let changedPage = story.pages.first(where: {$0.pageId == page.pageId}) {
                changedPage.pageText = []
                changedPage.pageText.append(text)
            } else if componentUsecase.addNewComponent(component: text) != nil {
                page.pageText = []
                page.pageText.append(text)
//                    if let classification = selectedPage?.pageTextClassification {
//                        page.pageTextClassification = classification
//                    } else {
//                        page.pageTextClassification = ""
//                    }
            }
        }
    }
    
    private func updateMedia(page: PageEntity) {
        // If there is picture input
        if let picture = page.pagePicture.first {
            if componentUsecase.updateComponent(component: picture) {
                page.pagePicture = []
                page.pagePicture.append(picture)
                self.introPages = DraggablePage.fetchIntroductionPages(story: self.story)
                self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
            } else {
                if componentUsecase.addNewComponent(component: picture) != nil {
                    page.pagePicture = []
                    page.pagePicture.append(picture)
                    self.introPages = DraggablePage.fetchIntroductionPages(story: self.story)
                    self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
                }
            }
        }
    }
    
    public func getParaphrasing(for text: String) async throws -> [String] {
        let prompt = """
                Cari 3 opsi lain untuk memparafrase kalimat berikut agar menjadi kalimat deskriptif tanpa mengubah makna atau konteksnya. Pastikan jumlah kata mirip, dengan perbedaan maksimal 4 kata. Dilarang keras menggunakan kalimat instruksional seperti ajakan, perintah, atau anjuran. Berikan hasil hanya dalam format JSON tanpa tambahan kata atau penjelasan lain. Formatnya harus seperti berikut:

                {
                    "original_text": "{teks}",
                    "paraphrased_options": [
                        {
                            "option_1": "{parafrase_1}"
                        },
                        {
                            "option_2": "{parafrase_2}"
                        },
                        {
                            "option_3": "{parafrase_3}"
                        }
                    ]
                }

                Kalimat: \(text)

                Contoh deskriptif: "aku menggosok gigi."
                Contoh instruksional (yang harus dihindari): "ayo gosok gigi."
                """
        
        let response = try await getResponse(prompt: prompt)
            
        guard let jsonData = response.data(using: .utf8) else {
                throw NSError(domain: "Invalid JSON format", code: -1, userInfo: nil)
            }
            
            do {
                let paraphraseData = try JSONDecoder().decode(ParaphraseData.self, from: jsonData)
                let options = paraphraseData.paraphrasedOptions.map { $0.option }
                
                // Update the @Published property on the main thread
                DispatchQueue.main.async {
                    self.paraphrasedOptions = options
                }
                
                return options
            } catch {
                print("Failed to parse JSON: \(error.localizedDescription)")
                throw error
            }
    }

    public func getTextClassification(for text: String) async throws -> String {
        let prompt = """
                Anda bertugas mengidentifikasi apakah teks berikut adalah "Instructive" atau "Descriptive". 
                Contoh deskriptif: aku menggosok gigi. 
                Contoh instruktif: ayo gosok gigi. 
                Kembalikan hasil hanya dalam format: "Instructive" atau "Descriptive"
                text: \(text)
"""
        
        do {
            let response = try await getResponse(prompt: prompt)
            return response
        } catch {
            throw error
        }
    }
    
    
}

extension PageCustomizationViewModel {
    func handleScrapImageSelection(_ filename: String) {
        if let page = selectedPage, page.pagePicture.isEmpty {
            // Create new picture component if none exists
            selectedPage?.pagePicture.append(
                PictureComponentEntity(
                    componentId: UUID(),
                    componentContent: filename,
                    componentCategory: "AppStoragePicture"
                )
            )
        } else {
            // Update existing picture component
            selectedPage?.pagePicture.first?.componentContent = filename
            selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
        }
        
        // Update the page and close related views
        updatePage()
        isGotoScrapImage = false
        isMediaOverlayOpened = false
    }
    
    //filter requirement for add new page to be added
    func isAddButtonAppeared() -> Bool {
        return self.story.pages.count(where: { $0.pageType == "Instruction" }) < 10
    }
    
}


// For the new .onMove method
extension PageCustomizationViewModel {
    public func reorderPage() {
        for index in 0..<draggedPages.count {
            if draggedPages[index].order != index {
                draggedPages[index].order = index
            }
        }
        reorderStoryPages()
    }
}
