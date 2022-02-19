import Photos
import SwiftUI
import LBJMediaBrowser

extension TitledGridSection {
  static let uiImageTemplate = TitledGridSection(title: "UIImages", medias: MockData.uiImages)
  static let urlImageTemplate = TitledGridSection(title: "URLImages", medias: MockData.urlImages)
  static let urlVideoTemplate = TitledGridSection(title: "URLVideos", medias: MockData.urlVideos)
  static let templates = [uiImageTemplate, urlImageTemplate, urlVideoTemplate]
}

final class ExampleViewModel: ObservableObject {

  @Published
  private(set) var medias: [Media]

  private let example: Example
  let customGridDataSource: LBJGridMediaBrowserDataSource<TitledGridSection>

  init(example: Example) {
    self.example = example
    self.medias = example.isCustom ? MockData.mixedMyMedias : MockData.mixedMedias

    customGridDataSource = LBJGridMediaBrowserDataSource(
      sections: TitledGridSection.templates,
      placeholderProvider: {
        MyPlaceholderView(media: $0)
          .asAnyView()
      },
      progressProvider: {
        MyProgressView(progress: $0)
          .foregroundColor(.white)
          .frame(width: 40, height: 40)
          .asAnyView()
      },
      failureProvider: {
        MyErrorView(error: $0)
          .font(.system(size: 10))
          .asAnyView()
      },
      contentProvider: {
        MyGridContentView(result: $0)
          .asAnyView()
      },
      sectionHeaderProvider: {
        Text($0.title)
          .asAnyView()
      },
      pagingMediaBrowserProvider: { medias, page in
        let dataSource = LBJPagingMediaBrowserDataSource(
          medias: medias,
          placeholderProvider: {
            MyPlaceholderView(media: $0)
              .asAnyView()
          },
          progressProvider: {
            MyProgressView(progress: $0)
              .foregroundColor(.white)
              .frame(width: 100, height: 100)
              .asAnyView()
          },
          failureProvider: { error, retry in
            MyErrorView(error: error, retry: retry)
              .font(.system(size: 16))
              .asAnyView()
          },
          contentProvider: {
            MyPagingContentView(result: $0)
              .asAnyView()
          })
        let browser = LBJPagingBrowser(dataSource: dataSource, currentPage: page)
        browser.autoPlayVideo = true
        return LBJPagingMediaBrowser(browser: browser)
          .background(Color.black)
          .asAnyView()
      }
    )
  }

  func generateMedias() {
    PHPhotoLibrary.requestAuthorization { status in
      DispatchQueue.main.async {
        switch status {
        case .authorized:
          self.mixPHAssetsAndMockData()
        default:
          break
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
      customGridDataSource.append(TitledGridSection(title: "PHAssetMedias", medias: assetMedias))
    } else {
      medias = MockData.mixedMedias + assetMedias
    }
  }
}
