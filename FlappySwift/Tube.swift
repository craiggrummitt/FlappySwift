//
//  Tube.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import ActionSwift3

public class Tube: MovieClip {
    private var tubeTop:MovieClip
    private var tubeBottom:MovieClip
    public var randomGapBeginning:int = 0
    public var gapHeight:int = 0
    init() {
        tubeBottom = MovieClip(textureNames: ["tube1"], fps: 1)
        tubeTop = MovieClip(textureNames: ["tube2"], fps: 1)
        
        super.init(textureNames: [], fps: 1)
        
        self.mouseEnabled = false
        
        tubeBottom.width = Stage.stageWidth * 0.2
        tubeBottom.scaleY = tubeBottom.scaleX
        self.addChild(tubeBottom)
        
        
        tubeTop.width = Stage.stageWidth * 0.2
        tubeTop.scaleY = tubeTop.scaleX
        self.addChild(tubeTop)
        
        self.gapHeight = int(Stage.stageHeight * 0.27)
        var possibleGapBeginning:int = int(Stage.stageHeight * 0.2)
        var possibleGapEnd:int = int(Stage.stageHeight * 0.7)

        self.randomGapBeginning = possibleGapBeginning + int(arc4random_uniform(UInt32(possibleGapEnd - possibleGapBeginning - self.gapHeight)))
        tubeTop.y = CGFloat(randomGapBeginning - int(tubeTop.height))
        tubeBottom.y = CGFloat(randomGapBeginning + int(gapHeight))
        
        self.x = Stage.stageWidth
    }
    override public var width:CGFloat {
        get {
            return tubeTop.width
        }
        set(newValue) {
            println("DO NOT DO THIS!")
        }
    }
}