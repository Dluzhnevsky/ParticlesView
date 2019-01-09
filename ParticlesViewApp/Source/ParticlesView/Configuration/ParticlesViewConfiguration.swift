import UIKit

public protocol ParticlesViewConfiguration {
    
    var autostart: Bool { get }
    var density: Int { get }
    var frameDuration: TimeInterval { get }
    var lineColor: UIColor { get }
    var lineLength: CGFloat { get set }
    var lineThickness: CGFloat { get set }
    var particleColor: UIColor { get }
    var particleRadiusMax: CGFloat { get set }
    var particleRadiusMin: CGFloat { get set }
    var speedFactor: CGFloat { get set }

}
