import UIKit

final class FrameAdvancer {
    
    private let particleGenerator: ParticleGenerator
    
    init(particleGenerator: ParticleGenerator) {
        self.particleGenerator = particleGenerator
    }
    
    func advanceToNextFrame(scene: Scene, step: CGFloat) {
        let particlesCount = scene.configuration.density
        for i in 0 ..< particlesCount {
            var x = scene.getParticleX(position: i)
            var y = scene.getParticleY(position: i)
            
            let speedFactor = scene.getParticleSpeedFactor(position: i)
            let dCos = scene.getParticleDirectionCos(position: i)
            let dSin = scene.getParticleDirectionSin(position: i)
            
            x += step * scene.configuration.speedFactor * speedFactor * dCos
            y += step * scene.configuration.speedFactor * speedFactor * dSin
            
            if (particleOutOfBounds(scene: scene, x: x, y: y)) {
                particleGenerator.addNewParticle(scene: scene, position: i, offscreenOnly: true)
            } else {
                scene.setParticleX(position: i, x: x)
                scene.setParticleY(position: i, y: y)
            }
        }
    }
    
    func particleOutOfBounds(scene: Scene, x: CGFloat, y: CGFloat) -> Bool {
        let offset = scene.configuration.particleRadiusMin + scene.configuration.lineLength
        return x + offset < 0 || x - offset > scene.width
            || y + offset < 0 || y - offset > scene.height
    }
    
}
