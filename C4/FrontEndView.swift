import SwiftUI

struct FrontEndView: View {
    @StateObject private var viewModel = FrontEndViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.1, green: 0.1, blue: 0.1).opacity(0.8))
                    .overlay(
                        VStack(spacing: 16) {
                            if let remaining = viewModel.remainingTimeFormatted {
                                Text(remaining)
                                    .font(.system(size: 36, design: .monospaced))
                                    .foregroundColor(.green)
                                    .padding(.top, 10)
                                    .padding(.horizontal)
                                    .background(Color.black.opacity(0.8))
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 2))
                            }
                            
                            HStack(spacing: 15) {
                                timeInputWithSteppers(label: String(localized: "h"), value: $viewModel.inputHours)
                                timeInputWithSteppers(label: String(localized: "m"), value: $viewModel.inputMinutes)
                                timeInputWithSteppers(label: String(localized: "s"), value: $viewModel.inputSeconds)
                            }
                            
                            HStack(spacing: 20) {
                                physicalButton(text: String(localized: "redButton"), color: .red, action: viewModel.cancelTimer)
                                physicalButton(text: String(localized: "yellowButton"), color: .yellow, action: viewModel.clear)
                                    .help(String(localized: "yellowButtonHelp"))
                                physicalButton(text: String(localized: "greenButton"), color: .green, action: viewModel.startTimer)
                            }
                            
                            Text(String(localized: "quit"))
                                .foregroundStyle(.brown)
                                .fontWeight(.thin)
                                .padding(.top)
                            
                            Text(String(localized: "developedBy"))
                                .foregroundStyle(.brown)
                                .fontWeight(.thin)
                        }
                            .padding()
                    )
                    .frame(width: 420)
                    .shadow(color: .red.opacity(0.5), radius: 10, x: 0, y: 5)
                
                
            }
            .padding()
        }
    }
    
    // Subview para entrada de tempo com botões de mais e menos
    @ViewBuilder
    private func timeInputWithSteppers(label: String, value: Binding<String>) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .foregroundColor(.brown)
                .font(.caption)
            
            HStack(spacing: 5) {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.brown)
                    .onTapGesture {
                        if var intValue = Int(value.wrappedValue) {
                            intValue = max(0, intValue - 1)
                            value.wrappedValue = String(intValue)
                        }
                    }
                
                Text(value.wrappedValue)
                    .frame(width: 50, height: 10)
                    .padding(6)
                    .background(Color.brown)
                    .cornerRadius(5)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.brown)
                    .onTapGesture {
                        if var intValue = Int(value.wrappedValue) {
                            if (intValue >= 60) {
                                return;
                            }
                            intValue += 1
                            value.wrappedValue = String(intValue)
                        }
                    }
            }
        }
    }
    
    // Subview para botões físicos
    @ViewBuilder
    private func physicalButton(text: String, color: Color, action: @escaping () -> Void) -> some View {
        VStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0.8), color]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 90, height: 115)
                .overlay(
                    ZStack {
                        Circle()
                            .stroke(color.opacity(0.6), lineWidth: 4)
                            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                        
                        Text(text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                )
                .shadow(color: color.opacity(0.7), radius: 8, x: 0, y: 4)
        }
        .onTapGesture {
            action()
        }
        .preferredColorScheme(.dark)
    }
}

