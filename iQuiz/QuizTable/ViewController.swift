import UIKit

struct QuizTopic {
    var title: String
    var desc: String
    var imageName: String
    var questions: [Question]
}

struct Question {
    var text: String
    var options: [String]
    var correctAnswerIndex: Int
}

class CurrentQuiz {
    var questions: [Question]
    var currentQuestionIndex: Int
    var score: Int
    var userAnswer: Int

    init(questions: [Question]) {
        self.questions = questions
        self.currentQuestionIndex = 0
        self.score = 0
        self.userAnswer = -1
    }

    func answerQuestion(_ userAnswerIndex: Int) {
        let correctAnswerIndex = questions[currentQuestionIndex].correctAnswerIndex
        if userAnswerIndex == correctAnswerIndex {
            score += 1
        }
        userAnswer = userAnswerIndex
    }

    func getCurrentQuestion() -> Question {
        return questions[currentQuestionIndex]
    }

    func advanceToNextQuestion() {
        if currentQuestionIndex != questions.count - 1 {
            currentQuestionIndex += 1
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTable: UITableView!

    var quizTopics: [QuizTopic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        quizTable.delegate = self
        quizTable.dataSource = self
        quizTable.rowHeight = 100

        quizTopics = [
            QuizTopic(
                title: "Math",
                desc: "Sharpen your arithmetic skills!",
                imageName: "Math",
                questions: [
                    Question(text: "What is 7 x 6?", options: ["42", "36", "48", "40"], correctAnswerIndex: 0),
                    Question(text: "What is the square root of 81?", options: ["9", "8", "7", "6"], correctAnswerIndex: 0)
                ]
            ),
            QuizTopic(
                title: "Marvel",
                desc: "Test your Marvel Universe knowledge!",
                imageName: "Marvel",
                questions: [
                    Question(text: "What is the name of Thor’s hammer?", options: ["Stormbreaker", "Gungnir", "Mjolnir", "Excalibur"], correctAnswerIndex: 2),
                    Question(text: "Who is Tony Stark’s AI assistant?", options: ["Jarvis", "Friday", "Karen", "Ultron"], correctAnswerIndex: 0)
                ]
            ),
            QuizTopic(
                title: "Science",
                desc: "Learn about the natural world!",
                imageName: "Science",
                questions: [
                    Question(text: "What is H2O commonly known as?", options: ["Salt", "Hydrogen", "Water", "Oxygen"], correctAnswerIndex: 2),
                    Question(text: "What force keeps us grounded on Earth?", options: ["Magnetism", "Friction", "Electricity", "Gravity"], correctAnswerIndex: 3)
                ]
            )
        ]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizTopics.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = quizTopics[indexPath.row]
        let quiz = CurrentQuiz(questions: topic.questions)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let questionVC = storyboard.instantiateViewController(withIdentifier: "questionScene") as?  QuestionScene {
            questionVC.quizTitle = topic.title
            questionVC.quiz = quiz
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTable.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! quizCell
        let topic = quizTopics[indexPath.row]
        cell.quizTitle.text = topic.title
        cell.quizDesc.text = topic.desc
        cell.quizImage.image = UIImage(named: topic.imageName)
        return cell
    }

    @IBAction func settingButton(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Placeholder",
            message: "Settings go here",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
