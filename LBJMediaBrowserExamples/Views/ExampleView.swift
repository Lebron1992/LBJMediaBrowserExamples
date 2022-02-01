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
    destination(for: example)
      .onAppear(perform: viewModel.generateMedias)
  }

  @ViewBuilder
  func destination(for example: Example) -> some View {
      switch example {
      case .grid:
//        LBJGridMediaBrowser(medias: viewModel.medias)
        LBJGridMediaBrowserTest(dataSource: viewModel.dataSource)

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
          content: { MyGridContentView(result: $0) },
          pagingMediaBrowser: { page in
            let browser: LBJPagingBrowser = {
              let browser = LBJPagingBrowser(medias: viewModel.medias, currentPage: page)
              browser.autoPlayVideo = true
              return browser
            }()
            return AnyView(
              LBJPagingMediaBrowser(
                browser: browser,
                placeholder: { MyPlaceholderView(media: $0) },
                progress: {
                  MyProgressView(progress: $0)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                },
                failure: { error, retry in
                  MyErrorView(error: error, retry: retry)
                      .font(.system(size: 16))
                },
                content: { MyPagingContentView(result: $0) }
              )
            )
          }
        )
          .minItemSize(.init(width: 100, height: 200)) // (80, 80) by default
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
        VStack {
          LBJPagingMediaBrowser(
            browser: browser,
            placeholder: { MyPlaceholderView(media: $0) },
            progress: {
              MyProgressView(progress: $0)
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
            },
            failure: { error, retry in
              MyErrorView(error: error, retry: retry)
                  .font(.system(size: 16))
            },
            content: { MyPagingContentView(result: $0) }
          )
          HStack {
            Spacer()
            Button {
              browser.setCurrentPage(browser.currentPage - 1)
            } label: {
              Text("Prev")
            }
            Spacer()
            Button {
              browser.setCurrentPage(Int.random(in: 0..<browser.medias.count))
            } label: {
              Text("Random")
            }
            Spacer()
            Button {
              browser.setCurrentPage(browser.currentPage + 1)
            } label: {
              Text("Next")
            }
            Spacer()
          }
        }
      }
  }
}
