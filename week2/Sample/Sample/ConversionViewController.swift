//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view")
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date: NSDate = NSDate()
        print(date)
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        //let minute = calendar.component(.minute, from: date as Date)
        
        print("hour: \(hour)")
        
        if hour <= 5 || hour >= 20 {
            view.backgroundColor = UIColor.darkText
            print("dark")
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = NSCharacterSet.letters
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let existingTextHasLetters = string.rangeOfCharacter(from: characterSet)
        
        if existingTextHasLetters != nil {
            print(string)
            return false
        } else {
            if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        }
        
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
}
