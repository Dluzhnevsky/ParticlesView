import UIKit

final class FrameAdvancer {
    
    // MARK: - Private properties
    
    private let particleGenerator: ParticleGenerator
    
    // MARK: - Lifecycle
    
    init(particleGenerator: ParticleGenerator) {
        self.particleGenerator = particleGenerator
    }
    
    // MARK: - Internal methods
    
    func advanceToNextFrame(scene: Scene, step: CGFloat) {
        let particlesCount = scene.configuration.density
        for i in 0 ..< particlesCount {
            var x = scene.getParticleX(at: i)
            var y = scene.getParticleY(at: i)
            
            let speedFactor = scene.getParticleSpeedFactor(at: i)
            let dCos = scene.getParticleDirectionCos(at: i)
            let dSin = scene.getParticleDirectionSin(at: i)
            
            x += step * scene.configuration.speedFactor * speedFactor * dCos
            y += step * scene.configuration.speedFactor * speedFactor * dSin
            
            if (particleOutOfBounds(scene: scene, x: x, y: y)) {
                particleGenerator.addNewParticle(scene: scene, position: i, offscreenOnly: true)
            } else {
                scene.setParticleX(at: i, x: x)
                scene.setParticleY(at: i, y: y)
            }
        }
    }
    
    func particleOutOfBounds(scene: Scene, x: CGFloat, y: CGFloat) -> Bool {
        let offset = scene.configuration.particleRadiusMin + scene.configuration.lineLength
        return x + offset < 0 || x - offset > scene.width
            || y + offset < 0 || y - offset > scene.height
    }
    
}
