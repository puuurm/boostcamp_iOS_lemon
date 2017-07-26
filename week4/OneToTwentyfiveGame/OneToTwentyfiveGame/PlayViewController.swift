//
//  PlayViewController.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    fileprivate var playView: UIView = UIView()
    fileprivate var twentyFiveButtons = [UIButton]()
    fileprivate var twentyFiveButtonsStackView = UIStackView()
    
    fileprivate var name: String?
    fileprivate var clearTime: String?
    open var recordBook: RecordBook!
    
    fileprivate var randomNumberSet = [Int]()
    fileprivate var timer = Timer()
    fileprivate var seconds = 0
    fileprivate var currentNumber = [String]()
    fileprivate var currentIndex = 0

    fileprivate lazy var highRecordText: UILabel = { [unowned self] in
        var highRecordText = UILabel()
        highRecordText.text = "최고기록"
        highRecordText.textColor = UIColor.blue
        return highRecordText
    }()
    
    fileprivate lazy var highRecordTime: UILabel = { [unowned self] in
        var highRecordTime = UILabel()
        highRecordTime.text = "- --:--:--"
        highRecordTime.textColor = UIColor.blue
        return highRecordTime
    }()
    
    fileprivate lazy var timerLabel: UILabel = { [unowned self] in
        var timerLabel = UILabel()
        timerLabel.text = "00:00:00"
        timerLabel.textColor = UIColor.blue
        timerLabel.font = timerLabel.font.withSize(20)
        return timerLabel
    }()
    
    fileprivate lazy var playButton: UIButton = { [unowned self] in
        var playButton = UIButton()
        playButton.setTitle("PRESS TO START!!", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = UIColor.red
        playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(30)
        playButton.addTarget(
            self,
            action: #selector(PlayViewController.startGame(_:)),
            for: .touchUpInside
        )
        return playButton
    }()
    
    fileprivate lazy var homeButton: UIButton = { [unowned self] in
        var homeButton = UIButton()
        homeButton.setTitle("HOME", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.backgroundColor = UIColor.red
        homeButton.titleLabel?.font = homeButton.titleLabel?.font.withSize(20)
        homeButton.addTarget(
            self,
            action: #selector(PlayViewController.showMainView(_:)),
            for: .touchUpInside
        )
        return homeButton
    }()
    
    fileprivate lazy var historyButton: UIButton = { [unowned self] in
        var historyButton = UIButton()
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
        historyButton.backgroundColor = UIColor.red
        historyButton.titleLabel?.font = historyButton.titleLabel?.font.withSize(20)
        historyButton.addTarget(
            self,
            action: #selector(PlayViewController.showHistory(_:)),
            for: .touchUpInside
        )
        return historyButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHighRecordText()
        initHighRecordTime()
        initTimer()
        initPlayView()
        initPlayButton()
        initHomeButton()
        initHistoryButton()
        initNumberString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        highRecordTime.text = recordBook.updateRecord()
    }
    
    private func initHighRecordText() {
        view.addSubview(highRecordText)
        highRecordText.translatesAutoresizingMaskIntoConstraints = false
        highRecordText.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        highRecordText.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    }
    
    private func initHighRecordTime() {
        view.addSubview(highRecordTime)
        highRecordTime.translatesAutoresizingMaskIntoConstraints = false
        highRecordTime.topAnchor.constraint(equalTo: highRecordText.bottomAnchor, constant: 5).isActive = true
        highRecordTime.leadingAnchor.constraint(equalTo: highRecordText.leadingAnchor).isActive = true
    }
    
    private func initTimer() {
        view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 35).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func initPlayView() {
        view.addSubview(playView)
        playView.translatesAutoresizingMaskIntoConstraints = false
        playView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        playView.widthAnchor.constraint(equalTo: playView.heightAnchor).isActive = true
        initTwentyFiveButtons()
    }
    
    private func initPlayButton() {
        playView.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.topAnchor.constraint(equalTo: playView.topAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: playView.bottomAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: playView.leadingAnchor).isActive = true
        playButton.trailingAnchor.constraint(equalTo: playView.trailingAnchor).isActive = true
    }
    
    private func initHomeButton() {
        view.addSubview(homeButton)
        homeButton.titleLabel?.textAlignment = .center
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func initHistoryButton() {
        view.addSubview(historyButton)
        historyButton.titleLabel?.textAlignment = .center
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.topAnchor.constraint(equalTo: homeButton.topAnchor).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: homeButton.widthAnchor).isActive = true
    }
    
    private func initTwentyFiveButtons() {
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
                button.addTarget(
                    self,
                    action: #selector(PlayViewController.numberButtonDidHide(_:)),
                    for: .touchUpInside
                )
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
    
    private func initNumberString() {
        for number in 1...25 {
            let numberToString: String = "\(number)"
            currentNumber.append(numberToString)
        }
    }
    
}

extension PlayViewController {
    
    @objc fileprivate func startGame(_ btControl: UIButton) {
        historyButton.isEnabled = false
        //historyButton.titleLabel?.alpha = 0.5
        seconds = 0
        playButton.alpha = 0
        giveRandomNumber()
        runTimer()
    }
    
    @objc fileprivate func numberButtonDidHide(_ btControl: UIButton) {
        if btControl.currentTitle == currentNumber[currentIndex] {
            btControl.isHighlighted = false
            btControl.alpha = 0
            currentIndex += 1
        }
        if currentIndex == 25 {
            currentIndex = 0
            timer.invalidate()
            self.clearTime = timerLabel.text
            playButton.alpha = 1
            let title = "Clear!"
            let message = "Enter your name"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertController.addTextField (configurationHandler: { (textField : UITextField!) -> Void in })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
                self.name = alertController.textFields?[0].text
                guard let nameValue = self.name,
                    let clearTimeValue = self.clearTime else {
                        return
                }
                self.recordBook.createRecord(name: nameValue, clearTiem: clearTimeValue)
                self.highRecordTime.text = self.recordBook.updateRecord()
                self.historyButton.isEnabled = true
                //self.historyButton.titleLabel?.alpha = 1
            })
            alertController.addAction(ok)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func updateTimer()  {
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @objc fileprivate func showMainView(_ btControl: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func showHistory(_ btControl: UIButton) {
        performSegue(withIdentifier: "GameToHistory", sender: btControl)
    }
}

extension PlayViewController {
    
    fileprivate func giveRandomNumber() {
        var index = 0
        while randomNumberSet.count != 25 {
            let randomValue = Int(arc4random_uniform(25) + 1)
            if randomNumberSet.contains(randomValue) {
                continue
            } else {
                twentyFiveButtons[index].alpha = 1
                twentyFiveButtons[index].setTitle("\(randomValue)", for: .normal)
                twentyFiveButtons[index].titleLabel?.font = twentyFiveButtons[index].titleLabel?.font.withSize(20)
                randomNumberSet.append(randomValue)
                
                index += 1
            }
        }
        randomNumberSet.removeAll()
    }
    
    fileprivate func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1/60, target: self,   selector: (#selector(PlayViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    fileprivate func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 3600
        let seconds = Int(time) / 60 % 60
        let interval = Int(time) % 60
        return String(format: "%02i:%02i:%02i", minutes, seconds, interval)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "GameToHistory"?:
            let destinationController = segue.destination as! RecordsViewController
            destinationController.recordBook = self.recordBook
            print("pass recordBook")
            print(recordBook.allRecords.count)
        default: break
        }
    }
}

