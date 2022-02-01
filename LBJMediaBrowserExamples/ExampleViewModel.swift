import Photos
import SwiftUI
import LBJMediaBrowser

struct MediaSection: GridSection {
  let title: String
  let medias: [Media]

  var id: String {
    title
  }
  static func == (lhs: MediaSection, rhs: MediaSection) -> Bool {
    lhs.id == rhs.id
  }
}

final class ExampleViewModel: ObservableObject {

  private let example: Example
  private(set) var dataSource: LBJGridMediaBrowserDataSource<MediaSection>

  init(example: Example) {
    self.example = example

    let sections = [
      MediaSection(title: "UIImages", medias: MockData.uiImages),
      MediaSection(title: "URLImages", medias: MockData.urlImages),
      MediaSection(title: "URLVideos", medias: MockData.urlVideos)
    ]
    self.dataSource = LBJGridMediaBrowserDataSource(
      sections: sections,
      headerProvider: { AnyView(Text($0.title)) }
    )
  }

  @Published
  private(set) var medias: [Media] = []


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
    var assetMedias: [Media] = []
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

    if example.isCustom {
      medias = MockData.mixedMyMedias + assetMedias
    } else {
      medias = MockData.mixedMedias + assetMedias
      dataSource.appendSection(.init(title: "PHAssetMedias", medias: assetMedias))
    }
  }
}
