//
//  ViewController.swift
//  WhatZodiacSignIsThis
//
//  Created by MyMac on 8/19/23.
//

import UIKit
import SAConfettiView
import AVFoundation

class GamePlayOneViewController: UIViewController {
    
    @IBOutlet weak var jokesLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var correctSignKeyFromJokesArray: String = ""
    
    var usersSelectedAnswer: String = ""
    
    var correctAnswer: String = ""
    
    var player: AVAudioPlayer!
    // Creating var of AVAudioPlayer type so we can use its features
    // AVAudioPlay is a dtat type from the AVFoundation
    
    var streaks = [String]()
    var currentHotStreak = 0
    var newHotStreak = 0
    
    // To Capture all hot streaks and display them in table view
    var hotStreaksCountTableViewArray = [Int]()
    
    var filteredHotStreaksCountTableViewArray = [Int]()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    var answerButtonNames = ["AquariusButton", "AriesButton", "CancerButton", "CapricornButton", "GeminiButton", "LeoButton", "LibraButton", "PiscesButton", "SagittariusButton", "ScorpioButton", "TaurusButton", "VirgoButton"]
    
    
    
    
    
    let jokesArray: [String: [String]] = [
        "AriesButton": [
            "I don't wait for elevators; I take the stairs. Who has time to stand around?",
            "New restaurant? I'm there! I live for taste adventures.",
            "Sports? I don't just watch; I compete with the players from my couch!",
            "Personal trainer? Nah, I'm the life coach of my own journey!",
            "A rock band? Count me in! I've got enough energy to light up a stadium!"
        ],
        "TaurusButton": [
            "Buffet? That's where I set up camp, sampling all the delights.",
            "Puzzle? I won't quit until every piece finds its place!",
            "Movie night? Classic films, cozy blankets, and my comfort zone intact.",
            "Gardening? I'm in. The patience for growth runs in my roots.",
            "Umbrella? Always ready. I'm the dependable one in every storm."
        ],
        "GeminiButton": [
            "Texting? I could have a full conversation before you finish your sentence!",
            "Music? I've got playlists for every mood and scenario.",
            "Indecisiveness? I've mastered the art of keeping options open.",
            "Two-faced? Nah, I'm just well-equipped for different situations.",
            "Socializing? I thrive in crowds and can charm anyone within seconds."
        ],
        "CancerButton": [
            "Home is where the heart is, and my heart is always in my cozy sanctuary.",
            "Sentimental? My keepsake box is a treasure trove of memories.",
            "Intuition? I trust my gut feelings more than anything else.",
            "Family time? My calendar is blocked for quality bonding moments.",
            "Empathy? I've got a radar for everyone's emotions, even the cat's."
        ],
        "LeoButton": [
            "Spotlight? Just follow the crowd's applause; I'm the center of attention.",
            "Drama? Life is my stage, and I'm the star of every scene.",
            "Generosity? I give, and people can't help but love me for it.",
            "Confidence? I'm not just self-assured; I'm practically radiating it.",
            "Roar? It's not just a sound; it's my majestic presence announcing itself."
        ],
        "VirgoButton": [
            "Did you see that organized closet? Yep, that's my masterpiece.",
            "Perfectionism? I'm not obsessed; I just want everything flawless.",
            "Routine? My schedule is a work of art, down to the minute.",
            "Detail-oriented? I spot what others miss; it's a gift and a curse.",
            "Analyzing? I can dissect a situation until every angle is explored."
        ],
        "LibraButton": [
            "Decision-making? Let's consult a committee before I choose.",
            "Balance? It's not just a yoga pose; it's my life philosophy.",
            "Harmony? I'm like a mediator superhero, always restoring peace.",
            "Social gatherings? I orchestrate events like a seasoned conductor.",
            "Flirting? I'm not just charming; I've mastered the art of attraction."
        ],
        "ScorpioButton": [
            "Secrets? They're safe with me. I'm like a vault of mysteries.",
            "Intense? My emotions run deep, and I don't hold back.",
            "Detective skills? I can uncover the truth even in the shadows.",
            "Passion? It's not just a word; it's the fire that fuels my every move.",
            "Transformation? I embrace change like a phoenix rising from ashes."
        ],
        "SagittariusButton": [
            "Wanderlust? You bet! My passport is always ready for an adventure.",
            "Philosophy? I ponder life's big questions while others are still waking up.",
            "Optimism? I'm not just hopeful; I see the silver lining everywhere.",
            "Adventure? My bucket list is as long as my tales of epic journeys.",
            "Freedom? I can't be caged; I'm the free spirit of the zodiac."
        ],
        "CapricornButton": [
            "Goal-setting? I don't just climb; I conquer mountains.",
            "Ambition? My dreams have a GPS, and I'm heading straight there.",
            "Workaholic? It's not just a job; it's my legacy in the making.",
            "Responsibility? I'm the reliable one people turn to in any crisis.",
            "Discipline? I'm not just organized; I'm a master of self-control."
        ],
        "AquariusButton": [
            "Rules? I'd rather invent new ones and see where they take us.",
            "Innovation? I'm not just creative; I'm a visionary thinker.",
            "Humanitarian? I can't help but fight for a better world.",
            "Rebellion? It's not just a phase; it's my lifelong outlook.",
            "Individuality? I march to my own beat, and the parade follows."
        ],
        "PiscesButton": [
            "Dreams? I dive into them and swim in my imagination.",
            "Intuition? I sense things others miss, like a psychic without the crystal ball.",
            "Empathy? I feel for everyone, even fictional characters on TV.",
            "Creativity? I'm not just artistic; my ideas come from cosmic inspiration.",
            "Daydreaming? It's not a distraction; it's where my magic happens."
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()

    }
    
    
    // Fetch random joke from the jokes array
    func getRandomJoke() {
        
        // Grab a randon Sign/Key from the jokes array
        // IF we can grab a random key THEN
        if let randomSignKey = jokesArray.randomElement() {
            // Let's tap into the value of that random key. Value are teh arrays assicated with each key and then we grab a random one and grab a random joke. Aka let randomJoke
            
            // Capturing the random key so I can use in the getAnswers function below
            correctSignKeyFromJokesArray = randomSignKey.key
            
            let randomJoke = randomSignKey.value.randomElement()
            // Now let's let the text of that random joke equal our jokes label so we can display the randomJoke on the screen
            jokesLabel.text = randomJoke
        }
        
    }
    
  
    func getAnswers() {
        
        // OUR GOAL HERE:
        // Clear the current images assigned to the buttons
        // Clear the background color previously selected
        // Setting all buttons to be enabled since 2 will be disabled when we us the baloon 50/50
        for button in answerButtons {
            button.setTitle("", for: .normal)
            button.backgroundColor = nil
            button.isEnabled = true
        }
        
        
        
        var createAnswers: [String] = []
        
        // Add the correct answer to the list from the auto generated correctSignKeyFromJokesArray
        createAnswers.append(correctSignKeyFromJokesArray)
        
        // Creating a WHILE LOOP to Add 3 random wrong answers to the list
        // WHILE the count of our createAnswers array is NOT more than 4
        while createAnswers.count < 4 {
            // Grabbing/capturing a random button name from our answerButtonNames array
            let randomAnswerButtonName = answerButtonNames.randomElement()!
            // Making sure that:
            // 1. Our random button name is NOT the correctSignKeyFromJokesArray
            // 2. Our createAnswer array DOES NOT ALREADY contain the randomAnswerButtonName
            if randomAnswerButtonName != correctSignKeyFromJokesArray && !createAnswers.contains(randomAnswerButtonName) {
                // If the conditons above are MET THEN we can append to the randomAnswerButtonName to our createAnswers array
                createAnswers.append(randomAnswerButtonName)
            }
        }
        
        // Checking the make sure our loop worked and that we only retuen 4 answers 1 of which is correct and 3 are incorrect with NO DUPLICATES
        print(createAnswers)
        
        // Shaking up the answer order to make sure they are in random order
        createAnswers.shuffle()
        
        // Assign the images to the buttons
        for (button, answerName) in zip(answerButtons, createAnswers) {
            if let addButtonImage = UIImage(named: answerName) {
                button.setImage(addButtonImage, for: .normal)
                // Setting the accessibilityIdentifier to each button name so we can access it within the highlightSelectedButton functions
                button.accessibilityIdentifier = answerName
            }
        }
    

    }
    
    
    
    

    @IBAction func highlightSelectedButton(_ sender: UIButton) {
        
        var scoreLabelInt = Int(scoreLabel.text!)!
        
        
            if let imageNameOfButton = sender.accessibilityIdentifier {
                usersSelectedAnswer = imageNameOfButton
                print("You selected \(usersSelectedAnswer)")
                print("The correct answer is \(correctSignKeyFromJokesArray)")
            }
        
        
        
        // IF USER WINS
        if usersSelectedAnswer == correctSignKeyFromJokesArray {
            
            // Append every win to streaks
            streaks.append("Win")
            
            //DispatchQueue.main.async {
                let correctAnswerSoundArray = ["CorrectAnswer1", "CorrectAnswer2", "CorrectAnswer3", "CorrectAnswer4", "CorrectAnswer5"]
                
                let randomCorrectAnswerSound = correctAnswerSoundArray.randomElement()!
            print(randomCorrectAnswerSound)
            
                self.playSound(soundName: randomCorrectAnswerSound, shouldLoop: false)
            //}
            
            
            // Once we get the correct answer, disable all buttons so users cannot click on mutiple buttons within the same round
            for button in answerButtons {
                button.isEnabled = false
            }
            
            
            let customeHighlightColor = UIColor(named: "OrangeHighlightGradient")
            sender.backgroundColor = customeHighlightColor
            sender.layer.cornerRadius = 18
            
            let confettiView = SAConfettiView(frame: self.view.bounds)
            self.view.addSubview(confettiView)
            
            // Start the confetti animation
            confettiView.startConfetti()
            
            // Tap into the main Disoatch Queue and update UI
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                
                
                
                // Stop confetti
                confettiView.stopConfetti()
                // Hide confetti
                confettiView.isHidden = true
                // Bring main vuew to front
                self.view.bringSubviewToFront(self.view)
                // Start new round
                self.newRound()
            }
            
            let winPrompt = UIAlertController(title: "Niceee Work!!!", message: "", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "Okay", style: .default)
            winPrompt.addAction(okayButton)
            present(winPrompt, animated: true)
            
            scoreLabelInt += 10
            scoreLabel.text = String(scoreLabelInt)
            
            print("Horray, you win!")
    
            
            
        // IF USER LOOSES
        } else {
            
            // Append every win to streaks
            streaks.append("Lose")
            
            let wrongAnswerSoundArray = ["WrongAnswer1", "WrongAnswer2", "WrongAnswer3", "WrongAnswer4"]
            
            let randomWrongAnswerSound = wrongAnswerSoundArray.randomElement()!
            
            
            
            
            DispatchQueue.main.async {
                self.playSound(soundName: randomWrongAnswerSound, shouldLoop: false)
                let customeHighlightColor = UIColor(named: "OrangeHighlightGradient")
                sender.backgroundColor = customeHighlightColor
                sender.layer.cornerRadius = 18
            }
            
            
            
            // Once we get the INcorrect answer, disable all buttons so users cannot click on mutiple buttons within the same round
            for button in answerButtons {
                button.isEnabled = false
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                self.newRound()
            }
            
            
            
            
            let losePrompt = UIAlertController(title: "Wrong! Step your game up", message: "", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default)
            losePrompt.addAction(okay)
            present(losePrompt, animated: true)
            
            scoreLabelInt -= 10
            scoreLabel.text = String(scoreLabelInt)
            
            print("Wrong answer bud!!")
            
        }
        
    }
    
    
    func newRound() {
        self.view.bringSubviewToFront(self.view)
        playSound(soundName: "WaitingForAnswerSound", shouldLoop: true)
        getRandomJoke()
        getAnswers()
        getHotStreaks(streak: streaks)
        gameOver(score: scoreLabel.text!)
        
    }
    
    
    // Creating a function with code needed to play the file
    func playSound(soundName: String, shouldLoop: Bool) {
        
        DispatchQueue.main.async {
            // Stop prervious sound
            self.player?.stop()
            
            // Setting are URL to equal the location of where our sound file is held
            let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
            print(url!)
            
            // Then we put the url file into our player
            self.player = try! AVAudioPlayer(contentsOf: url!)
            // Then we play the sound
            self.player.play()
            
            // Then we loop it
            if shouldLoop {
                self.player.numberOfLoops = -1
            }
        }
      
    }
    
    
    
