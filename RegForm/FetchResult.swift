//
//  FetchResult.swift
//  RegForm
//
//  Created by Alexander Volkov on 08/11/2019.
//  Copyright © 2019 Alexander Volkov. All rights reserved.
//

import UIKit
import CoreData

class FetchResult: UIViewController {
	
	@IBOutlet weak var deleteDesign: UIButton! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 18) else {
				fatalError("Can't load Proxima Nova font")
			}
			deleteDesign.titleLabel?.font = font
			deleteDesign.setTitle("Delete", for: .normal)
			deleteDesign.setTitleColor(.white, for: .normal)
			deleteDesign.backgroundColor = .systemBlue
			deleteDesign.layer.cornerRadius = deleteDesign.frame.width * 0.08
		}
	}
	
	@IBAction func deleteData(_ sender: UIButton) {
		let delegate = UIApplication.shared.delegate as! AppDelegate
		let context = delegate.persistentContainer.viewContext

		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
		do {
			let result = try context.fetch(fetchRequest)
			data = result as! [User]
		} catch {
			print(error.localizedDescription)
		}
		
		for user in data {
			context.delete(user)
		}
		
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	@IBOutlet weak var labelWelcome: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			labelWelcome.textColor = .lightGray;
			labelWelcome.font = font
			labelWelcome.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var name: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			name.textColor = .lightGray;
			name.font = font
			name.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var lasname: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			lasname.textColor = .lightGray;
			lasname.font = font
			lasname.adjustsFontSizeToFitWidth = true
		}
	}
	
	@IBOutlet weak var Date: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			Date.textColor = .lightGray;
			Date.font = font
			Date.adjustsFontSizeToFitWidth = true
		}
	}
	
	
	@IBOutlet weak var gender: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			gender.textColor = .lightGray;
			gender.font = font
			gender.adjustsFontSizeToFitWidth = true
		}
	}
	
	
	@IBOutlet weak var mail: UILabel! {
		didSet {
			guard let font = UIFont(name: "Proxima Nova", size: 20) else {
				fatalError("Can't load Proxima Nova font")
			}
			mail.textColor = .lightGray;
			mail.font = font
			mail.adjustsFontSizeToFitWidth = true
		}
	}
	
	var data: [User] = []
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let delegate = UIApplication.shared.delegate as! AppDelegate
		let context = delegate.persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
		do {
			let result = try context.fetch(fetchRequest)
			data = result as! [User]
		} catch {
			print(error.localizedDescription)
		}
		
		let lastUser = data.last!
		
		let usName: String! = lastUser.name!
		let usLastName: String! = lastUser.lastname!
		let usMail: String! = lastUser.mail!
		let usGender: String! = lastUser.gender!
		
		let dateForm = DateFormatter()
		
		dateForm.dateFormat = "dd-MM-yyyy"
		let usDate: String! = dateForm.string(from: lastUser.date!)
		
		name.text? += "\t\t\(usName!)"
		lasname.text? += "\t\t\(usLastName!)"
		mail.text? += "\t\t\(usMail!)"
		gender.text? += "\t\t\(usGender!)"
		Date.text? += "\t\t\(usDate!)"
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
