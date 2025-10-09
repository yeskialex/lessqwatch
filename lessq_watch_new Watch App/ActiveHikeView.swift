import SwiftUI
internal import Combine

struct ActiveHikeView: View {
    @State private var currentTime = Date()
    @State private var selectedWaypoint = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 2) {
                // Header
                HStack{
                    Text("Activity")
                        .font(.custom("Poppins-SemiBold", size: 15))
                        .foregroundColor(.white)
                        .padding(.leading, 14)
                        .padding(.top, 5)
                    Spacer()
                }

                Spacer()

                // Scrollable waypoint cards
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Button(action: {
                                selectedWaypoint = 0
                                withAnimation {
                                    proxy.scrollTo(0, anchor: .center)
                                }
                            }) {
                                WaypointCard(
                                    name: "Neungwon\nTemple",
                                    distance: "500 M",
                                    isMain: selectedWaypoint == 0
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .id(0)

                            Button(action: {
                                selectedWaypoint = 1
                                withAnimation {
                                    proxy.scrollTo(1, anchor: .center)
                                }
                            }) {
                                WaypointCard(
                                    name: "Dobong\nTemple",
                                    distance: "300M",
                                    isMain: selectedWaypoint == 1
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .id(1)

                            Button(action: {
                                selectedWaypoint = 2
                                withAnimation {
                                    proxy.scrollTo(2, anchor: .center)
                                }
                            }) {
                                WaypointCard(
                                    name: "Dobong\nGarden",
                                    distance: "150M",
                                    isMain: selectedWaypoint == 2
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .id(2)
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(height: 140)

                Spacer()

                // Control buttons
                HStack(spacing: 20) {
                    // Stop button
                    Button(action: {
                        // Stop action
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.8, green: 0.95, blue: 0.3))
                                .frame(width: 50, height: 50)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black)
                                .frame(width: 15, height: 15)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Play button
                    Button(action: {
                        // Play action
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.8, green: 0.95, blue: 0.3))
                                .frame(width: 50, height: 50)

                            Image(systemName: "play.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .offset(x: 2)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 10)

                // Page indicator
//                HStack(spacing: 8) {
//                    Circle()
//                        .fill(Color.white)
//                        .frame(width: 6, height: 6)
//                    Circle()
//                        .fill(Color.gray)
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

struct WaypointCard: View {
    let name: String
    let distance: String
    let isMain: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(isMain ? Color.white : Color.gray.opacity(0.6))
                .frame(width: isMain ? 130 : 100, height: isMain ? 130 : 115)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if isMain {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 36, height: 36)

                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }

                    Spacer()

                    Text(distance)
                        .font(.custom("Poppins-SemiBold", size: isMain ? 20 : 15))
                        .foregroundColor(.black)
                }

                Spacer()

                Text(name)
                    .font(.custom("Poppins-SemiBold", size: 13))
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
            .padding(12)
        }
        .frame(width: isMain ? 130 : 100, height: isMain ? 130 : 115)
    }
}

struct ActiveHikeView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveHikeView()
    }
}
