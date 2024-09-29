//
//  ContentView.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/28/24.
//
import SwiftUI

struct ContentView: View {
    var name: String // Accepting the name parameter

    var body: some View {
        VStack(spacing: 20) {
            Text("Here, \(name), is where you would select a location to start from!")
                .font(.headline)
                .padding()

            // Go to Pond Button
            NavigationLink(destination: Pond()) {
                HStack {
                    Image("Pond") // Make sure you have a "Pond" image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 95, height: 70)
                    Text("Go to Pond")
                        .padding()
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }

            // Go to Landfill Button
            NavigationLink(destination: LandfillView()) {
                HStack {
                    Image("Landfill") // Make sure you have a "Landfill" image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 70)
                    Text("Go to Landfill")
                        .padding()
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }

            // Go to Farm Button
            NavigationLink(destination: Farm()) {
                HStack {
                    Image("Farm") // Make sure you have a "Farm" image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 70)
                    Text("Go to Farm")
                        .padding()
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Main Menu")
        .padding()
    }
}

