//
//  FactProvider.swift
//  Fun Faccts
//
//  Created by Rudy Bermudez on 2/18/17.
//  Copyright © 2017 Rudy Bermudez. All rights reserved.
//

import Foundation
import GameKit
import Alamofire

enum Result<T> {
	case success(T)
	case failure(Error)
}

public let JSONParsingErrorDomain = "club.gumad.GonzagaFunFacts.FactProvider"
public let JSONParsingError: Int = 10

struct FactProvider {
	
	/// List of facts that are returned from `getRandomFactFromCodebase`
	private let facts: [String] = [
		"Ants stretch when they wake up in the morning",
		"Ostriches can run faster than horses",
		"Olympic gold medals are actually made mostly of silver",
		"You are born with 300 bones; by the time you are an adult you will have 206",
		"It takes about 8 minutes for the light from the Sun to reach Earth",
		"Some bamboo plants can grow almost a meter in just one day",
		"The state of Florida is bigger than England",
		"Some penguins can leap 2-3 meters out of the water",
		"On average, it takes 66 days to form a new habit",
		"Mammoths still walked the Earth when the Great Pyramid was being built"
	
	]
	
	/// Returns an item from `fact` list at random
	func getRandomFactFromCodebase() -> String {
		let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: facts.count)
		return facts[randomNumber]
	}
	
	/** Uses Alamofire to make a request to the club server to retreive a new fact
	
	- Parameter completion: an escaping closure that returns the enum `Result` once the operation is complete.
	
	*/
	func getRandomFactFromInternet(completion: @escaping (Result<String>) -> Void) {
		
		Alamofire.request("https://api.gumad.club:55555").validate().responseJSON { (response) in
			
			switch response.result {
			
			case .success(let json):
				guard let JSON = json as? [String: Any], let fact = JSON["fact"] as? String else {
					print("Could not parse JSON")
					let error = NSError(domain: JSONParsingErrorDomain, code: JSONParsingError, userInfo: nil)
					completion(.failure(error))
					return
				}
				completion(.success(fact))
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
}
