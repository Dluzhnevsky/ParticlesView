import Foundation

final class ParticlesTimer {
    
    var delegate: Engine?
    
    func start() {
        let frameDuration = ParticlesViewConfigurationImpl.default.frameDuration
        Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: #selector(nextFrame), userInfo: nil, repeats: true)
    }
    
    @objc
    func nextFrame() {
        delegate?.nextFrame()
    }
    
}

