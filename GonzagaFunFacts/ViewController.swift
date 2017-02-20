//
//  ViewController.swift
//  GonzagaFunFacts
//
//  Created by Rudy Bermudez on 2/18/17.
//  Copyright © 2017 GUMAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	let factProvider = FactProvider()
	let colorProvider = ColorProvider()
	
	@IBOutlet weak var funFactLabel: UILabel!
	@IBOutlet weak var showFunFactButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateDisplay()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	@IBAction func buttonAction(_ sender: Any) {
		updateDisplay()
	}
	
	/** Updates the Display with a new color and a new fact
	The color is selected by random color from the `ColorProvider`
	The fact is pulled from the internet. If an error occurs, 
	the fact will be pulled from the list in the codebase
	
	*/
	func updateDisplay() {
		
		// Update the color of the view background and button text
		let randomColor = colorProvider.getRandomColor()
		self.view.backgroundColor = randomColor
		showFunFactButton.tintColor = randomColor
		
		// Attempt to update the factLabel with a fact from the internet
		factProvider.getRandomFactFromInternet { (result) in
			switch result {
				
			// If the request fails, error message is printed and fact is updated from codebase
			case .failure(let error):
				print(error)
				self.funFactLabel.text = self.factProvider.getRandomFactFromCodebase()
				
			// If request succeeds, the fact is updated with the fact from the internet
			case .success(let fact):
				self.funFactLabel.text = fact
			}
		}
	}
	
	
}

