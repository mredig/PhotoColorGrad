//
//  DefaultsManager.swift
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

/// Protocol definition
@objc protocol DefaultValueSupplier {
	var gradientHistory: [[UIColor]] { get set }
}

/// Live App implementation
@objc class DefaultWrapper: NSObject, DefaultValueSupplier {
	private let defaults = UserDefaults.standard

	@objc var gradientHistory: [[UIColor]] {
		get {
			guard let data = defaults.object(forKey: .gradientHistoryKey) as? Data else { return [] }
			guard let colorReps = try? PropertyListDecoder().decode([[UIColorRep]].self, from: data) else { return [] }
			return colorReps.map { $0.map { $0.color } }
		}
		set {
			let reps = newValue.map { $0.map { $0.representation } }
			guard let repData = try? PropertyListEncoder().encode(reps) else { return }
			defaults.set(repData, forKey: .gradientHistoryKey)
		}
	}

	@objc static let shared = DefaultWrapper()

	private override init() {}
}

fileprivate extension String {
	static let gradientHistoryKey = "GradientHistoryKey"
}
