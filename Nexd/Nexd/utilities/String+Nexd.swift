//
//  String+Nexd.swift
//  Nexd
//
//  Created by Tobias Schröpf on 01.04.20.
//  Copyright © 2020 Tobias Schröpf. All rights reserved.
//

import UIKit

extension String {
    func asDefaultText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asListHeader() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asTitle() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.titleTextColor,
            .font: UIFont.boldSystemFont(ofSize: 36)
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asPlaceholder() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.textFieldPlaceholderTextColor
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asErrorLabel() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.errorTintColor,
            .font: UIFont.systemFont(ofSize: 12)
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asWarningLabel() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.warningTintColor,
            .font: UIFont.systemFont(ofSize: 12)
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asLink(range: Range<String.Index>?, target: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16)
        ]

        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)

        guard let range = range else { return attributedString }
        attributedString.addAttribute(.link, value: target, range: NSRange(range, in: self))
        return attributedString
    }

    func asGreeting() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 58
        paragraphStyle.maximumLineHeight = 58

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.nexdGreen()!,
            .font: R.font.proximaNovaSoftBold(size: 48)!,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asGreetingSubline() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 42
        paragraphStyle.maximumLineHeight = 42

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.greetingSubline()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asLightButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.nexdGreen()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asDarkButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.darkButtonText()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asSolidButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.solidButtonText()!,
            .font: R.font.proximaNovaSoftBold(size: 25)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asPositiveButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.positiveButtonText()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asNegativeButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.negativeButtonText()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asBackButtonText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.darkButtonText()!,
            .font: R.font.proximaNovaSoftBold(size: 23)!
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asHeading() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 42
        paragraphStyle.maximumLineHeight = 42

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.headingText()!,
            .font: R.font.proximaNovaSoftBold(size: 35)!,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: self, attributes: attributes)
    }

    func asListItemTitle() -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [
                                      .foregroundColor: R.color.listItemTitle()!,
                                      .font: R.font.proximaNovaSoftRegular(size: 20)!
                                  ])
    }

    func asListItemDetails() -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [
                                    .foregroundColor: R.color.listItemDetailsText()!,
                                      .font: R.font.proximaNovaSoftRegular(size: 14)!
                                  ])
    }

    func asAmountText() -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [
                                      .foregroundColor: R.color.amountText()!,
                                      .font: R.font.proximaNovaSoftBold(size: 20)!
                                  ])
    }

    func asDarkListItemTitle() -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [
                                      .foregroundColor: R.color.darkListItemTitle()!,
                                      .font: R.font.proximaNovaSoftBold(size: 35)!
                                  ])
    }

    func asDarkListItemDetails() -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [
                                      .foregroundColor: R.color.darkListItemDetails()!,
                                      .font: R.font.proximaNovaSoftBold(size: 14)!
                                  ])
    }

    func parseHtml() -> NSAttributedString? {
        return try? NSAttributedString(
            data: data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}
