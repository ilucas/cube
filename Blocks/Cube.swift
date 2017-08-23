//
//  Cube.swift
//  Blocks
//
//  Created by Lucas Casteletti on 23/08/17.
//  Copyright © 2017 Lucas Casteletti. All rights reserved.
//

import Foundation
import SceneKit

class Cube: SCNScene {

    lazy var lightNode: SCNNode = { node in
        node.light = SCNLight()
        node.light!.type = .omni
        node.position = SCNVector3(x: 0, y: 10, z: 10)
        return node
    }(SCNNode())

    lazy var ambientLightNode: SCNNode = { node in
        node.light = SCNLight()
        node.light?.type = .ambient
        node.light?.color = UIColor.darkGray
        return node
    }(SCNNode())

    lazy var cameraNode: SCNNode = { node in
        node.camera = SCNCamera()
        node.position = SCNVector3(x: 0, y: 12, z: 30)
        node.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -sin(12.0/30.0))
        return node
    }(SCNNode())

    override init() {
        super.init()

        // create and add a light to the scene
        rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        rootNode.addChildNode(ambientLightNode)
        rootNode.addChildNode(cameraNode)

        // cube

        let cubeSide: Float = 15.0
        let halfSide: Float = cubeSide / 2.0

        let vertices: [SCNVector3] = [
            SCNVector3(x: -halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: -halfSide),

            // repeat exactly the same
            SCNVector3(x: -halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: -halfSide),

            // repeat exactly the same
            SCNVector3(x: -halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: -halfSide, z: -halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: halfSide),
            SCNVector3(x: -halfSide, y: halfSide, z: -halfSide),
            SCNVector3(x: halfSide, y: halfSide, z: -halfSide),
            ]

        let normals: [SCNVector3] = [
            // UP
            SCNVector3(x: 0, y: -1, z: 0),
            SCNVector3(x: 0, y: -1, z: 0),
            SCNVector3(x: 0, y: -1, z: 0),
            SCNVector3(x: 0, y: -1, z: 0),

            // Down
            SCNVector3(x: 0, y: 1, z: 0),
            SCNVector3(x: 0, y: 1, z: 0),
            SCNVector3(x: 0, y: 1, z: 0),
            SCNVector3(x: 0, y: 1, z: 0),

            // Back
            SCNVector3(x: 0, y: 0, z: 1),
            SCNVector3(x: 0, y: 0, z: 1),
            SCNVector3(x: 0, y: 0, z: -1),
            SCNVector3(x: 0, y: 0, z: -1),

            // Front
            SCNVector3(x: 0, y: 0, z: 1),
            SCNVector3(x: 0, y: 0, z: 1),
            SCNVector3(x: 0, y: 0, z: -1),
            SCNVector3(x: 0, y: 0, z: -1),

            // Left
            SCNVector3(x: -1, y: 0, z: 0),
            SCNVector3(x: 1, y: 0, z: 0),
            SCNVector3(x: -1, y: 0, z: 0),
            SCNVector3(x: 1, y: 0, z: 0),

            // Right
            SCNVector3(x: -1, y: 0, z: 0),
            SCNVector3(x: 1, y: 0, z: 0),
            SCNVector3(x: -1, y: 0, z: 0),
            SCNVector3(x: 1, y: 0, z: 0)
        ]

        let UVs: [CGPoint] = [
            // Bottom
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0),
            CGPoint(x: 0, y: 1),
            CGPoint(x: 0, y: 1),

            // Top
            CGPoint(x: 0, y: 1),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0),

            CGPoint(x: 0, y: 1),// Front
            CGPoint(x: 1, y: 1),// Front
            CGPoint(x: 1, y: 1),// Back
            CGPoint(x: 0, y: 1),// Back

            CGPoint(x: 0, y: 0),// Front
            CGPoint(x: 1, y: 0),// Front
            CGPoint(x: 1, y: 0),// Back
            CGPoint(x: 0, y: 0),// Back

            CGPoint(x: 1, y: 1),// Left
            CGPoint(x: 0, y: 1),// Right
            CGPoint(x: 0, y: 1),// Left
            CGPoint(x: 1, y: 1),// Right

            CGPoint(x: 1, y: 0),// Left
            CGPoint(x: 0, y: 0),// Right
            CGPoint(x: 0, y: 0),// Left
            CGPoint(x: 1, y: 0),// Right
        ]

        let solidIndices: [UInt8] = [
            // bottom
            0, 2, 1,
            1, 2, 3,
            // back
            10, 14, 11,  // 2, 6, 3,   + 8
            11, 14, 15,  // 3, 6, 7,   + 8
            // left
            16, 20, 18,  // 0, 4, 2,   + 16
            18, 20, 22,  // 2, 4, 6,   + 16
            // right
            17, 19, 21,  // 1, 3, 5,   + 16
            19, 23, 21,  // 3, 7, 5,   + 16
            // front
            8,  9, 12,  // 0, 1, 4,   + 8
            9, 13, 12,  // 1, 5, 4,   + 8
            // top
            4, 5, 6,
            5, 7, 6
        ]

        let lineIndices: [UInt8] = [
            // bottom
            0, 1,
            0, 2,
            1, 3,
            2, 3,
            // top
            4, 5,
            4, 6,
            5, 7,
            6, 7,
            // sides
            0, 4,
            1, 5,
            2, 6,
            3, 7,
            // diagonals
            0, 5,
            1, 7,
            2, 4,
            3, 6,
            1, 2,
            4, 7
        ]

        // Custom Object
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let normalSource = SCNGeometrySource(normals: normals)
        let uvSource = SCNGeometrySource(textureCoordinates: UVs)

        let soliceIndexData = Data(bytes: solidIndices)
        let lineIndexData = Data(bytes: lineIndices)

        // Create one element for the triangles and one for the lines
        // using the two different buffers defined above
        let solidElement = SCNGeometryElement(data: soliceIndexData,
                                              primitiveType: .triangles,
                                              primitiveCount: 12,
                                              bytesPerIndex: MemoryLayout<UInt8>.size)

        let lineElement = SCNGeometryElement(data: lineIndexData,
                                             primitiveType: .line,
                                             primitiveCount: 12,
                                             bytesPerIndex: MemoryLayout<UInt8>.size)

        // Create a geometry object from the sources and the two elements
        let geometry = SCNGeometry(sources: [vertexSource, normalSource, uvSource],
                                   elements: [solidElement, lineElement])

        // Give the cube a light blue colored material for the solid part ...
        let solidMaterial = SCNMaterial()
        solidMaterial.diffuse.contents = UIColor.blue
        solidMaterial.locksAmbientWithDiffuse = true

        let lineMaterial = SCNMaterial()
        lineMaterial.diffuse.contents = UIColor.white
        lineMaterial.lightingModel = .constant

        geometry.materials = [solidMaterial, lineMaterial]

        let cubeNode = SCNNode(geometry: geometry)
        rootNode.addChildNode(cubeNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
