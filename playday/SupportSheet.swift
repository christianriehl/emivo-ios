import SwiftUI
import SafariServices

struct SupportSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showKofi = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 52))
                    .foregroundStyle(.orange)
                    .padding(.top, 8)
                    .accessibilityHidden(true)

                VStack(spacing: 10) {
                    Text("Emivo unterstützen")
                        .font(.title2.weight(.bold))

                    Text("Emivo ist kostenlos und werbefrei. Wenn dir die App gefällt, freue ich mich über eine kleine Unterstützung – das hilft mir, sie weiterzuentwickeln.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }

                VStack(spacing: 12) {
                    Button {
                        showKofi = true
                    } label: {
                        Label("Kaffee spendieren", systemImage: "cup.and.saucer.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .controlSize(.large)
                    .accessibilityLabel("Ko-fi öffnen und Emivo unterstützen")

                    Text("Einmalig, kein Abo, kein Account nötig")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                .padding(.horizontal, 4)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fertig") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
        }
        .sheet(isPresented: $showKofi) {
            SafariView(url: AppConfiguration.kofiURL)
                .ignoresSafeArea()
        }
    }
}

private struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredControlTintColor = .systemOrange
        return vc
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

#Preview {
    SupportSheet()
}
