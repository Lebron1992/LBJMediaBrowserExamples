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
        LBJGridMediaBrowser(dataSource: .init(medias: viewModel.medias))

      case .customGrid:
        LBJGridMediaBrowser(dataSource: viewModel.customGridDataSource)
          .minItemSize(.init(width: 100, height: 200)) // (80, 80) by default
          .itemSpacing(4)   // 2 by default
          .browseInPagingOnTapItem(true) // true by default

      case .paging:
        let browser = LBJPagingBrowser(medias: viewModel.medias)
        LBJPagingMediaBrowser(browser: browser)
          // TODO: if ignores all edges, the internal TabView has UI issue
          .ignoresSafeArea(.all, edges: .vertical)
          .background(Color.black)

      case .customPaging:
        let browser: LBJPagingBrowser = {
          let dataSource = LBJPagingMediaBrowserDataSource(
            medias: viewModel.medias,
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
            }
          )
          let browser = LBJPagingBrowser(dataSource: dataSource)
          browser.autoPlayVideo = true
          return browser
        }()
        VStack {
          LBJPagingMediaBrowser(browser: browser)
            .background(Color.black)
          HStack {
            Spacer()
            Button {
              browser.setCurrentPage(browser.currentPage - 1)
            } label: {
              Text("Prev")
            }
            Spacer()
            Button {
              browser.setCurrentPage(Int.random(in: 0..<browser.dataSource.medias.count))
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
