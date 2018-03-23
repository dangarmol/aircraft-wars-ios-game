//
//  DragPlane.swift
//  Coursework Workspace
//
//  Created by Daniel García Molero on 23/03/2018.
//  Copyright © 2018 Daniel García Molero. All rights reserved.
//

import UIKit

class DragPlane: UIImageView {
    
    var startLocation: CGPoint? //Global variable and type (point in the screen).
    
    //var planeDelegate: subviewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //When touch begins, records the initial position.
        startLocation = touches.first?.location(in:self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //When touch moves, find the coordinates of the current touch and set the center position of the image.
        let currentLocation = touches.first?.location(in:self)
        let dx = currentLocation!.x - startLocation!.x
        
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y)
        
        //This function can be called thanks to the delegate
        //self.planeDelegate?.refreshCoordinates()
    }
    
}
