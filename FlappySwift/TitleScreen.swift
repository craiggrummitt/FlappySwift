//
//  TitleScreen.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import ActionSwift3

public class TitleScreen: MovieClip {
    private var title:TextField
    private var instructions:TextField
    public init() {
        title = TextField()
        instructions = TextField()
        
        super.init(textureNames: [], fps: 1)
        
        title.width = Stage.stageWidth
        title.y = Stage.stageHeight * 0.2
        title.mouseEnabled = false
        self.addChild(title)
    
        
        instructions.width = Stage.stageWidth
        instructions.y = Stage.stageHeight * 0.5
        instructions.mouseEnabled = false
        self.addChild(instructions)
    }
    public func changeTitle(title1:String,title2:String) {
        title.text = title1
        
        var textFormat = TextFormat()
        textFormat.font = "ChalkboardSE-Regular"
        textFormat.align = .Center
        textFormat.color = UIColor(hex: "#FFFFFF")
        textFormat.size = 40
        
        title.defaultTextFormat=textFormat
        
        instructions.text = title2
        textFormat.size = 30
        instructions.defaultTextFormat = textFormat
    }
}
