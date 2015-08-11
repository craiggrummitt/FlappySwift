//
//  Game.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import SpriteKit
import ActionSwift3

public class Game: MovieClip {
    public static let TUBE_EVERY:int = 100
    public static let GAME_OVER:String = "gameOver"
    //display objects
    private var bird:Bird
    private var ground:Ground
    private var tubes:[Tube]
    private var scoreTextField:TextField
    private var textFormat:TextFormat
    //vars
    public var score:int
    private var count:int
    //audio files
    private var hit:Sound?
    private var point:Sound?
    private var swoosh:Sound?
    private var wing:Sound?
    
    init(bird:Bird,ground:Ground) {
        self.bird = bird
        self.ground = ground
        
        tubes = []
        scoreTextField = TextField()
        textFormat = TextFormat()
        
        count = 0
        score = 0
        
        super.init(textureNames: [], fps: 1)
        
        bird.turnGravityOn()
        bird.turboBoost()

        self.addEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame,"enterFrame"))
        
        setupScore()
        
        swoosh = Sound(name: "sfx_swooshing.mp3")
        swoosh!.play()
    }
    public func go() {
        if let stage = stage {
            stage.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapScreen,"tapScreen"))
        }
    }
    private func setupScore() {
        
        scoreTextField.width = Stage.stageWidth
        scoreTextField.y = Stage.stageHeight * 0.1
        scoreTextField.mouseEnabled = false
        self.addChild(scoreTextField)
        
        
        textFormat.font = "ChalkboardSE-Regular"
        textFormat.align = .Center
        textFormat.color = UIColor(hex: "#FFFFFF")
        textFormat.size = 50
        
        scoreTextField.text = "0"
        scoreTextField.defaultTextFormat=textFormat
    }
    private func tapScreen(event:Event) {
        bird.turboBoost()
        wing = Sound(name: "sfx_wing.mp3")
        wing!.play()
    }
    private func enterFrame(event:Event) {
        var tube:Tube
        //add a tube if it's time
        count++
        if (count > Game.TUBE_EVERY) {
            count = 0
            tube = Tube()
            tubes.append(tube)
            self.addChild(tube)
        }
        //Move the tubes
        for (var i = tubes.count-1;i>=0;i--) {
            tube = tubes[i]
            tube.x -= Number(Ground.SPEED)
            //if moved off screen, remove
            if (tube.x + tube.width < 0) {
                self.removeChild(tube)
                tubes.removeAtIndex(i)
                score++
                scoreTextField.text = String(score)
                scoreTextField.defaultTextFormat = textFormat
                point = Sound(name:"sfx_point.mp3")
                point!.play()
                //did the bird make it past the tube?
            } else if (tube.x < bird.x - (bird.width / 2) &&
                    tube.x + tube.width > bird.x + (bird.width / 2) &&
                    ((bird.y - (bird.height / 2)) < Number(tube.randomGapBeginning) ||
                    (bird.y + (bird.height / 2)) > Number(tube.randomGapBeginning + tube.gapHeight))) {
                        //oops - the birdy didn't make it through the tubes!
                        self.gameOver()
            }
        
        }
        //Has the bird hit the ground?
        if (bird.y + (bird.height * 0.3) > ground.y) {
            bird.y = ground.y - (bird.height * 0.3)
            println("GAME OVER 2 bird.y = \(bird.y),bird.height = \(bird.height),ground.y = \(ground.y)")
            self.gameOver()
        }
    }
    func gameOver() {
        hit = Sound(name: "sfx_hit.mp3")
        hit!.play()
        
        self.dispatchEvent(Event(Game.GAME_OVER))
        self.removeEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame,"enterFrame"))
        stage?.removeEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapScreen,"tapScreen"))
    }
    public func removeTubes() {
        //remove all tubes
        for (var i:int = tubes.count - 1;i>=0;i--) {
                var tube:Tube = tubes[i]
                self.removeChild(tube)
        }
        tubes=[]
    }
}
