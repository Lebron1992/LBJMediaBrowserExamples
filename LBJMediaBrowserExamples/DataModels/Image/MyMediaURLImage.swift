import Foundation
import LBJMediaBrowser

final class MyMediaURLImage: MediaURLImage, MyMedia {
  let caption: String

  init(imageUrl: URL, thumbnailUrl: URL? = nil, caption: String) {
    self.caption = caption
    super.init(imageUrl: imageUrl, thumbnailUrl: thumbnailUrl)
  }

}
