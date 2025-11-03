//
//  GameScene.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let ballCategory: UInt32 = 0x1 << 1
    private let spikeCategory: UInt32 = 0x1 << 2
    private let wallCategory: UInt32 = 0x1 << 3
    
    weak var sceneDelegate: GameViewSceneDelegate?
    
    private var selectedSkin: SkinType {
        SkinType.allCases.first(where: { $0.isSelected }) ?? .silver
    }
    
    private var selectedBoard: BoardType {
        BoardType.allCases.first(where: { $0.isSelected }) ?? .blue
    }
    
    private let motionManager = CMMotionManager()
    private var gameArea: CGRect!
    private let level: Level
    
    init(
        size: CGSize,
        level: Level
    ) {
        self.level = level
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        setupGameArea()
        setupBackground()
        setupBoundaries()
        setupLevel()
        startMotionUpdates()
    }
    
    func pauseGame() {
        physicsWorld.speed = 0
        motionManager.stopDeviceMotionUpdates()
    }
    
    func resumeGame() {
        physicsWorld.speed = 1
        startMotionUpdates()
    }
    
    private func setupGameArea() {
        let padding: CGFloat = 16
        let gameWidth = size.width - padding * 2
        let yOffset = (size.height - gameWidth) / 2
        gameArea = CGRect(x: padding, y: yOffset, width: gameWidth, height: gameWidth)
    }
    
    private func setupBackground() {
        let fieldImage = SKSpriteNode(texture: SKTexture(image: selectedBoard.gameImage))
        fieldImage.position = CGPoint(x: gameArea.midX, y: gameArea.midY)
        fieldImage.size = gameArea.size
        fieldImage.zPosition = -1
        addChild(fieldImage)
    }
    
    private func setupBoundaries() {
        let topInset: CGFloat = 21
        let bottomInset: CGFloat = 20
        let leftInset: CGFloat = 17
        let rightInset: CGFloat = 17
        
        let innerRect = CGRect(
            x: gameArea.minX + leftInset,
            y: gameArea.minY + bottomInset,
            width: gameArea.width - leftInset - rightInset,
            height: gameArea.height - topInset - bottomInset
        )
        
        let physicsBody = SKPhysicsBody(edgeLoopFrom: innerRect)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = wallCategory
        physicsBody.friction = 0.3
        
        let physicsNode = SKNode()
        physicsNode.physicsBody = physicsBody
        addChild(physicsNode)
    }
    
    private func setupLevel() {
        let w = gameArea.width, h = gameArea.height
        let x = gameArea.minX, y = gameArea.minY
        
        level.lines.forEach { line in
            addLine(
                from: CGPoint(x: x + w * line.a, y: y + h * line.b),
                to: CGPoint(x: x + w * line.c, y: y + h * line.d),
                color: selectedBoard.color,
                lineWidth: 30
            )
        }
        
        level.balls.forEach { ball in
            addBall(
                at: CGPoint(x: x + w * ball.a, y: y + h * ball.b),
                diameter: ball.d
            )
        }
        
        addSpikeBall(at: CGPoint(x: x + w * level.spikeBall.a, y: y + h * level.spikeBall.b))
    }
    
    private func addLine(
        from start: CGPoint,
        to end: CGPoint,
        color: UIColor,
        lineWidth: CGFloat = 30
    ) {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let length = hypot(dx, dy)
        let angle = atan2(dy, dx)
        
        let line = SKSpriteNode(color: color, size: CGSize(width: length, height: lineWidth))
        line.anchorPoint = CGPoint(x: 0, y: 0.5)
        line.position = start
        line.zRotation = angle
        line.zPosition = 0
        
        line.physicsBody = SKPhysicsBody(rectangleOf: line.size, center: CGPoint(x: length / 2, y: 0))
        line.physicsBody?.isDynamic = false
        line.physicsBody?.categoryBitMask = wallCategory
        line.physicsBody?.friction = 0.3
        
        addChild(line)
    }

    
    private func addBall(
        at position: CGPoint,
        diameter: CGFloat = 40
    ) {
        let texture = SKTexture(image: BallColor.random().image)
        
        let ball = SKSpriteNode(texture: texture)
        ball.name = "ball"
        ball.position = position
        ball.size = CGSize(width: diameter, height: diameter)
        
        let radius = ball.size.width / 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody?.friction = 0.3
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.allowsRotation = true
        
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = spikeCategory
        ball.physicsBody?.collisionBitMask = wallCategory | spikeCategory | ballCategory
        
        addChild(ball)
    }
    
    private func addSpikeBall(
        at position: CGPoint
    ) {
        let texture = SKTexture(image: selectedSkin.image)

        let spike = SKSpriteNode(texture: texture)
        spike.name = "spike"
        spike.position = position
        spike.size = CGSize(width: 50, height: 50)

        spike.physicsBody = SKPhysicsBody(texture: texture, size: spike.size)
        spike.physicsBody?.restitution = 0.4
        spike.physicsBody?.friction = 0.3
        spike.physicsBody?.linearDamping = 0.5
        spike.physicsBody?.categoryBitMask = spikeCategory
        spike.physicsBody?.contactTestBitMask = ballCategory
        spike.physicsBody?.collisionBitMask = wallCategory | ballCategory

        addChild(spike)
    }
}

extension GameScene {
    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.01
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self, let gravity = motion?.gravity else { return }
            self.physicsWorld.gravity = CGVector(dx: gravity.x * 20, dy: gravity.y * 20)
        }
    }
}

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodes = [contact.bodyA.node, contact.bodyB.node]
        guard let ball = nodes.first(where: { $0?.name != "spike" }) else { return }
        if let ballNode = ball as? SKSpriteNode {
            let diameter = ballNode.size.width
            let points = pointsForBall(diameter: diameter)
            sceneDelegate?.didHitBall(points: points)
            
            explode(ballNode)
        }
    }
    
    private func pointsForBall(diameter: CGFloat) -> Int {
        switch diameter {
        case 20:
            return 10
        case 30:
            return 20
        case 40:
            return 30
        default:
            return 0
        }
    }
    
    private func explode(_ node: SKNode) {
        node.removeFromParent()
        checkWinCondition()
    }
    
    private func checkWinCondition() {
        let remainingBalls = children.filter { $0.physicsBody?.categoryBitMask == ballCategory }
        if remainingBalls.isEmpty {
            pauseGame()
            sceneDelegate?.didFinishGame()
        }
    }
}
