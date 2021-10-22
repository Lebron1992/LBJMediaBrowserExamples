import SwiftUI

struct MyErrorView: View {
  let error: Error

  var body: some View {
    GeometryReader { geometry in
      Text(error.localizedDescription)
        .foregroundColor(.white)
        .padding(4)
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}
