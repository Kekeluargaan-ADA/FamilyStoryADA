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
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 1054, height: 376.83908)
                        .cornerRadius(1054)
                    Rectangle()
                        .foregroundColor(.gray)
                      .frame(width: 1054, height: 330.58047)
                      .cornerRadius(20)
                      .offset(y: 188.41954)
                }
                Spacer()
            }
            .padding(47)
        }
    }
}

#Preview {
    PlayStoryView()
}
