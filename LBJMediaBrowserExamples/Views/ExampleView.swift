import SwiftUI
import LBJMediaBrowser

struct ExampleView: View {

  private let example: Example

  @ObservedObject
  private var viewModel: ExampleViewModel

  init(example: Example) {
    self.example = example
    viewModel = ExampleViewModel(example: example)
  }

  var body: some View {
    if viewModel.medias.isEmpty {
      Text("")
        .onAppear(perform: viewModel.generateMedias)
    } else {
      destination(for: example)
    }
  }

  @ViewBuilder
  func destination(for example: Example) -> some View {
      switch example {
      case .grid:
        LBJGridMediaBrowser(medias: viewModel.medias)

      case .customGrid:
        LBJGridMediaBrowser(
          medias: viewModel.medias,
          placeholder: { MyPlaceholderView(media: $0) },
          progress: {
            MyProgressView(progress: $0)
              .foregroundColor(.white)
              .frame(width: 40, height: 40)
          },
          failure: {
            MyErrorView(error: $0)
              .font(.system(size: 10))
          },
          content: { MyGridContentView(result: $0) }
        )
          .minItemSize(100) // 80 by default
          .itemSpacing(4)   // 2 by default
          .browseInPagingOnTapItem(true) // true by default
          .autoPlayVideoInPaging(false) // false by default

      case .paging:
        let browser = LBJPagingBrowser(medias: viewModel.medias)
        LBJPagingMediaBrowser(browser: browser)

      case .customPaging:
        let browser: LBJPagingBrowser = {
          let browser = LBJPagingBrowser(medias: viewModel.medias)
          browser.autoPlayVideo = true
          return browser
        }()
        LBJPagingMediaBrowser(
          browser: browser,
          placeholder: { MyPlaceholderView(media: $0) },
          progress: {
            MyProgressView(progress: $0)
              .foregroundColor(.white)
              .frame(width: 100, height: 100)
          },
          failure: {
            MyErrorView(error: $0)
              .font(.system(size: 16))
          },
          content: { MyPagingContentView(result: $0) }
        )
      }
  }
}
