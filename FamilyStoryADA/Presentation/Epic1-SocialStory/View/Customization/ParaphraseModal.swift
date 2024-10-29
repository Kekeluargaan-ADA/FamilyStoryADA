//
//  ParaphraseModal.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 29/10/24.
//

import SwiftUI
import Foundation

struct ParaphraseModal: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background with specified dimensions and rounded corners
            Color.white
                .frame(width: 1194, height: 368)
                .cornerRadius(20)
                .shadow(radius: 5)
            
            // Content aligned to the top leading
            HStack(alignment: .top, spacing: 16) {
                // Close button (xmark)
                Image(systemName: "xmark")
                    .foregroundColor(Color.gray)
                    .padding()
                
                // Title and text items
                VStack(alignment: .leading, spacing: 8) {
                    // Title with icon
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .foregroundColor(Color.purple)
                        Text("Parafrase")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                    // Paraphrased text items
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Saya mengelap mulut menggunakan handuk.")
                        Text("Selanjutnya, keringkan mulut menggunakan handuk.")
                        Text("Lalu, saya membersihkan mulut menggunakan handuk.")
                    }
                    .font(.body)
                    .foregroundColor(.black)
                    HStack(spacing: 16) {
                        // Rephrase Button
                        Button(action: {
                            // Rephrase action
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.clockwise")
                                Text("Rephrase")
                            }
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(Color.blue)
                            .cornerRadius(20)
                        }
                        
                        // Pilih Button
                        Button(action: {
                            // Select action
                        }) {
                            Text("Pilih")
                                .font(.body)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .padding(.leading, 16) // Padding to adjust alignment with background
            .padding(.top, 16)
        }
        .padding() // Outer padding for spacing from the screen edges
    }
}

#Preview{
    ParaphraseModal()
}
