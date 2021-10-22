import Foundation
import LBJMediaBrowser

final class MyMediaURLVideo: MediaURLVideo, MyMedia {
  let caption: String

  init(videoUrl: URL, previewImageUrl: URL? = nil, caption: String) {
    self.caption = caption
    super.init(videoUrl: videoUrl, previewImageUrl: previewImageUrl)
  }
}
