import UIKit

final class ParticleGenerator {
    
    private let pcc: CGFloat = 18
    
    func addNewParticle(scene: Scene, position: Int, offscreenOnly: Bool = false) {
        if (position % 2 == 0 && !offscreenOnly) {
            applyFreshParticleOnScreen(scene: scene, position: position)
        } else {
            applyFreshParticleOffScreen(scene: scene, position: position)
        }
    }
    
    private func applyFreshParticleOnScreen(scene: Scene, position: Int) {
        let w = scene.width
        let h = scene.height

        let direction: CGFloat = CGFloat.random(in: 0..<360).toRadians
        let dCos: CGFloat = cos(direction)
        let dSin: CGFloat = sin(direction)
        let x: CGFloat = CGFloat.random(in: 0..<w)
        let y: CGFloat = CGFloat.random(in: 0..<h)
        let speedFactor: CGFloat = newRandomIndividualParticleSpeedFactor()
        let radius: CGFloat = newRandomIndividualParticleRadius(scene: scene)
        
        scene.setParticleData(
            position: position,
            x: x,
            y: y,
            dCos: dCos,
            dSin: dSin,
            radius: radius,
            speedFactor: speedFactor)
    }
    
    private func applyFreshParticleOffScreen(scene: Scene, position: Int) {
        let w = scene.width
        let h = scene.height
        
        var x: CGFloat = CGFloat.random(in: 0..<w)
        var y: CGFloat = CGFloat.random(in: 0..<h)
        
        let offset = scene.configuration.particleRadiusMin + scene.configuration.lineLength
        
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        
        // Offset and angles for the direction to be towards the view
        switch (Int.random(in: 0..<4)) {
        case 0:
            // Left offset
            x = -offset
            startAngle = angleDeg(ax: pcc, ay: pcc, bx: x, by: y)
            endAngle = angleDeg(ax: pcc, ay: h - pcc, bx: x, by: y)
            break
            
        case 1:
            // Top offset
            y = -offset
            startAngle = angleDeg(ax: w - pcc, ay: pcc, bx: x, by: y)
            endAngle = angleDeg(ax: pcc, ay: pcc, bx: x, by: y)
            break
            
        case 2:
            // Right offset
            x = w + offset
            startAngle = angleDeg(ax: w - pcc, ay: h - pcc, bx: x, by: y)
            endAngle = angleDeg(ax: w - pcc, ay: pcc, bx: x, by: y)
            break
            
        case 3:
            // Bottom offset
            y = h + offset
            startAngle = angleDeg(ax: pcc, ay: h - pcc, bx: x, by: y)
            endAngle = angleDeg(ax: w - pcc, ay: h - pcc, bx: x, by: y)
            break
            
        default:
            break
        }
        
        if (endAngle < startAngle) {
            endAngle += 360
        }
        
        // Random angle from range
        let randomAngleInRange = startAngle + CGFloat.random(in: 0..<(abs(endAngle - startAngle)))
        let direction = randomAngleInRange.toRadians
        
        let dCos: CGFloat = cos(direction)
        let dSin: CGFloat = sin(direction)
        let speedFactor: CGFloat = newRandomIndividualParticleSpeedFactor()
        let radius: CGFloat = newRandomIndividualParticleRadius(scene: scene)
        
        scene.setParticleData(
            position: position,
            x: x,
            y: y,
            dCos: dCos,
            dSin: dSin,
            radius: radius,
            speedFactor: speedFactor)
    }
    
    private func angleDeg(ax: CGFloat, ay: CGFloat,
                          bx: CGFloat, by: CGFloat) -> CGFloat {
        let angleRad = atan2(ay - by, ax - bx)
        
        var angle = angleRad.toDegrees
        
        if (angleRad < 0) {
            angle += 360
        }
        
        return angle
    }
    
    private func newRandomIndividualParticleSpeedFactor() -> CGFloat {
        return 1 + 0.1 * (CGFloat.random(in: 0..<11) - 5)
    }
    
    private func newRandomIndividualParticleRadius(scene: Scene) -> CGFloat {
        return scene.configuration.particleRadiusMin == scene.configuration.particleRadiusMax ?
            scene.configuration.particleRadiusMin
            : scene.configuration.particleRadiusMin + CGFloat.random(in: 0..<(scene.configuration.particleRadiusMax - scene.configuration.particleRadiusMin))
    }
}

private extension CGFloat {
    
    var toRadians: CGFloat {
        return self * .pi / 180
        
    }
    
    var toDegrees: CGFloat {
        return self * 180 / .pi
    }
    
}
