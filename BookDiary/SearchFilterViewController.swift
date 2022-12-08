//
//  SearchFilterViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-06.
//

import UIKit

class SearchFilterViewController: UIViewController {
  
  @IBOutlet var genreCollapseButton: UIButton!
  @IBOutlet var genreVerticalStackView: UIStackView!
  var genreCollapseVerticalStackView: UIStackView?
  var genreCheckBoxs: [UIButton] = []
  var genreIsShown: [Genres: Bool] = [:]
  
  @IBOutlet var doneCollapseButton: UIButton!
  @IBOutlet var doneCollapseVerticalStackView: UIStackView!
  @IBOutlet var inCompleteCheckButton: UIButton!
  @IBOutlet var completeCheckButton: UIButton!
  var completionIsShown: [Completion: Bool] = [:]
  
  @IBOutlet var rateCollapseButton: UIButton!
  @IBOutlet var rateSlider: UISlider!
  var rate: Float = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let genreStackView = UIStackView()
    genreStackView.translatesAutoresizingMaskIntoConstraints = false
    genreStackView.axis = .vertical
    genreStackView.alignment = .fill
    genreStackView.distribution = .fillProportionally
    
    for genre in Genres.allCases {
      
      let checkBox = UIButton()
      checkBox.setImage(UIImage(systemName: "square"), for: .normal)
      checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
      checkBox.isSelected = genreIsShown[genre]!
      checkBox.addTarget(self, action: #selector(genreCheckBoxTapped(_:)), for: .touchUpInside)
      genreCheckBoxs.append(checkBox)
      
      let genreLabel = UILabel()
      genreLabel.translatesAutoresizingMaskIntoConstraints = false
      genreLabel.text = genre.rawValue
      
      let horizontalStackView = UIStackView(arrangedSubviews: [checkBox, genreLabel])
      horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
      horizontalStackView.axis = .horizontal
      horizontalStackView.alignment = .fill
      horizontalStackView.distribution = .fillEqually
      
      genreStackView.addArrangedSubview(horizontalStackView)
    }
    genreVerticalStackView.addArrangedSubview(genreStackView)
    genreCollapseVerticalStackView = genreStackView
    genreCollapseVerticalStackView?.isHidden = true
    
    
    inCompleteCheckButton.isSelected = completionIsShown[.incomplete]!
    completeCheckButton.isSelected = completionIsShown[.complete]!
    doneCollapseVerticalStackView.isHidden = true
    
    rateSlider.value = rate
    rateSlider.isHidden = true
  }
  
  @objc func genreCheckBoxTapped(_ sender: UIButton) {
    for (index, button) in genreCheckBoxs.enumerated() {
      if button === sender {
        let genre = Genres.allCases[index]
        if let genreChecked = genreIsShown[genre] {
          genreIsShown[genre] = !genreChecked
          sender.isSelected.toggle()
          break
        }
      }
    }
  }
  
  @IBAction func genreCollapseButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    // TODO: Show vertical stack view
    genreCollapseVerticalStackView?.isHidden.toggle()
    
  }
  
  @IBAction func doneCheckButtonTapped(_ sender: UIButton) {
    if sender == inCompleteCheckButton {
      inCompleteCheckButton.isSelected.toggle()
      completionIsShown[.incomplete]?.toggle()
    } else {
      completeCheckButton.isSelected.toggle()
      completionIsShown[.complete]?.toggle()
    }
  }
  
  
  @IBAction func doneCollapseButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    doneCollapseVerticalStackView.isHidden.toggle()
  }
  
  @IBAction func rateCollapseButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    rateSlider.isHidden.toggle()
  }
  
  @IBAction func rateSliderValueChanged(_ sender: UISlider) {
    rate = sender.value
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "saveFilter" else { return }
  }
}
