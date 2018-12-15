import UIKit

class ParticlesView: UIView {
    
    // MARK: - Private properties
    
    private var engine: Engine!
    
    // MARK: - Internal properties
    
    var scene: Scene!
    
    // MARK: - Lifecycle
    
    init(frame: CGRect, configuration: ParticlesViewConfiguration) {
        super.init(frame: frame)
        scene = Scene(width: frame.width, height: frame.height, configuration: configuration)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let defaultConfiguration = ParticlesViewConfigurationImpl.default
        scene = Scene(width: frame.width, height: frame.height, configuration: defaultConfiguration)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        engine = Engine(scene: scene)
        engine.delegate = self
        
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if scene.configuration.density > 0 {
            let particleColor = ParticleColorResolver.resolveParticleColorWithSceneAlpha(particleColor: scene.configuration.particleColor,
                                                                                         sceneAlpha: scene.alpha)
            
            let particlesCount = scene.configuration.density
            
            for  i in 0 ..< particlesCount {
                let x1 = scene.getParticleX(at: i)
                let y1 = scene.getParticleY(at: i)
                
                for j in i + 1 ..< particlesCount {
                    let x2 = scene.getParticleX(at: j)
                    let y2 = scene.getParticleY(at: j)
                    
                    let distance = DistanceResolver.distance(ax: x1, ay: y1, bx: x2, by: y2)
                    if distance < scene.configuration.lineLength {
                        
                        let lineColor = LineColorResolver.resolveLineColorWithAlpha(
                            sceneAlpha: scene.alpha,
                            lineColor: scene.configuration.lineColor,
                            maxDistance: scene.configuration.lineLength,
                            distance: distance)
                        
                        drawLine(
                            startX: x1,
                            startY: y1,
                            stopX: x2,
                            stopY: y2,
                            strokeWidth: scene.configuration.lineThickness,
                            color: lineColor)
                    }
                }
                
                let radius = scene.getRadius(at: i)
                fillCircle(x: x1,
                                    y: y1,
                                    radius: radius,
                                    color: particleColor)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func drawLine(startX: CGFloat, startY: CGFloat, stopX: CGFloat, stopY: CGFloat, strokeWidth: CGFloat, color: UIColor) {
        color.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: stopX, y: stopY))
        path.lineWidth = strokeWidth
        path.stroke()
    }
    
    private func fillCircle(x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor) {
        color.setFill()
        UIBezierPath(ovalIn: CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2)).fill()
    }
    
    // MARK: - Internal methods
    
    func start() {
        engine.start()
    }
    
    func stop() {
        engine.stop()
    }
    
}
