import UIKit

final class DistanceResolver {
    
    static func distance(ax: CGFloat, ay: CGFloat, bx: CGFloat, by: CGFloat) -> CGFloat {
        return sqrt((ax - bx) * (ax - bx) + (ay - by) * (ay - by))
    }
    
}
