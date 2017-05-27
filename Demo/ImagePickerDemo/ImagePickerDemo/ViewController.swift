import UIKit
import ImagePicker
//import Lightbox
import iOSPhotoEditor

class ViewController: UIViewController, ImagePickerDelegate {

  lazy var button: UIButton = self.makeButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false

    view.addConstraint(
      NSLayoutConstraint(item: button, attribute: .centerX,
                         relatedBy: .equal, toItem: view,
                         attribute: .centerX, multiplier: 1,
                         constant: 0))

    view.addConstraint(
      NSLayoutConstraint(item: button, attribute: .centerY,
                         relatedBy: .equal, toItem: view,
                         attribute: .centerY, multiplier: 1,
                         constant: 0))
  }

  func makeButton() -> UIButton {
    let button = UIButton()
    button.setTitle("Show ImagePicker", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)

    return button
  }

  func buttonTouched(button: UIButton) {
    var config = Configuration()
    config.doneButtonTitle = "Finish"
    config.noImagesTitle = "Sorry! There are no images here!"
    config.recordLocation = false
    config.allowVideoSelection = true

    let imagePicker = ImagePickerController()
    imagePicker.configuration = config
    imagePicker.delegate = self

    present(imagePicker, animated: true, completion: nil)
  }

  // MARK: - ImagePickerDelegate

  func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    imagePicker.dismiss(animated: true, completion: nil)
  }

  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//    guard images.count > 0 else { return }
//
//    let lightboxImages = images.map {
//      return LightboxImage(image: $0)
//    }
//
//    let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
//    imagePicker.present(lightbox, animated: true, completion: nil)
  }
  
  func selectedImage(_ imagePicker: ImagePickerController, image: UIImage) {
    let photoEditor = UIStoryboard(name: "PhotoEditor", bundle: Bundle(for: PhotoEditorViewController.self)).instantiateViewController(withIdentifier: "PhotoEditorViewController") as! PhotoEditorViewController
    
    photoEditor.photoEditorDelegate = self
    photoEditor.image = image
    
    for i in 0...10 {
      photoEditor.stickers.append(UIImage(named: i.description )!)
    }
    
    imagePicker.present(photoEditor, animated: false, completion: nil)
//    imagePicker.dismiss(animated: false) {
//      self.present(photoEditor, animated: false, completion: nil)
//    }
  }
  
  func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    imagePicker.dismiss(animated: true, completion: nil)
  }
}

extension ViewController: PhotoEditorDelegate {
  
  func imageEdited(image: UIImage) {
    // TODO: Send Image
    self.dismiss(animated: true) {
      print("Send image")
    }
  }
  
  func editorCanceled() {
    print("Canceled")
  }
}
