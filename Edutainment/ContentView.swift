//
//  ContentView.swift
//  Edutainment
//
//  Created by Meriç Erkoşun on 27.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    let numberOfQuestions = [5,10,15,20]
    
    @State private var onSettings = false
    @State private var selected = 2
    @State private var choosenNumber = 5
    @State private var nextQuestion : Bool = false
    @State private var questionCounter : Int = 0
    @State private var score : Int = 0
    @State private var questions = [String:String]()
    @State private var answer : String = ""
    @State private var question : String = ""
    @State private var trueAnswer : String = ""
    @State private var isFinished : Bool = false
    
    var body: some View {
        NavigationStack {
            
            if onSettings {
                Text("Question \(questionCounter)")
                Text("Score : \(score)")
                
            }
            VStack {
                Section ("Multiplication Table Up To...") {
                    Picker("Picked", selection: $selected) {
                        ForEach(2..<13, id: \.self){ number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
                Section ("How many question ?") {
                    Picker("Picked", selection: $choosenNumber) {
                        ForEach(numberOfQuestions, id: \.self){ number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
                if !onSettings {
                    Button {
                        onSettings.toggle()
                        generateQuestions(table: selected)
                        takeQuestion()
                        
                    } label: {
                        Text("START")
                    }
                } else if nextQuestion {
                    Button ("NEXT") {
                        takeQuestion()
                    }
                }
                Text(onSettings ? question : "")
                TextField("Your Answer", text: $answer)
                    .frame(width: 150)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                if !isFinished {
                    Button("CHECK") {
                        if answer == trueAnswer {
                            score += 1
                        } else {
                            score -= 1
                        }
                        
                        if questionCounter <= choosenNumber {
                            nextQuestion = true
                        } else {
                            nextQuestion = false
                        }
                    }
                }
            }
        }
    }
    
    func generateQuestions(table: Int) {
        for i in 2...table {
            for q in 1...12 {
                questions["\(i) * \(q)"] = "\(i*q)"
            }
        }
    }
    
    func takeQuestion() {
        
        if questionCounter < choosenNumber {
            nextQuestion = false
            question = questions.keys.randomElement() ?? "Error"
            trueAnswer = questions[question] ?? "Error"
            questionCounter += 1
        } else {
            isFinished = true
        }
    }
}

#Preview {
    ContentView()
}
