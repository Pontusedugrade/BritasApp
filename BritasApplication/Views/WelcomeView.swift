//
//  WelcomeView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
            Text("You will find your projects to the left.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
