// The MIT License (MIT)
//
// Copyright (c) 2018 Smart&Soft
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

extension Extra where Base: CALayer {

  /// Reproduces and applies a shadow that nearly perfectly matches the design according to Zeplin or Sketch parameters.
  public func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0) {
    self.base.shadowColor = color.cgColor
    self.base.shadowOpacity = alpha
    self.base.shadowOffset = CGSize(width: x, height: y)
    self.base.shadowRadius = blur / 2.0
    if spread == 0 {
      self.base.shadowPath = nil
    } else {
      let deltaX = -spread
      let rect = self.base.bounds.insetBy(dx: deltaX, dy: deltaX)
      self.base.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.base.cornerRadius).cgPath
    }
  }

  /// Resets shadow related properties to their default values.
  public func resetShadowToDefaults() {
    self.base.shadowColor = UIColor.black.cgColor
    self.base.shadowOpacity = 0
    self.base.shadowOffset = CGSize(width:0, height:-3)
    self.base.shadowRadius = 3
    self.base.shadowPath = nil
  }
}
