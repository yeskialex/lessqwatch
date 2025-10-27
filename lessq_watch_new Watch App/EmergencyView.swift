import SwiftUI
internal import Combine

struct EmergencyView: View {
    @State private var currentTime = Date()
    @State private var navigateToCalling = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    VStack(spacing: geometry.size.height * 0.025) {
                        // Header - aligned with system time
                        HStack{
                            Text("Emergency")
                                .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, -30)
                        
                        
                        // SOS Button with concentric circles
                        Button(action: {
                            navigateToCalling = true
                        }) {
                            ZStack {
                                // Concentric circles
                                Circle()
                                    .fill(Color(red: 0.6, green: 0, blue: 0))
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9)
                                
                                Circle()
                                    .fill(Color(red: 0.7, green: 0, blue: 0))
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                                
                                Circle()
                                    .fill(Color(red: 0.8, green: 0, blue: 0))
                                    .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                                
                                Circle()
                                    .fill(Color(red: 1, green: 0, blue: 0))
                                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                                
                                Circle()
                                    .fill(Color(red: 1.0, green: 0, blue: 0))
                                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                                
                                // SOS text
                                Text("SOS")
                                    .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.1))
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
                    .navigationDestination(isPresented: $navigateToCalling) {
                        CallingView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .onReceive(timer) { input in
                    currentTime = input
                }
            }
        }
    }
    
    struct EmergencyView_Previews: PreviewProvider {
        static var previews: some View {
            EmergencyView()
        }
    }
}
