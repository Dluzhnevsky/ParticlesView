import UIKit

final class LineColorResolver {
    
    private static func resolveLineAlpha(sceneAlpha: CGFloat, maxDistance: CGFloat, distance: CGFloat) -> CGFloat {
        let alphaPercent = 1 - distance / maxDistance
        return alphaPercent * sceneAlpha
    }
    
    static func resolveLineColorWithAlpha (sceneAlpha: CGFloat, lineColor: UIColor, maxDistance: CGFloat, distance: CGFloat)  -> UIColor {
        let alpha = LineColorResolver.resolveLineAlpha(sceneAlpha: sceneAlpha, maxDistance: maxDistance, distance: distance)
        return lineColor.withAlphaComponent(alpha)
    }
    
}
