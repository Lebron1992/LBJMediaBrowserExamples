import SwiftUI

struct MyProgressView: View {
  let progress: Float

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 1)
      Sector(
        startAngle: .degrees(0 - 90),
        endAngle: .degrees(360 * Double(progress) - 90)
      )
        .padding(2)
    }
  }
}

struct Sector: Shape {
  let startAngle: Angle
  let endAngle: Angle

  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
    let radius = min(rect.width, rect.height) / 2
    var path = Path()
    path.move(to: center)
    path.addArc(
      center: center,
      radius: CGFloat(radius),
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: false
    )
    path.closeSubpath()
    return path
  }
}

#if DEBUG
struct MyProgressPreviews: PreviewProvider {
  static var previews: some View {
    MyProgressView(progress: 0.4)
      .frame(width: 100, height: 100)
      .foregroundColor(.white)
      .padding()
      .background(Color.black)
  }
}
#endif