    @IBAction func ballonPressed(_ sender: UIButton) {
        
        var scoreLabelInt = Int(scoreLabel.text!)!

            // BALLOON WILL REMOVE TWO INCORRECT ANSWERS TO HELP USER
            // BALLOON COSTS 5 POINTS

            // If the user has enough points (5 or more), then proceed
            if scoreLabelInt >= 10 {
                
                // Play baloon pop sound
                playSound(soundName: "PopSound", shouldLoop: false)
                
                // Remove 5 points
                scoreLabelInt -= 10
                
                // Update score label via String
                scoreLabel.text = String(scoreLabelInt)
                
                
                // Count th number of incorrect answers to remove
                var incorrectAnswersToRemove = 2

                
                // Loop throug the answerButtons and remove image for incorrect buttons
                for button in answerButtons {
                    if button.accessibilityIdentifier != correctSignKeyFromJokesArray {
                        print("Removing image for button: \(button.accessibilityIdentifier ?? "Unknown")")
                        // Setting the image to my "X.pdf" asset
                        button.setImage(UIImage(named: "X.pdf"), for: .normal)
                        
                        // Settinh the accessibilityIdentifier
                        button.accessibilityIdentifier = "X.pdf"
                        
                        // Now disabiling the 2 buttons associated with the X button so user cannot click on them
                        if button.accessibilityIdentifier == "X.pdf" {
                            button.isEnabled = false
                        }
                    
                        print(button)
                        
                        // Decrement count of incorrectAnswersToRemove
                        incorrectAnswersToRemove -= 1

                        // If we have removed the required number of incorrect buttons, break out ofthe loop
                        if incorrectAnswersToRemove == 0 {
                            break
                        }
                    }
                }

            
            } else {
                let notEnoughPointsAlert = UIAlertController(title: "Whoops! Not enough points", message: "The balloon button will remove two incorrect answers. You need at least 10 points to use this lifeline.", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default)
                notEnoughPointsAlert.addAction(okay)
                present(notEnoughPointsAlert, animated: true)
            }
        }
    

    
    
