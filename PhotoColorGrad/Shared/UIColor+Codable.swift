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

	@objc var hexString: String {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)

		let rInt = UInt32(red * 255)
		let gInt = UInt32(green * 255)
		let bInt = UInt32(blue * 255)
		let aInt = UInt32(alpha * 255)
		let total = (rInt << 24) | (gInt << 16) | (bInt << 8) | aInt

		return String(total, radix: 16).uppercased()
	}
}

