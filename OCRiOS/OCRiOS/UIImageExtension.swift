//
//  UIImageExtension.swift
//  OCRiOS
//
//  Created by Pasonatech on 2021/05/26.
//

import UIKit
import GPUImage

extension UIImage {
    func preprocessedImage() -> UIImage? {
      let stillImageFilter = GPUImageAdaptiveThresholdFilter()
      stillImageFilter.blurRadiusInPixels = 15.0
      let filteredImage = stillImageFilter.image(byFilteringImage: self)
      return filteredImage
    }
    
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
      var scaledSize = CGSize(width: maxDimension, height: maxDimension)

      if size.width > size.height {
        scaledSize.height = size.height / size.width * scaledSize.width
      } else {
        scaledSize.width = size.width / size.height * scaledSize.height
      }

      UIGraphicsBeginImageContext(scaledSize)
      draw(in: CGRect(origin: .zero, size: scaledSize))
      let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return scaledImage
    }
}