    // Cretaing function to call when user reaches 0 points - we will pass in the scoreLabel
    func gameOver(score: String) {
        
        if score == "0" {
            
            DispatchQueue.main.async {
                let gameOverAlert = UIAlertController(title: "GAME OVER", message: "Get em again nect time tiger!", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default)
                gameOverAlert.addAction(okay)
                self.present(gameOverAlert, animated: true)
                // set score back to 100
                self.scoreLabel.text = "100"
            }
        }
    }
    
    func getHotStreaks(streak: [String]){
        
        if !streak.contains("Lose") {
            
            newHotStreak = streak.count
            
            
            if newHotStreak > 1 {
                
                currentHotStreak = newHotStreak
                
            }
            
        } else {
            
            if currentHotStreak > 1 {
                
                hotStreaksCountTableViewArray.append(currentHotStreak)
                
            }
            
            // Empty the count container
            streaks = []
            // Set current streaks back to 0 again
            currentHotStreak = 0
           
        }
        
        
       
        
    }

    @IBAction func fireButtonPressed(_ sender: UIButton) {
        
        // When btn pressed we will go to the HotStreaksViewController
            let hotStreaksVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HotStreaksViewController") as! HotStreaksViewController
        hotStreaksVC.hotStreaksCountTableViewArray = hotStreaksCountTableViewArray
            self.present(hotStreaksVC, animated: true, completion: nil)
        
    }
    
    
    
    
}
