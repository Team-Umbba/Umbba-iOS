//
//  BlurredLabel.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/15.
//

import UIKit

final class BlurLabel: UILabel {
    @IBInspectable
    public var blurRadius: Double = 0 {
        didSet {
            (layer as! BlurrableLayer).blurRadius = blurRadius
        }
    }
    
    override public class var layerClass: AnyClass {
        return BlurrableLayer.self
    }
    
    class BlurrableLayer: CALayer {
        let blurredLayer = BlurredLayer()
        
        override init() {
            super.init()
            addSublayer(blurredLayer)
        }
        
        override init(layer: Any) {
            super.init(layer: layer)
            addSublayer(blurredLayer)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            addSublayer(blurredLayer)
        }
        
        var blurRadius: Double = 0 {
            didSet {
                if oldValue != blurRadius {
                    setNeedsLayout()
                    setNeedsDisplay()
                }
            }
        }
        
        private static let ciContext = CIContext()
        
        override func draw(in ctx: CGContext) {
            super.draw(in: ctx)
            
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            
            if blurRadius > 0 {
                blurredLayer.inputImage = nil
                blurredLayer.display()
                
                let i = ctx.makeImage()!
                
                let imageToBlur = CIImage(cgImage: i)
                
                ctx.clear(bounds)
                
                let blurFilter = CIFilter(name: "CIGaussianBlur")!
                blurFilter.setDefaults()
                blurFilter.setValue(imageToBlur, forKey: kCIInputImageKey)
                blurFilter.setValue(blurRadius, forKey: "inputRadius")
                
                let outputImage = blurFilter.outputImage!
                let cgimg = BlurrableLayer.ciContext.createCGImage(outputImage, from: outputImage.extent)!
                blurredLayer.inputImage = cgimg
            } else {
                blurredLayer.inputImage = nil
            }
            
            blurredLayer.frame = .init(origin: .init(x: -blurRadius,
                                                     y: -blurRadius),
                                       size: .init(width: frame.width + 2 * blurRadius,
                                                   height: frame.height + 2 * blurRadius))
            
            blurredLayer.setNeedsDisplay()
            blurredLayer.display()
            CATransaction.commit()
        }
        
        class BlurredLayer: CALayer {
            var inputImage: CGImage?
            
            override func draw(in ctx: CGContext) {
                super.draw(in: ctx)
                guard let inputImage = inputImage else {
                    ctx.clear(bounds)
                    return
                }
                ctx.translateBy(x: 0, y: bounds.height)
                ctx.scaleBy(x: 1.0, y: -1.0)
                ctx.draw(inputImage, in: bounds)
            }
        }
    }
}
