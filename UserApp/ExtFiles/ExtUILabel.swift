

import UIKit

extension UILabel{
    
    func addImg(imageName: String, afterLabel bolAfterLabel: Bool = false){
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if (bolAfterLabel){
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        }else{
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImg(){
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
    
    func setHTML(text: String ,_ isFromAddStop:Bool = false) {
        if isFromAddStop {
            var direction = "ltr"
            if(Configurations.isRTLMode()){
                direction = "rtl"
            }
            
            let modifiedFont = "<style>" +
            "html *" +
            "{" +
            "dir: \(direction) !important;" +
            "font-size: \(16) !important;" +
            "color: #\("817E7E") !important;" +
            "font-family: \(self.font!.fontName), !important;" +
            "}</style> \(text)"
            
            //let modifiedFont = NSString(format:"<div dir=\"\(direction)\" style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize); color: \(self.textColor.hexS)\">%@</div>" as NSString, text) as String
            
            let attrStr = try! NSAttributedString(
                data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            self.attributedText = attrStr
        }else{
            var direction = "ltr"
            if(Configurations.isRTLMode()){
                direction = "rtl"
            }
            
            let modifiedFont = "<style>" +
            "html *" +
            "{" +
            "dir: \(direction) !important;" +
            "font-size: \(self.font!.pointSize) !important;" +
            "color: #\(self.textColor.hexS) !important;" +
            "font-family: \(self.font!.fontName), !important;" +
            "}</style> \(text)"
            
            //let modifiedFont = NSString(format:"<div dir=\"\(direction)\" style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize); color: \(self.textColor.hexS)\">%@</div>" as NSString, text) as String
            
            let attrStr = try! NSAttributedString(
                data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            self.attributedText = attrStr
        }
    }
    
    func fit(){
        self.numberOfLines = 0
        self.sizeToFit()
    }
    
    func halfTextColorChange(fullText: String , changeText: String , withColor:UIColor) {
        
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)]

        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: withColor , range: range)
        attribute.addAttributes(boldFontAttribute, range: range)
        
        self.attributedText = attribute
    }
    
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
    
}

