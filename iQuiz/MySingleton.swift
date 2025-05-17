//
//  MySingleton.swift
//  iQuiz
//
//  Created by George Lee on 5/17/25.
//

class ProvidedQuizSingleton {
    static let shared = ProvidedQuizSingleton()
    
    var quizTopics: [QuizTopic] = []

    private init() {
        quizTopics = [
            QuizTopic(
                title: "Math",
                desc: "Sharpen your arithmetic skills!",
//                imageName: "Math",
                questions: [
                    Question(text: "What is 7 x 6?", answers: ["42", "36", "48", "40"], answer: 0),
                    Question(text: "What is the square root of 81?", answers: ["9", "8", "7", "6"], answer: 0)
                ]
            ),
            QuizTopic(
                title: "Marvel",
                desc: "Test your Marvel Universe knowledge!",
//                imageName: "Marvel",
                questions: [
                    Question(text: "What is the name of Thor’s hammer?", answers: ["Stormbreaker", "Gungnir", "Mjolnir", "Excalibur"], answer: 2),
                    Question(text: "Who is Tony Stark’s AI assistant?", answers: ["Jarvis", "Friday", "Karen", "Ultron"], answer: 0)
                ]
            ),
            QuizTopic(
                title: "Science",
                desc: "Learn about the natural world!",
//                imageName: "Science",
                questions: [
                    Question(text: "What is H2O commonly known as?", answers: ["Salt", "Hydrogen", "Water", "Oxygen"], answer: 2),
                    Question(text: "What force keeps us grounded on Earth?", answers: ["Magnetism", "Friction", "Electricity", "Gravity"], answer: 3)
                ]
            )
        ]
    }

    func doSomething() {
        print("Doing something...")
    }
}
