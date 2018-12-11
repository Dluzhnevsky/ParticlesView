import UIKit

final class Scene {
    
    private(set) var alpha: CGFloat = 1.0
    
    var configuration: ParticlesViewConfiguration
    
    private(set) var width: CGFloat
    private(set) var height: CGFloat
    
    private var radiuses: [CGFloat]!
    private var coordinates: [CGFloat]!
    private var directions: [CGFloat]!
    
    
    private var speedFactors: [CGFloat]!
    
    init(width: CGFloat, height: CGFloat, configuration: ParticlesViewConfiguration) {
        self.width = width
        self.height = height
        self.configuration = configuration
        initBuffers(density: configuration.density)
    }
    
    func setParticleData(
        position: Int,
        x: CGFloat,
        y: CGFloat,
        dCos: CGFloat,
        dSin: CGFloat,
        radius: CGFloat,
        speedFactor: CGFloat) {
        setParticleX(at: position, x: x)
        setParticleY(at: position, y: y)
        
        setParticleDirectionCos(at: position, direction: dCos)
        setParticleDirectionSin(at: position, direction: dSin)
        
        radiuses[position] = radius
        speedFactors[position] = speedFactor
    }
    
    func getRadius(at position: Int) -> CGFloat {
        return radiuses[position]
    }
    
    func getParticleX(at position: Int) -> CGFloat {
        return coordinates[position * 2]
    }
    
    func getParticleY(at position: Int) -> CGFloat {
        return coordinates[position * 2 + 1]
    }
    
    func getParticleDirectionCos(at position: Int) -> CGFloat {
        return directions[position * 2]
    }
    
    func getParticleDirectionSin(at position: Int) -> CGFloat {
        return directions[position * 2 + 1]
    }
    
    func getParticleSpeedFactor(at position: Int) -> CGFloat {
        return speedFactors[position]
    }
    
    func setParticleX(at position: Int, x: CGFloat) {
        coordinates[position * 2] = x
    }
    
    func setParticleY(at position: Int, y: CGFloat) {
        coordinates[position * 2 + 1] = y
    }
    
    private func setParticleDirectionCos(at position: Int, direction: CGFloat) {
        directions[position * 2] = direction
    }
    
    private func setParticleDirectionSin(at position: Int, direction: CGFloat) {
        directions[position * 2 + 1] = direction
    }
    
    private func initBuffers(density: Int) {
        initCoordinates(density: density)
        initDirections(density: density)
        initSpeedFactors(density: density)
        initRadiuses(density: density)
    }
    
    private func initCoordinates(density: Int) {
        let capacity = density * 2
        if (coordinates == nil || coordinates.capacity != capacity) {
            coordinates = [CGFloat].init(repeating: 0, count: capacity)
        }
    }
    
    private func initDirections(density: Int) {
        let capacity = density * 2
        if (directions == nil || directions.capacity != capacity) {
            directions = [CGFloat].init(repeating: 0, count: capacity)
        }
    }
    
    private func initSpeedFactors(density: Int) {
        if (speedFactors == nil || speedFactors.capacity != density) {
            speedFactors = [CGFloat].init(repeating: 0, count: density)
        }
    }
    
    private func initRadiuses(density: Int) {
        if (radiuses == nil || radiuses.capacity != density) {
            radiuses = [CGFloat].init(repeating: 0, count: density)
        }
    }
    
}
