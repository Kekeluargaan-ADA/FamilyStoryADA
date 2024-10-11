//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryView: View {
    @ObservedObject var model: ExampleViewModel = ExampleViewModel(id: UUID(uuidString: "37bff686-7d09-4e53-aa90-fb465da131b5")!)
    var body: some View {
        // TODO: use cgwidth and height
        GeometryReader { geometry in
            VStack {
                HStack {
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64)
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 31, height: 26)
                    }
                    Spacer()
                    Text("Cara Menyikat Gigi") // TODO: use data
                        .font(.system(size: 26)) // TODO: change font size
                        .fontWeight(.medium)
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64)
                        Image(systemName: "speaker.wave.2").resizable()
                            .frame(width: 33, height: 26)
                    }
                }
                Spacer().frame(height: 21)
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: 1055, height: 519)
                Spacer().frame(height: 55)
                Text("Ambil sikat gigi.")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
            }
            .padding(47)
        }
    }
}

#Preview {
    PlayStoryView()
}
