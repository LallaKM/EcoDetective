//
//  Pond.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/28/24.
//
import SwiftUI

struct Pond: View {
    @State private var fishingResult: (String, String)? = nil
    @State private var isFishing = false
    @State private var currentQuestion: Int = 0
    @State private var showQuestions = false
    @State private var message: String = ""
    @State private var letters: [String] = []
    @State private var hasCompletedQuestions = false // New state variable

    // List of possible random items to fish out
    let randomItems = ["Old Boot", "Plastic Bag", "Tin Can", "Driftwood", "Lost Key", "Empty Bottle", "Rubber Duck"]

    // Questions and answers
    let questions: [(question: String, options: [String], correctAnswer: String, explanation: String)] = [
        (
            "What type of environmental issue is this?",
            ["A. Water pollution", "B. Unauthorized Access to the Pond", "C. Littering", "D. Increase in plastic"],
            "A",
            "Water pollution is a critical issue caused by harmful substances like fertilizers entering water bodies."
        ),
        (
            "What do you think is the direct cause of the issue?",
            ["A. Overfeeding of fish", "B. Nutrient runoff", "C. Climate change and rising temperature", "D. Increased rainfall and runoff"],
            "B",
            "Nutrient runoff is the primary cause of algae blooms, as excess fertilizers enter the water and provide nutrients for algae."
        ),
        (
            "What is the best course of action in order to combat water pollution, specifically algae buildup?",
            ["A. Lowering pH by adding natural elements such as peat moss", "B. Use chemicals to kill the algae", "C. Fostering vegetation that can absorb the excess nutrients", "D. Feed the fishes to improve their health"],
            "C",
            "Fostering vegetation like hornwort can effectively absorb excess nutrients and help control algae growth."
        )
    ]

    var body: some View {
        VStack(spacing: 20) {
            if let result = fishingResult {
                // Display the result after fishing
                Text("You fished out a \(result.0) and a \(result.1)!")
                    .font(.headline)
                    .padding()

                // Start the Q&A section
                Button(action: {
                    showQuestions = true
                    currentQuestion = 0
                    message = "You noticed something odd. A bottle of fertilizer? This might be connected to the algae blooms."
                }) {
                    Text("Continue")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            } else {
                Text("Cast your line to see what you catch!")
                    .font(.headline)
                    .padding()

                Button(action: {
                    fish()
                }) {
                    Text(isFishing ? "Fishing..." : "Go Fishing")
                        .padding()
                        .foregroundColor(.white)
                        .background(isFishing ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(isFishing) // Disable button while fishing is in progress
            }

            if showQuestions {
                VStack {
                    Text(message)
                        .padding()

                    if currentQuestion < questions.count {
                        Text(questions[currentQuestion].question)
                            .font(.headline)
                            .padding()

                        ForEach(questions[currentQuestion].options, id: \.self) { option in
                            Button(action: {
                                handleAnswer(option)
                            }) {
                                Text(option)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 5)
                        }
                    } else {
                        Text("You decide to encourage the locals to plant fast-growing stem plants that thrive under the unique situation of the pond in order to solve the issue. Later studies have found that your solution helped with the algae blooming. Good job!")
                            .padding()

                        // Add letter to inventory
                        Button("Receive Reward") {
                            letters.append("Letter 1 - Protect")
                            message = "Overview: Algae blooms are caused by excess amounts of nutrients like nitrogen and phosphorus in the water. This is normally caused by these nutrients, often found in fertilizer, running off into the water. When algae proliferate and then die, their decomposition consumes a significant amount of oxygen in the water. This is known as “Hypoxia”. Fishes and other water-based organisms suffocate and die, negatively affecting the ecosystem."
                            
                            // Unlock the button after all questions are completed
                            hasCompletedQuestions = true
                        }
                    }
                }
                .padding()
            }

            // Button to return to main menu
            if hasCompletedQuestions {
                Button(action: {
                    NavigationLink(ContentView: View) {
                        
                    }
                }) {
                    Text("Return to Main Menu")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }

    // Fishing function with a 3-second delay
    func fish() {
        isFishing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Fishing for 3 seconds
            // Randomly pick an item from the randomItems list
            let randomItem = randomItems.randomElement() ?? "Mystery Item"
            fishingResult = ("Bottle of Fertilizer", randomItem)
            isFishing = false
        }
    }

    // Handle user's answer
    func handleAnswer(_ answer: String) {
        let correctAnswer = questions[currentQuestion].correctAnswer
        if answer.starts(with: correctAnswer) {
            if currentQuestion < questions.count - 1 {
                currentQuestion += 1
                message = ""
            } else {
                // If last question answered correctly
                message = "Great job answering all the questions!"
                hasCompletedQuestions = true // Unlock the return button
            }
        } else {
            // Provide explanation for incorrect answers
            let explanation = questions[currentQuestion].explanation
            message = "Incorrect. \(explanation) Please try again."
        }
    }
}


struct Pond_Previews: PreviewProvider {
    static var previews: some View {
        Pond()
    }
}
