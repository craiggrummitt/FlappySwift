//
//  Bird.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import ActionSwift3

public class Bird: MovieClip {
    private static let BOOSTER:int = 12
    private static let GRAVITY_COEFFICIENT:int = 1
    private static let MAX_GRAVITY:int = 5
    private static let ANGLE:int = 45
    
    private var currentVelocity:int = 0
    private var gravityOn = false
    public init() {
        super.init(textureNames: ["bird-1","bird-2","bird-3"], fps: 5)
        self.mouseEnabled = false
        self.addEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame,"enterFrame"))
    }
    public func reset() {
        self.rotation = 0
        self.width = Stage.stageWidth / 8
        self.scaleY = self.scaleX
        self.x = Stage.stageWidth * 0.2
        self.y = Stage.stageHeight * 0.3
    }
    public func turnGravityOn() {
        gravityOn = true
    }
    public func turnGravityOff() {
        gravityOn = false
    }
    public func turboBoost() {
        if (!gravityOn) {return}
        currentVelocity = -Bird.BOOSTER
    }
    private func enterFrame(event:Event) {
        if (!gravityOn) {return}
        currentVelocity += Bird.GRAVITY_COEFFICIENT
        if (currentVelocity > Bird.MAX_GRAVITY) {
            currentVelocity = Bird.MAX_GRAVITY
        }
        self.y+=Number(currentVelocity)
        if (currentVelocity < -5) {
            self.rotation = -Number(Bird.ANGLE)
        } else if (currentVelocity > 5) {
            self.rotation = Number(Bird.ANGLE)
        } else {
            self.rotation = 0
        }
    }
}