//
//  StarRatingView.swift
//  BookDiary
//
//  Created by Quien on 2022/12/9.
//

import UIKit

protocol RatingViewDelegate {
  func updateRatingFormatValue(_ value: Float)
}

@IBDesignable
class StarRatingView: UIView {
  
  // MARK: - Properties
  var imageViewList = [UIImageView]()
  var delegate: RatingViewDelegate!
  var changeable: Bool = true
  
  @IBInspectable
  var maxCount: Float = 5.0 {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var fillImage: UIImage = UIImage(systemName: "star.fill")! {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var emptyImage: UIImage = UIImage(systemName: "star")! {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var ratingValue: Float = 0.0 {
    didSet {
      updateViewAppearance(ratingValue)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    updateView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    updateView()
  }
  
  
  // MARK: - View
  func updateView() {
    imageViewList.removeAll()
    subviews.forEach{ view in
      view.removeFromSuperview()
    }
    
    for i in 1...Int(maxCount) {
      let imageView: UIImageView = UIImageView()
      imageView.image = emptyImage
      imageView.tag = i
      imageView.contentMode = .scaleAspectFit
      imageViewList.append(imageView)
    }
    
    let stackView = UIStackView(arrangedSubviews: imageViewList)
    stackView.alignment = .fill
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 5.0
    addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
  }
  
  func updateViewAppearance(_ xPoint: Float) {
    var tag = 0
    for imageView in imageViewList {
      let imageViewX = Int(imageView.frame.origin.x)
      if Int(xPoint) > imageViewX {
        if Int(xPoint) == tag {
          imageView.image = emptyImage
        } else {
          imageView.image = fillImage
          tag = tag + 1
        }
      } else {
        imageView.image = emptyImage
      }
    }
    updateRating(Float(tag))
  }
  
  // MARK: - UITouch Delegate
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard changeable else { return }
    if let touch = touches.first {
      let currentPoint = touch.location(in: self)
      updateViewAppearance(Float(currentPoint.x))
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard changeable else { return }
    if let touch = touches.first {
      let currentPoint = touch.location(in: self)
      updateViewAppearance(Float(currentPoint.x))
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard changeable else { return }
    if let touch = touches.first {
      let currentPoint = touch.location(in: self)
      updateViewAppearance(Float(currentPoint.x))
    }
  }
  
  
  //MARK: - Delegate
  func updateRating(_ value: Float) {
    if delegate != nil {
      delegate.updateRatingFormatValue(value)
    }
  }
  
}
