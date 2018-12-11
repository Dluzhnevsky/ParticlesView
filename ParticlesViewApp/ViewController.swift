import UIKit


class ViewController: UIViewController {
    
    var pv: ParticlesView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pv = ParticlesView(frame: view.frame)
        pv.backgroundColor = .white
        view.addSubview(pv)
        view.sendSubviewToBack(pv)
        pv.start()
        
        self.pv = pv
    }
    
    
    @IBOutlet weak var maxRadiusSlider: UISlider!
    @IBOutlet weak var minRadiusSlider: UISlider!
    
    @IBAction func lineLengthChanged(_ sender: UISlider) {
        self.pv?.scene.configuration.lineLength = CGFloat(sender.value)
    }
    
    @IBAction func thicknessChanged(_ sender: UISlider) {
        self.pv?.scene.configuration.lineThickness = CGFloat(sender.value)
    }
    
    @IBAction func maxRadiusChanged(_ sender: UISlider) {
        if maxRadiusSlider.value < minRadiusSlider.value {
            minRadiusSlider.value = maxRadiusSlider.value
            self.pv?.scene.configuration.particleRadiusMin = CGFloat(maxRadiusSlider.value)
        }
        
        self.pv?.scene.configuration.particleRadiusMax = CGFloat(sender.value)
    }
    
    @IBAction func minRadiusChanged(_ sender: UISlider) {
        if minRadiusSlider.value > maxRadiusSlider.value {
            maxRadiusSlider.value = minRadiusSlider.value
            self.pv?.scene.configuration.particleRadiusMax = CGFloat(minRadiusSlider.value)
        }
        
        self.pv?.scene.configuration.particleRadiusMin = CGFloat(sender.value)
    }
    
    @IBAction func speedFactorChanged(_ sender: UISlider) {
        self.pv?.scene.configuration.speedFactor = CGFloat(sender.value)
    }
}

