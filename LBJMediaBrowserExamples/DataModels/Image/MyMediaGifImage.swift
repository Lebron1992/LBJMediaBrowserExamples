import UIKit
import LBJMediaBrowser

final class MyMediaGifImage: MediaGifImage, MyMedia {
  let caption: String

  init(source: MediaGifImage.Source, caption: String) {
    self.caption = caption
    super.init(source: source)
  }
}
