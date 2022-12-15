//
//  MyShelfDetailTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/9.
//

import UIKit

class MyShelfDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RatingViewDelegate, GenreListDelegate {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var autherTextField: UITextField!
  @IBOutlet weak var ratesView: StarRatingView!
  @IBOutlet weak var reviewTextView: UITextView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var genreCountLabel: UILabel!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var uploadImageButton: UIButton!
  
  var post: Post?
  var rates: Float = 0.0
  var language: Language?
  var genre: Genres?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.delegate = self
    autherTextField.delegate = self
    ratesView.delegate = self
    updateView()
    updateSaveButtonState()
    setEndEditing()
  }
  
  // MARK: -
  
  @IBSegueAction func selectGenre(_ coder: NSCoder, sender: Any?) -> GenreListTableViewController? {
    let detailController = GenreListTableViewController(coder: coder)
    detailController?.genre = Genres(rawValue: genreLabel.text!)
    return detailController
  }
  
  @IBAction func titleEditingChanged(_ sender: Any) {
    updateSaveButtonState()
  }
  
  @IBAction func autherEditingChanged(_ sender: Any) {
    updateSaveButtonState()
  }
  
  @IBAction func uploadImageButtonTapped(_ sender: UIButton) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  // MARK: - Image
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let pickedImage = info[.originalImage] as? UIImage else {
        return
    }
    bookImageView.contentMode = .scaleAspectFit
    bookImageView.image = pickedImage
    uploadImageButton.setTitle("Edit Image", for: .normal)
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func saveImage(with imageName: String) {
    let imagePath = FileManager.pathToImagesDirectory(with: imageName)
    if let jpegData = bookImageView.image!.jpegData(compressionQuality: 1.0) {
        try? jpegData.write(to: imagePath)
    }
  }
  
  // MARK: -
  
  func updateView() {
    if let post = post {
      navigationItem.title = "Edit Post"
      titleTextField.text = post.title
      autherTextField.text = post.author
      ratesView.ratingValue = post.rates!
      reviewTextView.text = post.review!
      genreLabel.text = post.genres.rawValue
      genre = post.genres
      bookImageView.image = Post.loadImage(imageName: post.img)
    }
    genreCountLabel.text = String(Genres.allCases.count)
  }
  
  func updateSaveButtonState() {
    let notYet = "Not Yet"
    let shouldEnableSaveButton =
    (titleTextField.text?.isEmpty == false) &&
    (autherTextField.text?.isEmpty == false) &&
    (genreLabel.text?.isEmpty == false) &&
    !notYet.contains(genreLabel.text!)
    saveButton.isEnabled = shouldEnableSaveButton
  }
  
  // MARK: - textField & Keyboard
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    titleTextField.resignFirstResponder()
    autherTextField.resignFirstResponder()
    return true
  }
  
  // MARK: - Delegate
  
  func updateRatingFormatValue(_ value: Float) {
    rates = value
  }
  
  func didSelect(genre: Genres) {
    self.genre = genre
    genreLabel.text = genre.rawValue
    updateSaveButtonState()
  }
  
  // MARK: - Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "saveUnwind" {
      let title = titleTextField.text!
      let auther = autherTextField.text!
      let review = reviewTextView.text
      let img = bookImageView.image != nil ? UUID().uuidString : nil
      if post != nil {
        post?.title = title
        post?.img = img
        post?.author = auther
        post?.rates = rates
        post?.review = review
        post?.genres = genre!
      } else {
        post = Post(title: title, img: img, author: auther, rates: rates, genres: Genres(rawValue: genre!.rawValue)!, review: review, postedDate: Date(), poster: Poster(firstName: User.currentUser!.firstName, nickName: User.currentUser!.nickName))
      }
      if let img = img {
        saveImage(with: img)
      }
    } else if segue.identifier == "selectGenre" {
      let destinationViewController = segue.destination as? GenreListTableViewController
      destinationViewController?.delegate = self
      destinationViewController?.genre = genre
    } else {
      return
    }
  }
    
}
