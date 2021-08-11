//
//  ViewController.swift
//  MilestoneProject7-9
//
//  Created by Harsh Verma on 11/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var lr1: UIView!
    @IBOutlet weak var lr2: UIView!
    @IBOutlet weak var lr3: UIView!
    @IBOutlet weak var lr4: UIView!
    
    
    var letterButton = [UIButton]()
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var word = [String]()
    var correctWord = [String]()
    var error = 0
    var score = 0
    var current = "silkworm"
    let language = ["English", "French"]
    let active = UIColor.black
    let inactive = UIColor(red: 194/255, green: 211/255, blue: 5/255, alpha: 1)
    
    
    
    override func loadView() {
        super.loadView()
        addRows(start: 0, max: 6, view: lr1)
        addRows(start: 6, max: 7, view: lr2)
        addRows(start: 13, max: 6, view: lr3)
        addRows(start: 19, max: 7, view: lr4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGameTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        performSelector(inBackground: #selector(loadWords), with: language[0].lowercased())
    }
    
    
    
    func addRows(start: Int, max: Int, view: UIView) {
        
        for columns in 0..<max {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            button.setTitleColor(active, for: .normal)
            button.setTitle(letters[start + columns], for: .normal)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            
            view.addSubview(button)
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/CGFloat(max)).isActive = true
            button.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            
            
            switch columns {
                case 0:
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                case .max-1:
                    button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                    fallthrough
                default:
                    button.leadingAnchor.constraint(greaterThanOrEqualTo: letterButton[start + (columns - 1)].trailingAnchor).isActive = true
            }
            letterButton.append(button)
            
        }
        
    }
    
    @objc func newGameTapped() {
        let ac = UIAlertController(title: "New game", message: nil, preferredStyle: .actionSheet)
        
        for language in language {
            ac.addAction(UIAlertAction(title: language, style: .default, handler: newGameWithLanguageTapped))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func newGameWithLanguageTapped(action: UIAlertAction) {
        guard let actionTitle = action.title else {
            return
        }
        
        performSelector(inBackground: #selector(loadWords), with: actionTitle.lowercased())
    }
    
    // meant to be executed on background thread
    @objc func loadWords(language: String) {
        if let wordsUrl = Bundle.main.url(forResource: language, withExtension: "txt") {
            if let wordsString = try? String(contentsOf: wordsUrl) {
                word = wordsString.components(separatedBy: "\n")
            }
        }
        
        if word.isEmpty {
            word.append("silkworm")
        }
        
        performSelector(onMainThread: #selector(startGame), with: nil, waitUntilDone: false)
    }
    
    // meant to be executed on main thread
    @objc func startGame() {
        // returns nil only if collection is empty
        current = word.randomElement()!.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        for button in letterButton {
            button.isUserInteractionEnabled = true
            button.setTitleColor(active, for: .normal)
        }
        
        wordLabel.text = String(repeating: "_ ", count: current.count).trimmingCharacters(in: .whitespaces)
        
        error = 0
        correctWord = [String]()
        imageView.image = UIImage(named: "hangman\(error)")
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        let letter = sender.titleLabel?.text
        
        // compare without accents for languages with accentuated letters
        if current.folding(options: .diacriticInsensitive, locale: .current).contains(letter!) {
            correctWord.append(letter!)
            
            manageCorrectGuess()
        }
        else {
            manageIncorrectGuess()
        }
        
        // change button color instead of hiding it
        sender.isUserInteractionEnabled = false
        sender.setTitleColor(inactive, for: .normal)
    }
    
    func manageCorrectGuess() {
        var wordText = ""
        var wordComplete = true
        
        for l in current {
            let strLetter = String(l)
            
            // compare without accents for languages with accentuated letters
            if correctWord.contains(strLetter.folding(options: .diacriticInsensitive, locale: .current)) {
                wordText += "\(strLetter) "
            } else {
                wordText += "_ "
                wordComplete = false
            }
        }
        
        wordLabel.text = wordText.trimmingCharacters(in: .whitespaces)
        
        if wordComplete {
            for button in letterButton {
                button.isUserInteractionEnabled = false
            }
            
            score += 2
            
            let ac = UIAlertController(title: "Congratulations!", message: "Word found:\n\(current)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func manageIncorrectGuess() {
        error += 1
        imageView.image = UIImage(named: "hangman\(error)")
        
        if error == 7 {
            for button in letterButton {
                button.isUserInteractionEnabled = false
            }
            
            score -= 1
            
            let ac = UIAlertController(title: "Sorry!", message: "Word to find was:\n\(current)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

