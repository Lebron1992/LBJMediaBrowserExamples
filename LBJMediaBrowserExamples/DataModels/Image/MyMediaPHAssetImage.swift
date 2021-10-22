import Photos
import LBJMediaBrowser

final class MyMediaPHAssetImage: MediaPHAssetImage, MyMedia {
  let caption: String

  init(asset: PHAsset, caption: String) {
    self.caption = caption
    super.init(asset: asset)
  }
}
