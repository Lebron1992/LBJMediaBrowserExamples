import SwiftUI
import LBJMediaBrowser

@main
struct LBJMediaBrowserExamplesApp: App {

  let mediaBrowserEnvironment: LBJMediaBrowserEnvironment = {
    let imageCache: ImageCache? = {
      let diskStorage = try? ImageDiskStorage(config: .init(
        name: "ImageCache",
        sizeLimit: 0,
        expiration: .days(7)
      ))
      let memoryStorage = ImageMemoryStorage(
        memoryCapacity: 100_000_000,
        preferredMemoryCapacityAfterPurge: 80_000_000
      )
      let cache = ImageCache(diskStorage: diskStorage, memoryStorage: memoryStorage)
      return cache
    }()
    return LBJMediaBrowserEnvironment(imageCache: imageCache)
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.mediaBrowserEnvironment, mediaBrowserEnvironment)
    }
  }
}
