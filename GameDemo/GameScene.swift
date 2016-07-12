//
//  GameScene.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/4/16.
//  Copyright (c) 2016 Altynai Orynbaeva. All rights reserved.
//

import SpriteKit

enum Player:Int{
    case Player1 = 1,Player2

}

class GameScene: SKScene {
    
    var currentSpacePlayer1:String = "A0"
    var currentSpacePlayer2:String = "A0"
    
    var moves:Int = 4
    var movesRemaining:Int = 4
    var whosTurn:Player = .Player1
    
    var player1Piece:SKSpriteNode = SKSpriteNode()
    var player2Piece:SKSpriteNode = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        for node in children {
            
            if node.name == "Player1Piece"{
                if let someNode:SKSpriteNode = node as? SKSpriteNode{
                    player1Piece = someNode
                
                }
            
            } else if node.name == "Player2Piece" {
                
                if let someNode:SKSpriteNode = node as? SKSpriteNode {
                    
                    player2Piece = someNode
                    
                }
                
                
            }
        
        
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
            movesRemaining = moves
        movePiece()
    }
    func movePiece(){
        
        
        if ( movesRemaining > 0) {
            
            let currentSpace:String = returnPlayerSpace(whosTurn)
            
            var spaceNumber:String = currentSpace
            let firstCharacter:Character = spaceNumber.removeAtIndex( spaceNumber.startIndex)
            
            let nextNumber:Int = Int(spaceNumber)! + 1
            let nextSpace:String = String(firstCharacter) + String(nextNumber)
            
            for node in children {
                
                if (node.name == nextSpace) {
                    
                    let moveAction:SKAction = SKAction.moveTo(node.position, duration: 0.5)
                    moveAction.timingMode = .EaseOut
                    let wait:SKAction = SKAction.waitForDuration(0.2)
                    
                    let runAction:SKAction = SKAction.runBlock {
                        
                        self.setThePlayerSpace(nextSpace, player:self.whosTurn)
                        self.movesRemaining = self.movesRemaining - 1
                        
                        //In the kit here we would do things like check the space for particular properties
                        //i.e.   Do we draw a card, do we get money, do we win, do we lose a turn
                        
                        self.movePiece()
                        
                    }
                    
                    returnPlayerPiece(whosTurn).runAction( SKAction.sequence( [moveAction, wait, runAction]  ) )
                    
                    
                }
            }
            
            
        } else {
            
            // next players turns
            
            if (whosTurn == .Player1) {
                
                whosTurn = .Player2
            } else {
                
                whosTurn = .Player1
            }
            
            
            
        }
    
    
    
    }
    
    func returnPlayerPiece (player:Player ) -> SKSpriteNode {
        
        var playerPiece:SKSpriteNode = SKSpriteNode()
        
        
        if (player == .Player1) {
            
            playerPiece = player1Piece
            
            
        } else if (player == .Player2) {
            
            playerPiece = player2Piece
        }
        
        
        return playerPiece
    }
    
    func setThePlayerSpace(space:String, player:Player) {
        
        
        if (player == .Player1) {
            
            currentSpacePlayer1 = space
            
            
        } else if (player == .Player2) {
            
            currentSpacePlayer2 = space
        }
        
        
    }
    
    func returnPlayerSpace( player:Player ) -> String {
        
        var space:String = ""
        
        if (player == .Player1) {
            
            space = currentSpacePlayer1
            
            
        } else if (player == .Player2) {
            
            space = currentSpacePlayer2
        }
        
        
        return space
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
