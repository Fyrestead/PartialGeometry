//
//  SCNGeometrySource.swift
//
//  Created by Shon Frazier on 11/23/14.
//  Copyright (c) 2014 Fyrestead, LLC. All rights reserved.
//
//  Licensed under The BSD 3-Clause License ( http://opensource.org/licenses/BSD-3-Clause )
//  See accompanying LICENSE file

import Foundation
import SceneKit

extension SCNGeometrySource {
	
	/* Preserves use of existing data buffer by changing only the offset */
	func geometrySourceForRangeOfVectors(range: NSRange) -> SCNGeometrySource? {
		
		if data == nil {
			return nil
		}
		
		let newOffset = dataOffset + range.location * (dataStride + bytesPerComponent * componentsPerVector)
		
		return SCNGeometrySource(
			data: data!,
			semantic: semantic,
			vectorCount: range.length,
			floatComponents: floatComponents,
			componentsPerVector: componentsPerVector,
			bytesPerComponent: bytesPerComponent,
			dataOffset: newOffset,
			dataStride: dataStride)
	}
	
	func geometrySourceForRangeOfPrimitives(range: NSRange, primitiveType: SCNGeometryPrimitiveType) -> SCNGeometrySource? {
		
		var newGSource: SCNGeometrySource?
		
		switch primitiveType {
		case .TriangleStrip, .Point:
			newGSource = geometrySourceForRangeOfVectors(range)
			
		case .Triangles:
			let newRange = NSRange(location: range.location * 3, length: range.length * 3)
			newGSource = geometrySourceForRangeOfVectors(newRange)
			
		case .Line:
			let newRange = NSRange(location: range.location * 2, length: range.length * 2)
			newGSource = geometrySourceForRangeOfVectors(newRange)
		}
		
		return newGSource
	}
	
}
