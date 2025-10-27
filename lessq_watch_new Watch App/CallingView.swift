import SwiftUI
internal import Combine

struct CallingView: View {
    @State private var currentTime = Date()
    @Environment(\.dismiss) private var dismiss
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: geometry.size.height * 0.05) {
                    // Header with "Find" and time
                    HStack {
                        Text("Find")
                            .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                            .foregroundColor(.white)

                        Spacer()

                        Text(timeFormatter.string(from: currentTime))
                            .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top, -30)

                    Spacer()

                    // Calling status
                    VStack(spacing: geometry.size.height * 0.02) {
                        Text("Calling...")
                            .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                            .foregroundColor(.gray)

                        Text("119 Emergency Service")
                            .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    Spacer()
                    Spacer()
     



                    // Cancel call button (red circle with phone icon)
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)

                            Image(systemName: "phone.fill")
                                .font(.system(size: geometry.size.width * 0.1))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(135))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer()
                }
            }
            .onReceive(timer) { input in
                currentTime = input
            }
        }
        .navigationBarHidden(true)
    }
}

struct CallingView_Previews: PreviewProvider {
    static var previews: some View {
        CallingView()
    }
}
