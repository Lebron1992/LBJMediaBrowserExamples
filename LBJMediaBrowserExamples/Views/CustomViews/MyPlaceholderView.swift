import SwiftUI
import LBJMediaBrowser

struct MyPlaceholderView: View {
  let media: Media

  var body: some View {
    Group {
      switch media {
      case _ as MediaImage:
        Image("image_placeholder")
      case _ as MediaVideo:
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
