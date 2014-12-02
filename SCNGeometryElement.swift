//
//  SCNGeometryElement.swift
//
//  Created by Shon Frazier on 11/23/14.
//  Copyright (c) 2014 Fyrestead, LLC. All rights reserved.
//
//  Licensed under The BSD 3-Clause License ( http://opensource.org/licenses/BSD-3-Clause )
//  See accompanying LICENSE file

import Foundation
import SceneKit

extension SCNGeometryElement {
	
	func geometryElementForRangeOfPrimitives(range: NSRange) -> SCNGeometryElement? {
		
		if data == nil {
			return nil
		}
		
		let newCount = range.length
		let newLocation = range.location * bytesPerIndex
		let newLength = range.length * bytesPerIndex
		let newRange = NSRange(location: newLocation, length: newLength)
		let newData = data!.subdataWithRange(newRange)
		
		let newElement = SCNGeometryElement(
			data: newData,
			primitiveType: primitiveType,
			primitiveCount: newCount,
			bytesPerIndex: bytesPerIndex
		)
		
		return newElement
	}
	
}
