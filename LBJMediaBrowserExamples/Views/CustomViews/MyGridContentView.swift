import SwiftUI
import LBJMediaBrowser

struct MyGridContentView: View {
  let result: MediaLoadedResult

  var body: some View {
    GeometryReader { geometry in
      switch result {
      case .image(let image, let uiImage):
        view(for: image, withUIImage: uiImage, in: geometry)
      case .video(let video, let previewImage, _):
        view(for: video, withPreviewImage: previewImage, in: geometry)
      }
    }
  }

  func view(
    for image: MediaImageType,
    withUIImage uiImage: UIImage,
    in geometry: GeometryProxy
  ) -> some View {

    ZStack(alignment: .bottom) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: geometry.size.width, height: geometry.size.height)
      if let media = image as? MyMedia {
        captionView(for: media)
      }
    }
    .frame(width: geometry.size.width, height: geometry.size.height)
  }

  func view(
    for video: MediaVideoType,
    withPreviewImage previewImage: UIImage?,
    in geometry: GeometryProxy
  ) -> some View {

    ZStack(alignment: .bottom) {
      ZStack {
        if let previewImage = previewImage {
          Image(uiImage: previewImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
        }
        Image(systemName: "play.circle")
          .font(.system(size: 40, weight: .light))
          .foregroundColor(.white)
      }
      if let media = video as? MyMedia {
        captionView(for: media)
      }
    }
    .frame(width: geometry.size.width, height: geometry.size.height)
  }

  func captionView(for media: MyMedia) -> some View {
    Text(media.caption)
      .font(.system(size: 10))
      .foregroundColor(.white)
      .padding(4)
      .background(Color.gray)
  }
}
