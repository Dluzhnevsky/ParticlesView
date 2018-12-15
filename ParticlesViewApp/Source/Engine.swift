import UIKit

final class Engine {
    
    // MARK: - Private properties
    
    private let frameAdvancer: FrameAdvancer
    private let particleGenerator: ParticleGenerator
    private let scene: Scene
    
    private var timer: ParticlesTimer!
    
    private var animating = false
    
    // MARK: - Internal properties
    
    var delegate: ParticlesView?
    
    convenience init(scene: Scene) {
        self.init(frameAdvancer: FrameAdvancer(particleGenerator: ParticleGenerator()),
                  particleGenerator: ParticleGenerator(),
                  scene: scene)
    }
    
    // MARK: - Lifecycle
    
    init(frameAdvancer: FrameAdvancer, particleGenerator: ParticleGenerator, scene: Scene) {
        self.frameAdvancer = frameAdvancer
        self.particleGenerator = particleGenerator
        self.scene = scene
        
        initParticles()
        
        timer = ParticlesTimer()
        timer.delegate = self
    }
    
    // MARK: - Internal methods
    
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
    
    // MARK: - Public methods
    
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
