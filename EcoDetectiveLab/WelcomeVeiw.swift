//
//  WelcomeVeiw.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/28/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var name: String = "" // State to hold the entered name

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to the EIA!")
                    .font(.largeTitle)

                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Ensure the name is not empty before navigating
                if !name.isEmpty {
                    NavigationLink(destination: IntroductionView(name: name)) {
                        Text("Submit")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    WelcomeView()
}
