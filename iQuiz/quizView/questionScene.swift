import UIKit

class QuestionScene: UIViewController {

    var quizTitle: String?
    var quiz: CurrentQuiz?


    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var quizDropdown: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var selectedAnswerIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Home",
                style: .plain,
                target: self,
                action: #selector(goToRoot)
            )
        
        title = quizTitle ?? "Quiz"
        quizDropdown.backgroundColor = .systemGray6

        loadQuestion()
    }

    func loadQuestion() {
        guard let quiz = quiz else { return }
        let question = quiz.getCurrentQuestion()
        questionLabel.text = question.text
        selectedAnswerIndex = nil

        var actions: [UIAction] = []

        for (index, option) in question.answers.enumerated() {
            let action = UIAction(title: option, state: .off) { [weak self] _ in
                self?.selectedAnswerIndex = index
                self?.quizDropdown.setTitle(option, for: .normal)
            }
            actions.append(action)
        }

        quizDropdown.menu = UIMenu(title: "Click to Choose an answer", children: actions)
        quizDropdown.showsMenuAsPrimaryAction = true
        quizDropdown.setTitle("Select Answer", for: .normal)
    }

    @IBAction func onSubmit(_ sender: Any) {
        guard let quiz = quiz, let selectedIndex = selectedAnswerIndex else { return }

        quiz.answerQuestion(selectedIndex)

        let answerVC = storyboard?.instantiateViewController(withIdentifier: "answerScene") as! AnswerScene
        answerVC.quiz = quiz
        answerVC.question = quiz.getCurrentQuestion()
        answerVC.selectedAnswerIndex = selectedIndex
        navigationController?.pushViewController(answerVC, animated: true)
    }
    
    @objc func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }

}

