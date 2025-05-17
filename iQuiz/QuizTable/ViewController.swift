import UIKit

struct QuizTopic: Codable {
    let title: String
    let desc: String
    let questions: [Question]
}
    
struct Question: Codable {
    let text: String
    let answer: Int
    let answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case text, answer, answers
    }
    
    // 1) Decoder initializer: converts JSON "1" → 0, "2" → 1, etc.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text    = try container.decode(String.self, forKey: .text)
        answers = try container.decode([String].self, forKey: .answers)
        
        let answerString = try container.decode(String.self, forKey: .answer)
        guard let oneBased = Int(answerString),
              oneBased >= 1,
              oneBased <= answers.count
        else {
            throw DecodingError.dataCorruptedError(
                forKey: .answer,
                in: container,
                debugDescription: "Answer string is not a valid 1-based index"
            )
        }
        answer = oneBased - 1
    }
    
    init(text: String, answers: [String], answer: Int) {
        self.text    = text
        self.answers = answers
        self.answer  = answer
    }
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
        let correctAnswerIndex = questions[currentQuestionIndex].answer
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        quizTopics = ProvidedQuizSingleton.shared.quizTopics
       quizTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizTable.delegate = self
        quizTable.dataSource = self
        quizTable.rowHeight = 100
        quizTopics = ProvidedQuizSingleton.shared.quizTopics
        quizTable.reloadData()
        
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
//        cell.quizImage.image = UIImage(named: topic.imageName)
        return cell
    }
    
    @IBAction func settingButton(_ sender: Any) {
        //        let alertController = UIAlertController(
        //            title: "Placeholder",
        //            message: "Settings go here",
        //            preferredStyle: .alert
        //        )
        print("Toolbar button tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingVC = storyboard.instantiateViewController(withIdentifier: "settingsScene") as?  settingsScene {
            self.navigationController?.pushViewController(settingVC, animated: true)

        }
//         alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//         self.present(alertController, animated: true, completion: nil)
    }
    
}
