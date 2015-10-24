//
//  FlappyBird.swift
//  FlappySwift
//
//  Created by Craig on 8/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import ActionSwift3

public class FlappyBird: MovieClip {
    private var bg:MovieClip
    private var ground:Ground
    private var titleScreen:TitleScreen
    private var bird:Bird
    private var game:Game?
    init() {
        bg = MovieClip(textureNames: ["bg16x9.png"], fps: 1)
        bg.name = "BG"
        ground = Ground()
        ground.name = "Ground"
        titleScreen = TitleScreen()
        titleScreen.name = "Title screen"
        bird = Bird()
        bird.name = "Bird"
        
        super.init(textureNames: [], fps: 1)
        
        bg.width = Stage.stageWidth
        bg.height = Stage.stageHeight
        print("\(bg.width)\(bg.height)")

        self.addChild(bg)
        
        self.addChild(ground)
        ground.animate()
        
        self.addChild(bird)
    }
    public func setUpTitleScreen() {
        bird.reset()
        self.addChild(titleScreen)
        titleScreen.changeTitle("FLASHY BIRD", title2: "Tap to start")
        stage?.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapTitleScreen,"tapTitleScreen"))
    }
    
    private func tapTitleScreen(event:Event) {
        print("Tap title screen bird.y = \(bird.y), Num children = \(self.numChildren)")
        stage?.removeEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapTitleScreen,"tapTitleScreen"))
        self.removeChild(titleScreen)
        game = Game(bird: bird, ground: ground)
        self.addChild(game!)
        game!.go()
        game!.addEventListener(Game.GAME_OVER,EventHandler(gameOver,"gameOver"))
    }
    private func gameOver(event:Event) {
        bird.turnGravityOff()
        ground.stopAnimate()
        if let game = game {
            game.removeEventListener(Game.GAME_OVER,EventHandler(gameOver,"gameOver"))
        }
        titleScreen.changeTitle("GAME OVER", title2: "Tap to continue")
        self.addChild(titleScreen)
        stage?.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapGameOverScreen,"tapGameOverScreen"))
    }
    private func tapGameOverScreen(event:Event) {
        if let game = game {
            game.removeTubes()
            removeChild(game)
        }
        stage?.removeEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(tapGameOverScreen,"tapGameOverScreen"))
        ground.animate()
        setUpTitleScreen()
    }
}