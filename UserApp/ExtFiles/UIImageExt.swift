
import Foundation
extension UIImage {
    
    func rotate(_ degrees: Double) -> UIImage {
        
        let radians = CGFloat(Double.pi * degrees / 180)
        
        var rotatedViewBox: UIView? = UIView(frame: CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale))
        let t = CGAffineTransform(rotationAngle: radians)
        rotatedViewBox!.transform = t
        let rotatedSize = rotatedViewBox!.frame.size
        rotatedViewBox = nil
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()!
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
        
        //   // Rotate the image context
        bitmap.rotate(by: radians)
        
        // Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(cgImage!, in: CGRect(x:-size.width * scale / 2, y: -size.height * scale / 2, width: size.width * scale, height: size.height * scale))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage.resize(toWidth: newImage.size.width/scale)!.resize(toHeight: newImage.size.height/scale)!
    }
}
