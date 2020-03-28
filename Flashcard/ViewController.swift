//
//  ViewController.swift
//  Flashcard
//
//  Created by Yichen Zhu on 2/21/20.
//  Copyright © 2020 Yichen Zhu. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var buttonOptOne: UIButton!
    @IBOutlet weak var buttonOptTwo: UIButton!
    @IBOutlet weak var buttonOptThree: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        buttonOptOne.layer.cornerRadius = 20.0
        buttonOptTwo.layer.cornerRadius = 20.0
        buttonOptThree.layer.cornerRadius = 20.0
        buttonOptOne.clipsToBounds = true
        buttonOptTwo.clipsToBounds = true
        buttonOptThree.clipsToBounds = true
        buttonOptOne.layer.borderWidth = 3.0
        buttonOptOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        buttonOptTwo.layer.borderWidth = 3.0
        buttonOptTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        buttonOptThree.layer.borderWidth = 3.0
        buttonOptThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            UpdateFlashcard(question: "Who is the director of Her(film)?", answer: "Spike Jonze", extraAnswerOne: "Martin Scorsese", extraAnswerTwo: "Guillermo del Toro", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
        
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight,
                          animations: {
                            if (self.frontLabel.isHidden == true) {
                                self.frontLabel.isHidden = false
                            } else {
                                self.frontLabel.isHidden = true
                            }})
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3,
        animations: {self.card.transform =
            CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if flashcards.count != 0 {
            if currentIndex > flashcards.count - 1 {
                currentIndex = flashcards.count - 1
            }
            updateNextPrevButtons()
            updateLabels()
            saveAllFlashcardsToDisk()
        } else {
            UpdateFlashcard(question: "Who is the director of Her(film)?", answer: "Spike Jonze", extraAnswerOne: "Martin Scorsese", extraAnswerTwo: "Guillermo del Toro", isExisting: false)
        }
    }
    
    func UpdateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne ?? "", extraAnswerTwo: extraAnswerTwo ?? "")
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        buttonOptOne.setTitle(extraAnswerOne, for: .normal)
        buttonOptTwo.setTitle(answer, for: .normal)
        buttonOptThree.setTitle(extraAnswerTwo, for: .normal)
        
        if isExisting {
            flashcards[currentIndex] = flashcard
            
            updateNextPrevButtons()
            updateLabels()
            
        } else {
            flashcards.append(flashcard)
            print("added new flashcard")
            print("we now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("our current index is at \(currentIndex)")
            
            updateNextPrevButtons()
            updateLabels()
        }
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
            
        }
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    
    buttonOptOne.setTitle(currentFlashcard.extraAnswerOne, for: .normal)
        
        buttonOptTwo.setTitle(currentFlashcard.answer, for: .normal)
    buttonOptThree.setTitle(currentFlashcard.extraAnswerTwo, for: .normal)
        frontLabel.isHidden = false
        buttonOptOne.isHidden = false
        buttonOptThree.isHidden = false
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("dictionary array saved")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String : String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    @IBAction func didTapOptOne(_ sender: Any) {
        buttonOptOne.isHidden = true
    }
    @IBAction func didTapOptTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    @IBAction func didTapOptThree(_ sender: Any) {
        buttonOptThree.isHidden = true
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    
}

