import SwiftUI
internal import Combine

struct FindView: View {
    @State private var currentTime = Date()
    @State private var arrowRotation: Double = 45 // Angle for the arrow direction
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 5) {
                // Header
                HStack {
                    Text("Find")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer()

                // Yellow indicator dot
                Circle()
                    .fill(Color(red: 0.8, green: 0.95, blue: 0.3))
                    .frame(width: 30, height: 30)
                    .padding(.bottom, 20)
                    .padding(.leading, 50)

                // Navigation arrow
                ZStack {
                    // Arrow shape using custom path
                    ArrowShape()
                        .fill(Color.white)
                        .frame(width: 150, height: 60)
                        .rotationEffect(.degrees(arrowRotation))
                }
                .padding(.vertical, 5)

                // Distance display
                Text("08m")
                    .font(.custom("Poppins-SemiBold", size: 15))
                    .foregroundColor(.white)

                Spacer()

                // Page indicator
//                HStack(spacing: 8) {
//                    Circle()
//                        .fill(Color.gray)
//                        .frame(width: 6, height: 6)
//                    Circle()
//                        .fill(Color.gray)
//                        .frame(width: 6, height: 6)
//                    Circle()
//                        .fill(Color.white)
//                        .frame(width: 6, height: 6)
//                }
                .padding(.bottom, 10)
            }
        }
        .onReceive(timer) { input in
            currentTime = input
        }
    }
}

// Custom arrow shape with tail
struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // Rectangular tail (bottom part)
        let tailWidth: CGFloat = 2
        let tailHeight = height * 0.9
        path.addRect(CGRect(
            x: (width - tailWidth) / 2,
            y: height - tailHeight,
            width: tailWidth,
            height: tailHeight
        ))

        // Left line of arrow (chevron)
        path.move(to: CGPoint(x: width * 0.3, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.5, y: 0))

        // Right line of arrow (chevron)
        path.move(to: CGPoint(x: width * 0.7, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.5, y: 0))

        return path.strokedPath(StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
