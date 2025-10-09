import SwiftUI
internal import Combine

struct EmergencyView: View {
    @State private var currentTime = Date()
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
                HStack{
                    Text("Emergency")
                        .font(.custom("Poppins-SemiBold", size: 15))
                        .foregroundColor(.red)
                    Spacer()
                }
                 
                
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer()

                // SOS Button with concentric circles
                Button(action: {
                    // SOS action
                }) {
                    ZStack {
                        // Concentric circles
                        Circle()
                            .fill(Color(red: 0.6, green: 0, blue: 0))
                            .frame(width: 180, height: 180)

                        Circle()
                            .fill(Color(red: 0.7, green: 0, blue: 0))
                            .frame(width: 160, height: 160)

                        Circle()
                            .fill(Color(red: 0.8, green: 0, blue: 0))
                            .frame(width: 140, height: 140)

                        Circle()
                            .fill(Color(red: 1, green: 0, blue: 0))
                            .frame(width: 120, height: 120)

                        Circle()
                            .fill(Color(red: 1.0, green: 0, blue: 0))
                            .frame(width: 100, height: 100)

                        // SOS text
                        Text("SOS")
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()

                // Page indicator
//                HStack(spacing: 8) {
//                    Circle()
//                        .fill(Color.gray)
//                        .frame(width: 6, height: 6)
//                    Circle()
//                        .fill(Color.white)
//                        .frame(width: 6, height: 6)
//                    Circle()
//                        .fill(Color.gray)
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

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
