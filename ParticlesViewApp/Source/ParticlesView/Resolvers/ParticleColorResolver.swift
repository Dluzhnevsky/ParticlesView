import UIKit

final class ParticleColorResolver {
    
    // MARK: - Static methods
    
    static func resolveParticleColorWithSceneAlpha(particleColor: UIColor, sceneAlpha: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        particleColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let mixedAlpha = alpha * sceneAlpha
        return particleColor.withAlphaComponent(mixedAlpha)
    }
    
}
