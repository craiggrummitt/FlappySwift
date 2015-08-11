//
//  Ground.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import ActionSwift3

public class Ground: MovieClip {
    public static let SPEED:int = 6
    public var ground:MovieClip
    init() {
        ground = MovieClip(textureNames: ["ground"], fps: 1)
        
        super.init(textureNames: [], fps: 1)
        
        ground.width = Stage.stageWidth * (14/12)
        ground.scaleY = ground.scaleX
        self.y = Stage.stageHeight * 788/922
        self.addChild(ground)
    }
    public func animate() {
        self.addEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame,"enterFrame"))
    }
    public func stopAnimate() {
        self.removeEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame,"enterFrame"))
    }
    private func enterFrame(event:Event) {
        ground.x -= Number(Ground.SPEED)
        if (ground.x <= -Stage.stageWidth * 2/12) {
            ground.x = 0
        }
    }
}
/*


public class Ground extends MovieClip {




}

}
*/