//
//  SquareSettingsViewController.swift
//  Squares
//
//  Created by Yarr!zzeR on 28/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SquareSettingsViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var enableNotificationSwitcher: UISwitch! {
        didSet{
            if enableNotificationSwitcher.isOn {
                datePicker.isEnabled = true
                countDownModeSwitcher.isEnabled = true
            } else {
                datePicker.isEnabled = false
                countDownModeSwitcher.isEnabled = false
            }
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var countDownModeSwitcher: UISwitch! {
        didSet{
            if countDownModeSwitcher.isOn {
                datePicker.datePickerMode = .countDownTimer
            } else {
                datePicker.datePickerMode = .dateAndTime
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        print("Saving changes here")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
