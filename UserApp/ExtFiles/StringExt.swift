

import Foundation
import Photos

extension String {
    
    
    
    func getDocExt() ->String {
        var strImgExtension : String!
        let fetchOptions = PHFetchOptions()
        var lastAsset: PHAsset!
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(with:.image, options: fetchOptions)
        if fetchResult.count > 0{
            lastAsset = fetchResult.lastObject!
        }
        
        let fileName : String = lastAsset.value(forKey: "filename") as! String
        strImgExtension = ((fileName.components(separatedBy: ".")[1]).lowercased())
        return strImgExtension
    }
    
    
    func toHTML(fontName:String, fontSize:String, textColor:String) -> NSAttributedString{
        
        var direction = "ltr"
        if(Configurations.isRTLMode()){
            direction = "rtl"
        }
        
        let modifiedFont = "<style>" +
            "html *" +
            "{" +
            "dir: \(direction) !important;" +
            "font-size: \(fontSize) !important;" +
            "color: #\(textColor) !important;" +
            "font-family: \(fontName), !important;" +
        "}</style> \(self)"
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr
    }
    
    func toHTML(fontName:String, fontSize:String, textColor:String, text:String) -> NSAttributedString{
        
        var direction = "ltr"
        if(Configurations.isRTLMode()){
            direction = "rtl"
        }
        
        let modifiedFont = "<style>" +
            "html *" +
            "{" +
            "dir: \(direction) !important;" +
            "font-size: \(fontSize) !important;" +
            "color: #\(textColor) !important;" +
            "font-family: \(fontName), !important;" +
        "}</style> \(text)"
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr
    }
    
    var dGet: String? {
            guard let decodedData = Data(base64Encoded: self) else { return nil }
            return String(data: decodedData, encoding: .utf8)
        }
    
    
    func getURL() ->URL {
       return URL(string: (self).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return boundingBox.width
    }
}
