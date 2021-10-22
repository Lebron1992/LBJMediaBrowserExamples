import UIKit
import LBJMediaBrowser

final class MyMediaUIImage: MediaUIImage, MyMedia {
  let caption: String

  init(uiImage: UIImage, caption: String) {
    self.caption = caption
    super.init(uiImage: uiImage)
  }
}
