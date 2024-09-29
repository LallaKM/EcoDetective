//
//  IntroductionVeiw.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/29/24.
//

import SwiftUI

struct IntroductionView: View {
    var name: String // Accepting the name parameter

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, \(name)! Today is your first day at the Department of Environmental Investigation Agency, better known as EIA. I am your Senior, Jin Johnson. As your first mission, you are assigned to investigate the environmental issues occurring in Baltimore, Maryland. Head there immediately and meet with Mayor White. Ready for your first mission, you pack a fishing rod, trash grabber, and sampling kit. You can view your inventory at any time. You leave and travel to Baltimore.")
                .font(.headline)
                .padding()

            // "Start Adventure" Button
            NavigationLink(destination: ContentView(name: name)) {
                Text("Start Adventure")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Welcome, \(name)")
    }
}

#Preview {
    IntroductionView(name: "Detective Name")
}
