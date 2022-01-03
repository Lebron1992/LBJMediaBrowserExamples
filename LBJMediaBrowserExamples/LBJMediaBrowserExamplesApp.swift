import SwiftUI
import LBJMediaBrowser

@main
struct LBJMediaBrowserExamplesApp: App {

  let mediaBrowserEnvironment = LBJMediaBrowserEnvironment()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.mediaBrowserEnvironment, mediaBrowserEnvironment)
    }
  }
}
