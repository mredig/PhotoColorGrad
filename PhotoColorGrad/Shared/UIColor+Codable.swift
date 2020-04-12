//
//  UIColor+Codable.swift
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

struct UIColorRep: Codable {
	let red: CGFloat
	let green: CGFloat
	let blue: CGFloat
	let alpha: CGFloat

	var color: UIColor {
		UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}

extension UIColor {
	var representation: UIColorRep {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return UIColorRep(red: red, green: green, blue: blue, alpha: alpha)
	}
}

