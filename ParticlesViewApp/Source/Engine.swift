import UIKit

final class Engine {
    
    private let frameAdvancer: FrameAdvancer
    private let particleGenerator: ParticleGenerator
    private let scene: Scene
    
    private var timer: ParticlesTimer!
    
    private var animating = false
    
    var delegate: ParticlesView?
    
    convenience init(scene: Scene) {
        self.init(frameAdvancer: FrameAdvancer(particleGenerator: ParticleGenerator()),
                  particleGenerator: ParticleGenerator(),
                  scene: scene)
    }
    
    init(frameAdvancer: FrameAdvancer, particleGenerator: ParticleGenerator, scene: Scene) {
        self.frameAdvancer = frameAdvancer
        self.particleGenerator = particleGenerator
        self.scene = scene
        
        initParticles()
        
        timer = ParticlesTimer()
        timer.delegate = self
    }
    
    private func initParticles() {
        let scene = self.scene

        for i in 0 ..< scene.configuration.density {
            particleGenerator.addNewParticle(scene: scene, position: i, offscreenOnly: false)
        }
    }
    
    func nextFrame() {
        frameAdvancer.advanceToNextFrame(scene: scene, step: 1)
        delegate?.setNeedsDisplay()
    }
    
    public func start() {
        if (!animating) {
            animating = true
            timer.start()
            nextFrame()
        }
    }
    
    public func stop() {
        if (animating) {
            animating = false
        }
    }
    
}
