import Photos
import SwiftUI
import LBJMediaBrowser

final class ExampleViewModel: ObservableObject {

  private let example: Example

  init(example: Example) {
    self.example = example
  }

  @Published
  private(set) var medias: [MediaType] = []

  func generateMedias() {
    PHPhotoLibrary.requestAuthorization { status in
      DispatchQueue.main.async {
        switch status {
        case .authorized:
          self.mixPHAssetsAndMockData()
        default:
          if self.example.isCustom {
            self.medias = MockData.mixedMyMedias
          } else {
            self.medias = MockData.mixedMedias
          }
        }
      }
    }
  }

  private func mixPHAssetsAndMockData() {
    var assetMedias: [MediaType] = []
    let result = PHAsset.fetchAssets(with: nil)

    (0..<result.count).forEach { index in
      let asset = result.object(at: index)
      switch asset.mediaType {
      case .image:
        if example.isCustom {
          assetMedias.append(MyMediaPHAssetImage(asset: asset, caption: "MyMediaPHAssetImage \(index)"))
        } else {
          assetMedias.append(MediaPHAssetImage(asset: asset))
        }
      case .video:
        if example.isCustom {
          assetMedias.append(MyMediaPHAssetVideo(asset: asset, caption: "MyMediaPHAssetVideo \(index)"))
        } else {
          assetMedias.append(MediaPHAssetVideo(asset: asset))
        }
      default:
        break
      }
    }

    if self.example.isCustom {
      self.medias = MockData.mixedMyMedias + assetMedias
    } else {
      self.medias = MockData.mixedMedias + assetMedias
    }
  }
}
