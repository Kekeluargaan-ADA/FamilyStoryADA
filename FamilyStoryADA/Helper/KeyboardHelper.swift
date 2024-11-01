//
//  KeyboardHelper.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 28/10/24.
//

import SwiftUI
import Combine

class KeyboardHelper: ObservableObject {
    @Published var isKeyboardShown = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupKeyboardObservers()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in
                self?.isKeyboardShown = true
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.isKeyboardShown = false
            }
            .store(in: &cancellables)
    }
}
