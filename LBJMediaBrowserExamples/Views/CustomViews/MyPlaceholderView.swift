import SwiftUI
import LBJMediaBrowser

struct MyPlaceholderView: View {
  let media: MediaType

  var body: some View {
    Group {
      switch media {
      case _ as MediaImageType:
        Image("image_placeholder")
      case _ as MediaVideoType:
        Image(systemName: "play.circle")
          .font(.system(size: 40, weight: .light))
          .foregroundColor(.white)
      default:
        EmptyView()
      }
    }
    .frame(width: 40, height: 40)
  }
}
