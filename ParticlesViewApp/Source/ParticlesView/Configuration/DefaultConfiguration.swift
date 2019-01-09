import UIKit

final class ParticlesViewConfigurationImpl: ParticlesViewConfiguration {
    
    let autostart: Bool
    let density: Int
    let frameDuration: TimeInterval
    let lineColor: UIColor
    var lineLength: CGFloat
    var lineThickness: CGFloat
    let particleColor: UIColor
    var particleRadiusMax: CGFloat
    var particleRadiusMin: CGFloat
    var speedFactor: CGFloat
    
    init(autostart: Bool,
         density: Int,
         frameDuration: TimeInterval,
         lineColor: UIColor,
         lineLength: CGFloat,
         lineThickness: CGFloat,
         particleColor: UIColor,
         particleRadiusMax: CGFloat,
         particleRadiusMin: CGFloat,
         speedFactor: CGFloat) {
        self.autostart = autostart
        self.density = density
        self.frameDuration = frameDuration
        self.lineColor = lineColor
        self.lineLength = lineLength
        self.lineThickness = lineThickness
        self.particleColor = particleColor
        self.particleRadiusMax = particleRadiusMax
        self.particleRadiusMin = particleRadiusMin
        self.speedFactor = speedFactor
    }
    
    static let `default` = ParticlesViewConfigurationImpl(autostart: true,
                                                        density: 190,
                                                        frameDuration: 0.05,
                                                        lineColor: .gray,
                                                        lineLength: 86,
                                                        lineThickness: 1,
                                                        particleColor: .darkGray,
                                                        particleRadiusMax: 0,
                                                        particleRadiusMin: 0,
                                                        speedFactor: 0.25)
    
    
}
