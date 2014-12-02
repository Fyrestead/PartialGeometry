//
//  SCNGeometry.swift
//
//  Created by Shon Frazier on 11/22/14.
//  Copyright (c) 2014 Fyrestead, LLC. All rights reserved.
//
//  Licensed under The BSD 3-Clause License ( http://opensource.org/licenses/BSD-3-Clause )
//  See accompanying LICENSE file

import Foundation
import SceneKit

let allSemantics = [
	SCNGeometrySourceSemanticVertex,
	SCNGeometrySourceSemanticNormal,
	SCNGeometrySourceSemanticColor,
	SCNGeometrySourceSemanticTexcoord,
	SCNGeometrySourceSemanticVertexCrease,
	SCNGeometrySourceSemanticEdgeCrease,
	SCNGeometrySourceSemanticBoneWeights,
	SCNGeometrySourceSemanticBoneIndices
]


extension SCNGeometry {
	
	func geometryForRangeOfPrimitives(range: NSRange) -> SCNGeometry? {
		
		var primitiveType: SCNGeometryPrimitiveType
		
		var allElements: [SCNGeometryElement] = [SCNGeometryElement]()
		
		for i in 0..<self.geometryElementCount {
			let element = self.geometryElementAtIndex(i)
			if element == nil {
				continue
			}
			
			var newElement = element!.geometryElementForRangeOfPrimitives(range)
			
			if newElement != nil {
				allElements += [newElement!]
			}
		}
		
		
		var allSources: [SCNGeometrySource] = [SCNGeometrySource]()
		
		for semantic in allSemantics {
			var sources = self.geometrySourcesForSemantic(semantic)
			if sources == nil {
				continue
			}
			
			for source in sources! as [SCNGeometrySource] {
				var range: NSRange = NSRange(location: 0, length: 5)
				
				let newSource = source.geometrySourceForRangeOfPrimitives(range, primitiveType: SCNGeometryPrimitiveType.TriangleStrip)
				
				allSources += [newSource!]
			}
		}
		
		
		var newGeometry = SCNGeometry(sources: allSources, elements: allElements)
		newGeometry.materials = materials
		
		return newGeometry
	}
}
