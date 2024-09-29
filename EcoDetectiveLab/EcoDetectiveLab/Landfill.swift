//
//  Landfill.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/28/24.
//
import SwiftUI

struct LandfillView: View {
    @State private var inventory: [String] = ["trash grabber"]
    @State private var letters: [String] = []
    @State private var userInput: String = ""
    @State private var currentItem: String? // Ensure this is mutable
    @State private var currentQuestion: String?
    @State private var feedbackMessage: String = "" // Added for user feedback
    
    var body: some View {
        VStack {
            Text("You encounter a garbage collector. You decide to talk to them.")
                .padding()
            Text("Town's garbage collector: I have worked for over a decade. The trash in the landfill is overflowing.")
                .padding()

            // Button to start sorting task
            Button("Help the Collector Sort Trash") {
                landfillTask() // Calls the method when the button is clicked
            }
            .padding()

            // Check if there is a current item to sort
            if let currentItem = currentItem {
                Text("Sort this item: \(currentItem)")
                    .padding()

                TextField("Enter your answer", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Submit Answer") {
                    checkAnswer() // Submits the answer for checking
                }
                .padding()
            }

            // Check if there is a final question to answer
            if let currentQuestion = currentQuestion {
                Text(currentQuestion)
                    .padding()

                TextField("Enter your answer", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Submit Answer") {
                    checkFinalAnswer() // Submits the final question answer
                }
                .padding()
            }

            // Display feedback message to the user
            Text(feedbackMessage)
                .foregroundColor(.green)
                .padding()
        }
        .navigationTitle("Landfill")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to initiate the landfill task
    func landfillTask() {
        // Check if the user has the required item
        if let index = inventory.firstIndex(of: "trash grabber") {
            inventory.remove(at: index) // Removes the item from inventory
            currentItem = "Apple Core" // Set the item to sort
            userInput = "" // Reset user input
            feedbackMessage = "" // Clear feedback message
        } else {
            feedbackMessage = "You don't have a trash grabber!" // Show feedback if no item
        }
    }

    // Function to check the answer provided by the user
    func checkAnswer() {
        guard let currentItem = currentItem else { return }
        
        let correctAnswer = correctAnswerForItem(currentItem) // Get the correct answer
        if userInput.lowercased() == correctAnswer {
            feedbackMessage = "Correct!" // Provide positive feedback
            letters.append("Letter for \(currentItem)") // Record the correct item
            userInput = "" // Reset user input
        } else {
            feedbackMessage = "Wrong! Try again." // Provide negative feedback
        }
    }

    // Function to determine the correct answer for the given item
    func correctAnswerForItem(_ item: String) -> String {
        switch item {
        case "Apple Core", "Banana Peel":
            return "compost"
        case "Plastic Bottle", "Plastic Bag":
            return "recycle"
        case "Shattered Mirror", "Styrofoam Cup":
            return "trash"
        default:
            return ""
        }
    }

    // Function to get the next item to sort
    func getNextItemToSort() -> String? {
        let itemsToSort = ["Apple Core", "Plastic Bottle", "Plastic Bag", "Shattered Mirror", "Banana Peel", "Styrofoam Cup"]
        guard let currentIndex = itemsToSort.firstIndex(of: currentItem ?? "") else { return nil }
        if currentIndex + 1 < itemsToSort.count {
            return itemsToSort[currentIndex + 1] // Return next item if available
        } else {
            finalQuestion() // No more items, ask the final question
            return nil
        }
    }

    // Function to present the final question after sorting
    func finalQuestion() {
        currentQuestion = "What do you think is the best way to reduce waste going into the landfill?"
        userInput = "" // Reset user input
        feedbackMessage = "" // Clear feedback for final question
    }

    // Function to check the final answer
    func checkFinalAnswer() {
        guard let currentQuestion = currentQuestion else { return }

        if userInput.lowercased() == "b" {
            feedbackMessage = "That’s right! Recycling and composting are crucial." // Positive feedback
            letters.append("Letter 3 - Planet") // Record final answer
            feedbackMessage += "\nThe mayor rewards you with a word. You now have \(letters.count) letters." // Update feedback message
        } else {
            feedbackMessage = "Not quite! Try again." // Negative feedback
        }
    }
}

// Preview for LandfillView
struct LandfillView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LandfillView()
        }
    }
}
