//
//  ViewController.swift
//  GonzagaFunFacts
//
//  Created by Rudy Bermudez on 2/18/17.
//  Copyright © 2017 GUMAD. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
	
	
	let factProvider = FactProvider()
	let colorProvider = ColorProvider()
	
	@IBOutlet weak var funFactLabel: UILabel!
	@IBOutlet weak var showFunFactButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getRandomFact()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	@IBAction func buttonAction(_ sender: Any) {
		getRandomFact()
	}
	
	func getRandomFact() {
		
		// Update the color of the view background and button text
		let randomColor = colorProvider.getRandomColor()
		self.view.backgroundColor = randomColor
		showFunFactButton.tintColor = randomColor
		
		
		// This is how we get facts from our web server
		Alamofire.request("https://api.gumad.club:55555").validate().responseJSON { (response) in
			/*
			Note: This is not the best way of making a request nor is it the best place to put a request.
			View Controllers are meant for updating data for the Views. It is not the best place to be
			making HTTP Requests. In later sessions we will explore how to do this properly and we will
			write our own Request library.
			
			For now this works...
			*/
			switch response.result {
			case .success(let json):
				guard let JSON = json as? [String: Any], let fact = JSON["fact"] as? String else {
					print("Could not parse JSON")
					return
				}
				self.funFactLabel.text = fact
			case .failure(let error):
				print(error)
				
				// Get a Fact from the factbook in the codebase
				self.funFactLabel.text = self.factProvider.getRandomFact()
			}
		}
	}
	
	
}

