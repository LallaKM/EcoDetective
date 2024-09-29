//
//  Farm.swift
//  EcoDetectiveLab
//
//  Created by Lalla Khadija Mendili on 9/28/24.
//
import SwiftUI

struct Farm: View {
    // Exploration States
    @State private var explored1: Bool = false
    @State private var explored2: Bool = false
    @State private var explored3: Bool = false
    @State private var explored4: Bool = false
    
    // Question States
    @State private var currentQuestionIndex = 0
    @State private var showQuestion: Bool = false
    @State private var showAlert: Bool = false
    @State private var questionAlertText: String = ""
    
    // Inventory
    @State private var inventory: [String] = ["sampling kit"]
    
    // Questions and Answers
    let questions = [
        ("What type of pollution is this?", ["Air", "Soil", "Water", "Land"], "Soil"),
        ("What is the best course of action to combat soil pollution?", ["Physically remove contaminated soil", "Implement microbes", "Soak produce in bicarbonate of soda", "Peel the skin of fruits"], "Implement microbes")
    ]
    
    var body: some View {
        VStack {
            if !explored1 || !explored2 || !explored3 || !explored4 {
                // Exploration Options
                Text("The townspeople have reported being sick from consuming goods from Han's Farmer Market. Investigate the farm sections.")
                    .padding()
                
                Button(action: {
                    if !explored1 {
                        explored1 = true
                        questionAlertText = "The soil in section 1 has leaves that are colored yellow and brown. The leaves are curling and wilting."
                    } else {
                        questionAlertText = "You already explored this section."
                    }
                    showAlert = true
                }) {
                    Text("Explore Section 1")
                        .padding()
                        .background(explored1 ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    if !explored2 {
                        explored2 = true
                        questionAlertText = "The plants in section 2 are shorter than average and show signs of poor health."
                    } else {
                        questionAlertText = "You already explored this section."
                    }
                    showAlert = true
                }) {
                    Text("Explore Section 2")
                        .padding()
                        .background(explored2 ? Color.gray : Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    if !explored3 {
                        explored3 = true
                        questionAlertText = "In section 3, you feel light-headed and dizzy near the plants."
                    } else {
                        questionAlertText = "You already explored this section."
                    }
                    showAlert = true
                }) {
                    Text("Explore Section 3")
                        .padding()
                        .background(explored3 ? Color.gray : Color.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    if !explored4 {
                        explored4 = true
                        questionAlertText = "Section 4 shows small levels of LD50, indicating low tolerance to poison."
                    } else {
                        questionAlertText = "You already explored this section."
                    }
                    showAlert = true
                }) {
                    Text("Explore Section 4")
                        .padding()
                        .background(explored4 ? Color.gray : Color.red)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            } else if inventory.contains("sampling kit") {
                // Use sampling kit after all sections are explored
                Text("After collecting results, use your sampling kit to check the soil.")
                    .padding()
                
                Button(action: {
                    inventory.removeAll { $0 == "sampling kit" }
                    showQuestion = true
                }) {
                    Text("Use Sampling Kit")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            } else if showQuestion {
                // Show Questions
                showQuestionView()
            } else {
                Text("You have completed the investigation. The issue was caused by Triclopyr disrupting the soil bacteria.")
            }
        }
        .padding()
        .navigationTitle("Farm Investigation")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Result"), message: Text(questionAlertText), dismissButton: .default(Text("OK")))
        }
    }
    
    // Show questions based on state
    func showQuestionView() -> some View {
        let question = questions[currentQuestionIndex]
        return VStack {
            Text(question.0)
                .font(.headline)
            ForEach(question.1, id: \.self) { answer in
                Button(action: {
                    checkAnswer(answer)
                }) {
                    Text(answer)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
        }
    }
    
    // Check if the answer is correct
    func checkAnswer(_ answer: String) {
        let correctAnswer = questions[currentQuestionIndex].2
        if answer == correctAnswer {
            questionAlertText = "Correct!"
        } else {
            questionAlertText = "Incorrect. Try again."
        }
        showAlert = true
    }
}

struct Farm_Previews: PreviewProvider {
    static var previews: some View {
        Farm()
    }
}
