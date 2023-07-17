//
//  BlurredLabel.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/15.
//

import UIKit

final class BlurLabel: UILabel {
    var isBlurring = false {
        didSet {
            setNeedsDisplay()
        }
    }

    var blurRadius: Double = 5 {
        didSet {
            blurFilter?.setValue(blurRadius, forKey: kCIInputRadiusKey)
        }
    }

    lazy var blurFilter: CIFilter? = {
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setDefaults()
        blurFilter?.setValue(blurRadius, forKey: kCIInputRadiusKey)
        return blurFilter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.isOpaque = false
        layer.needsDisplayOnBoundsChange = true
        layer.contentsScale = UIScreen.main.scale
        layer.contentsGravity = .center
        isOpaque = false
        isUserInteractionEnabled = false
        contentMode = .redraw
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
        
    }
   
   override func display(_ layer: CALayer) {
       let bounds = layer.bounds
       guard !bounds.isEmpty && bounds.size.width < CGFloat(UINT16_MAX) else {
           layer.contents = nil
           return
       }
       UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, layer.contentsScale)
       if let ctx = UIGraphicsGetCurrentContext() {
           self.layer.draw(in: ctx)
       
           var image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
           if isBlurring, let cgImage = image {
               blurFilter?.setValue(CIImage(cgImage: cgImage), forKey: kCIInputImageKey)
               let ciContext = CIContext(cgContext: ctx, options: nil)
               if let blurOutputImage = blurFilter?.outputImage,
                  let cgImage = ciContext.createCGImage(blurOutputImage, from: blurOutputImage.extent) {
                   image = cgImage
               }
           }
           layer.contents = image
       }
       UIGraphicsEndImageContext()
   }
}
