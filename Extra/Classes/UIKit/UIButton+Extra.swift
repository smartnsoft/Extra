// The MIT License (MIT)
//
// Copyright (c) 2017 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

extension Extra where Base: UIButton {
  
  public func configureTitle(with title: String, font: UIFont, color: UIColor,
                             highlightedColor: UIColor? = nil) {
    
    let attributes: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: color]
    let attributedString = NSMutableAttributedString(string: title, attributes: attributes)
    self.base.setAttributedTitle(attributedString, for: .normal)
    self.base.setTitleColor(color, for: .normal)
    
    let highlightedColor = highlightedColor ?? color.withAlphaComponent(0.6)
    let highlightedAttributes: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: highlightedColor]
    let highlightedAttributedString = NSMutableAttributedString(string: title, attributes: highlightedAttributes)
    self.base.setAttributedTitle(highlightedAttributedString, for: .highlighted)
    self.base.setAttributedTitle(highlightedAttributedString, for: [.normal, .highlighted])
    self.base.setTitleColor(highlightedColor, for: .highlighted)
    self.base.setTitleColor(highlightedColor, for: [.normal, .highlighted])
  }
  
  public func configureLeftIcon(with image: UIImage, insets: UIEdgeInsets = .zero) {
    self.base.setImage(image, for: .normal)
    self.base.setImage(image, for: .highlighted)
    self.base.setImage(image, for: [.normal, .highlighted])
    self.base.imageEdgeInsets = insets
    self.base.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width)
  }
  
  public func configureBackground(with color: UIColor, highlightedColor: UIColor? = nil) {
    
    let backgroundImage = UIImage.ex.from(color: color, size: self.base.bounds.size, cornerRadius: self.base.layer.cornerRadius)
    self.base.setBackgroundImage(backgroundImage, for: .normal)
    
    if highlightedColor != nil || color != .clear {
      let highlightedColor = highlightedColor ?? color.withAlphaComponent(0.6)
      let highlightedImage = UIImage.ex.from(color: highlightedColor, size: self.base.bounds.size, cornerRadius: self.base.layer.cornerRadius)
      self.base.setBackgroundImage(highlightedImage, for: .highlighted)
      self.base.setBackgroundImage(highlightedImage, for: [.normal, .highlighted])
    } else {
      self.base.setBackgroundImage(backgroundImage, for: .highlighted)
      self.base.setBackgroundImage(backgroundImage, for: [.normal, .highlighted])
    }
  }
  
  public func configure(withTitle title: String, titleFont: UIFont,
                        titleColor: UIColor, backgroundColor: UIColor,
                        titleHighlightedColor: UIColor? = nil, backgroundHighlightedColor: UIColor? = nil,
                        leftIcon: UIImage? = nil, leftIconEdgeInsets: UIEdgeInsets = .zero,
                        borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear,
                        cornerRadius: CGFloat = 0.0) {
    
    self.base.layer.borderWidth = borderWidth
    self.base.layer.borderColor = borderColor.cgColor
    self.base.layer.cornerRadius = cornerRadius
    self.base.clipsToBounds = true
    
    self.configureTitle(with: title,
                        font: titleFont,
                        color: titleColor,
                        highlightedColor: titleHighlightedColor)
    
    if let image = leftIcon {
      self.configureLeftIcon(with: image, insets: leftIconEdgeInsets)
    }
    
    self.configureBackground(with: backgroundColor, highlightedColor: backgroundHighlightedColor)
  }
}
