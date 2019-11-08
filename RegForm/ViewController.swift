//
//  ViewController.swift
//  RegForm
//
//  Created by Alexander Volkov on 08/11/2019.
//  Copyright © 2019 Alexander Volkov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var nameLabel: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			nameLabel.textColor = .lightGray;
			nameLabel.font = font
			nameLabel.adjustsFontSizeToFitWidth = true
		}
	}
	@IBOutlet weak var nameTextField: UITextField! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 24) else {
				fatalError("Can't load Proxima Nova font")
			}
			nameTextField.backgroundColor = .darkGray
			nameTextField.textColor = .white
			nameTextField.font = font
		}
	}
	@IBOutlet weak var lastNameLabel: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			lastNameLabel.textColor = .lightGray;
			lastNameLabel.font = font
			lastNameLabel.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var lastNameTextField: UITextField! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 24) else {
				fatalError("Can't load Proxima Nova font")
			}
			lastNameTextField.backgroundColor = .darkGray
			lastNameTextField.textColor = .white
			lastNameTextField.font = font
		}
	}
	
	
	@IBOutlet weak var genderLabel: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			genderLabel.textColor = .lightGray;
			genderLabel.font = font
			genderLabel.adjustsFontSizeToFitWidth = true
		}
	}
	
	
	@IBOutlet weak var dateLabel: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			dateLabel.textColor = .lightGray;
			dateLabel.font = font
			dateLabel.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var dateTextField: UITextField! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 24) else {
				fatalError("Can't load Proxima Nova font")
			}
			dateTextField.backgroundColor = .darkGray
			dateTextField.textColor = .white
			dateTextField.font = font
		}
	}
	
	@IBOutlet weak var mailLabel: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			mailLabel.textColor = .lightGray;
			mailLabel.font = font
			mailLabel.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var mailTextField: UITextField! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 24) else {
				fatalError("Can't load Proxima Nova font")
			}
			mailTextField.backgroundColor = .darkGray
			mailTextField.textColor = .white
			mailTextField.font = font
		}
	}
	
	@IBOutlet weak var saveButtonDesign: UIButton! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 18) else {
				fatalError("Can't load Proxima Nova font")
			}
			saveButtonDesign.titleLabel?.font = font
			saveButtonDesign.setTitle("Save", for: .normal)
			saveButtonDesign.setTitleColor(.white, for: .normal)
			saveButtonDesign.backgroundColor = .systemBlue
			saveButtonDesign.layer.cornerRadius = saveButtonDesign.frame.width * 0.08
		}
	}
	@IBOutlet weak var loadButtonDesign: UIButton! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 18) else {
				fatalError("Can't load Proxima Nova font")
			}
			loadButtonDesign.titleLabel?.font = font
			loadButtonDesign.setTitle("Load", for: .normal)
			loadButtonDesign.setTitleColor(.white, for: .normal)
			loadButtonDesign.backgroundColor = .systemBlue
			loadButtonDesign.layer.cornerRadius = loadButtonDesign.frame.width * 0.08
		}
	}
	
	@IBAction func loadAction(_ sender: UIButton) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
		do {
			let result = try context.count(for: fetchRequest)
			if result == 0 {
				let alert = UIAlertController(title: "Nothing to load", message: "Sorry, but the data you want to download does not exist", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "OK", style: .default))
				self.present(alert, animated: true, completion: nil)
			}
		} catch {
			print(error.localizedDescription)
		}
		
	}
	
	
	@IBOutlet weak var genderSeg: UISegmentedControl!
	
	@IBAction func saveAction(_ sender: UIButton) {
		var name: String? = nil
		var lastName: String? = nil
		var gender: String? = nil
		var date: Date? = nil
		var email: String? = nil
	
		if nameTextField.text?.isEmpty == true {
			animateError(view: nameTextField)
		} else {
			name = nameTextField.text!
		}
		
		if lastNameTextField.text?.isEmpty == true {
			animateError(view: lastNameTextField)
		} else {
			lastName = lastNameTextField.text!
		}
		
		if mailTextField.text?.isEmpty == true {
			animateError(view: mailTextField)
		} else {
			if mailTextField.text!.contains("@") == true {
				email = mailTextField.text!
			} else {
				animateError(view: mailTextField)
			}
		}
		
		if dateTextField.text?.isEmpty == true {
			animateError(view: dateTextField)
		} else {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd-MM-yyyy"
			date = dateFormatter.date(from: dateTextField.text!)
		}
		
		let index = genderSeg.selectedSegmentIndex
		gender = genderSeg.titleForSegment(at: index)!
		
		guard name != nil && lastName != nil && gender != nil && date != nil && email != nil else {
			return
		}
		
		let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
		let user = NSManagedObject(entity: entity!, insertInto: context) as! User
		
		user.name = name
		user.date = date
		user.mail = email
		user.gender = gender
		user.lastname = lastName
		
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	var selectedNow: UITextField!
	
	func animateError(view: UITextField) {
		
		UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
			view.backgroundColor = .systemRed
		}, completion: {(finish : Bool) in
			UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
				view.backgroundColor = .darkGray })})
	}
	
	var context: NSManagedObjectContext!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard context != nil else {
			fatalError("Context no found")
		}
		
		nameTextField.delegate = self
		lastNameTextField.delegate = self
		dateTextField.delegate = self
		mailTextField.delegate = self
		
		let toolBar = UIToolbar()
		toolBar.barStyle = .default
		toolBar.isTranslucent = true
		let buttonDateDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideDatePicker))
		toolBar.setItems([buttonDateDone], animated: false)
		toolBar.isUserInteractionEnabled = true
		toolBar.sizeToFit()
		
		let date = UIDatePicker()
		date.datePickerMode = .date
		date.addTarget(self, action: #selector(didChangeDate(_:)), for: .valueChanged)
		dateTextField.inputAccessoryView = toolBar
		dateTextField.inputView = date
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		NotificationCenter.default.addObserver(self, selector: #selector(didShowKey(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(didHideKey(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		selectedNow = textField
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text?.isEmpty == true {
			let animation = CAKeyframeAnimation(keyPath: "position")
			animation.values = [CGPoint(x: textField.frame.midX - 10, y: textField.frame.midY), CGPoint(x: textField.frame.midX + 10, y: textField.frame.midY), CGPoint(x: textField.frame.midX, y: textField.frame.midY)]
			animation.autoreverses = true
			animation.duration = 0.2
			textField.layer.add(animation, forKey: "position")
		}
	}
	
	@objc func hideDatePicker() {
		self.dateTextField.resignFirstResponder()
	}
	
	@objc func didChangeDate(_ date: UIDatePicker) {
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "dd-MM-yyyy"
		let string = dateFormat.string(from: date.date)
		dateTextField.text = string
	}
	
	@objc func didShowKey(_ notification: Notification) {
		guard let keyData = notification.userInfo else {
			fatalError("No userInfo")
		}
		guard let keyboardObj = keyData[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
			fatalError("Can't get keyboard frame")
		}
		let keyboardFrame = keyboardObj.cgRectValue
		if (self.view.frame.origin.y == 0 && selectedNow.frame.maxY > self.view.frame.maxY - keyboardFrame.height) {
			self.view.frame.origin.y -= keyboardFrame.height
		}
	}
	
	@objc func didHideKey(_ notification: Notification) {
		guard let keyData = notification.userInfo else {
			fatalError("No userInfo")
		}
		guard let keyboardObj = keyData[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
			fatalError("Can't get keyboard frame")
		}
		let keyboardFrame = keyboardObj.cgRectValue
		if (self.view.frame.origin.y != 0) {
			self.view.frame.origin.y += keyboardFrame.height
		}
	}
}

