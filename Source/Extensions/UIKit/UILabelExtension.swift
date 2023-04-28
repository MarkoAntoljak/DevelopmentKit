//
//  UILabelExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 26/04/2023.
//

import Foundation
import UIKit

public extension UILabel {
    /// Adds image to a label.
    ///
    /// - Parameters:
    ///   - image: The image to use.
    ///   - afterLabel: Sets the image after the label, default is false.
    ///
    func addImage(image: UIImage, afterLabel: Bool = false) {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = image
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        if (afterLabel) {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
}
