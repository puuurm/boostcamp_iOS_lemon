//
//  PlayViewController.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var highRecordText: UILabel = UILabel()
    var highRecordTime: UILabel = UILabel()
    var timerLabel: UILabel = UILabel()
    var playButton: UIButton = UIButton()
    var playView: UIView = UIView()
    var homeButton: UIButton = UIButton()
    var historyButton: UIButton = UIButton()
    var twentyFiveButtons = [UIButton]()
    var twentyFiveButtonsStackView = UIStackView()
    var nameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    
    func makeView(){
        initHighRecordText()
        initHighRecordTime()
        initTimer()
        initPlayView()
        initPlayButton()
        initHomeButton()
        initHistoryButton()
        initNumberString()
    }
    func initHighRecordText() {
        highRecordText.text = "최고기록"
        highRecordText.textColor = UIColor.blue
        view.addSubview(highRecordText)
        highRecordText.translatesAutoresizingMaskIntoConstraints = false
        highRecordText.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        highRecordText.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    }
    
    func initHighRecordTime() {
        highRecordTime.text = "- --:--:--"
        highRecordTime.textColor = UIColor.blue
        view.addSubview(highRecordTime)
        highRecordTime.translatesAutoresizingMaskIntoConstraints = false
        highRecordTime.topAnchor.constraint(equalTo: highRecordText.bottomAnchor, constant: 5).isActive = true
        highRecordTime.leadingAnchor.constraint(equalTo: highRecordText.leadingAnchor).isActive = true
    }
    
    func initTimer() {
        timerLabel.text = "00:00:00"
        timerLabel.textColor = UIColor.blue
        timerLabel.font = timerLabel.font.withSize(20)
        view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 35).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    func initPlayView() {
        view.addSubview(playView)
        
        playView.translatesAutoresizingMaskIntoConstraints = false
        playView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        playView.widthAnchor.constraint(equalTo: playView.heightAnchor).isActive = true
        initTwentyFiveButtons()
        
    }
    
    func initPlayButton() {
        playButton.setTitle("PRESS TO START!!", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = UIColor.red
        playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(30)
        playButton.addTarget(self, action: #selector(PlayViewController.startGame(_:)), for: .touchUpInside)
        playView.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.topAnchor.constraint(equalTo: playView.topAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: playView.bottomAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: playView.leadingAnchor).isActive = true
        playButton.trailingAnchor.constraint(equalTo: playView.trailingAnchor).isActive = true
    
        
    }
    func initHomeButton() {
        homeButton.setTitle("HOME", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.backgroundColor = UIColor.red
        homeButton.titleLabel?.font = homeButton.titleLabel?.font.withSize(20)
        homeButton.addTarget(self, action: #selector(PlayViewController.showMainView(_:)), for: .touchUpInside)
        view.addSubview(homeButton)
        
        homeButton.titleLabel?.textAlignment = .center
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    func initHistoryButton() {
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor.red
        historyButton.titleLabel?.font = homeButton.titleLabel?.font.withSize(20)
        view.addSubview(historyButton)
        
        historyButton.titleLabel?.textAlignment = .center
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.topAnchor.constraint(equalTo: homeButton.topAnchor).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: homeButton.widthAnchor).isActive = true
    }
    
    func initTwentyFiveButtons() {
        twentyFiveButtonsStackView.axis = .vertical
        for _ in 0...4 {
            let stackView = UIStackView()
            twentyFiveButtonsStackView.addArrangedSubview(stackView)
            stackView.axis = .horizontal
            for _ in 0...4 {
                let button = UIButton()
                stackView.addArrangedSubview(button)
                button.setTitle("-", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.setTitleColor(.gray, for: .highlighted)
                button.backgroundColor = UIColor.blue
                button.titleLabel?.font = button.titleLabel?.font.withSize(10)
                button.addTarget(self, action: #selector(PlayViewController.hideNumberButton(_:)), for: .touchUpInside)
                twentyFiveButtons.append(button)
            }
            stackView.distribution = .fillEqually
            stackView.spacing = 5
        }
        
        twentyFiveButtonsStackView.distribution = .fillEqually
        twentyFiveButtonsStackView.spacing = 5
        playView.addSubview(twentyFiveButtonsStackView)
        twentyFiveButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        twentyFiveButtonsStackView.topAnchor.constraint(equalTo: playView.topAnchor).isActive = true
        twentyFiveButtonsStackView.bottomAnchor.constraint(equalTo: playView.bottomAnchor).isActive = true
        twentyFiveButtonsStackView.leadingAnchor.constraint(equalTo: playView.leadingAnchor).isActive = true
        twentyFiveButtonsStackView.trailingAnchor.constraint(equalTo: playView.trailingAnchor).isActive = true
    }
    var numberSet = [Int]()
    
    var timer = Timer()
    var seconds = 0
    
    func startGame(_ btControl: UIButton) {
        playButton.alpha = 0
        giveRandomNumber()
        runTimer()
    }
    func giveRandomNumber() {
        var index = 0
        while numberSet.count != 25 {
            let randomValue = Int(arc4random_uniform(25) + 1)
            if numberSet.contains(randomValue) {
                continue
            } else {
                twentyFiveButtons[index].setTitle("\(randomValue)", for: .normal)
                twentyFiveButtons[index].titleLabel?.font = twentyFiveButtons[index].titleLabel?.font.withSize(20)
                numberSet.append(randomValue)
                index += 1
            }
        }
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1/60, target: self,   selector: (#selector(PlayViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    func updateTimer()  {
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 3600
        let seconds = Int(time) / 60 % 60
        let interval = Int(time) % 60
        return String(format: "%02i:%02i:%02i", minutes, seconds, interval)
    }
    
    
    var currentNumber = [String]()
    var currentIndex = 0
    func initNumberString() {
        for number in 1...25 {
            let numberToString: String = "\(number)"
            currentNumber.append(numberToString)
        }
    }
    func hideNumberButton(_ btControl: UIButton) {
        if btControl.currentTitle == currentNumber[currentIndex] {
            btControl.isHighlighted = false
            btControl.alpha = 0
            currentIndex += 1
        }
        //btControl.showsTouchWhenHighlighted = false
        if currentIndex == 25 {
            currentIndex = 0
            timer.invalidate()
            playButton.alpha = 1
            let title = "Clear!"
            let message = "Enter your name"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
            
            //alertController.addTextField(configurationHandler: nil)
            //alertController.textFields = nameTextField
        }
    }
    
    func showMainView(_ btControl: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

