import Photos
import LBJMediaBrowser

final class MyMediaPHAssetVideo: MediaPHAssetVideo, MyMedia {
  let caption: String

  init(asset: PHAsset, caption: String) {
    self.caption = caption
    super.init(asset: asset)
  }
}
