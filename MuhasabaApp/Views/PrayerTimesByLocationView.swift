import SwiftUI
import CoreLocation

struct PrayerTimesByLocationView: View {
    @StateObject private var locationProvider = LocationProvider()
    @StateObject private var viewModel = PrayerTimesViewModel()

    var body: some View {
        Group {
            if let loc = locationProvider.lastLocation {
                // Use coordinates directly for fetching. Reverse geocode only for display.
                InnerPrayerTimesView(viewModel: viewModel, location: loc, placemark: locationProvider.lastPlacemark)
            } else if let error = locationProvider.errorMessage {
                VStack(spacing: 12) {
                    Image(systemName: "location.slash")
                        .font(.system(size: 28, weight: .semibold))
                    Text("Location Unavailable")
                        .font(.headline)
                    Text(error)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    Button("Retry") { locationProvider.request() }
                        .buttonStyle(.borderedProminent)
                }
                .padding()
            } else {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Determining your location…")
                        .foregroundStyle(.secondary)
                }
                .onAppear { locationProvider.request() }
            }
        }
        .navigationTitle("Prayer Times")
    }
}

private struct InnerPrayerTimesView: View {
    @ObservedObject var viewModel: PrayerTimesViewModel
    let location: CLLocation
    let placemark: CLPlacemark?

    @State private var hasFetched = false

    var body: some View {
        PrayerTimesView(
            city: placemark?.locality ?? "",
            country: placemark?.isoCountryCode ?? "",
            state: placemark?.administrativeArea,
            date: nil,
            method: viewModel.method,
            school: viewModel.school,
            timeZoneIdentifier: placemark?.timeZone?.identifier
        )
        .task(id: location.coordinate.latitude.description + "," + location.coordinate.longitude.description) {
            guard !hasFetched else { return }
            hasFetched = true
            await viewModel.fetch(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    NavigationStack { PrayerTimesByLocationView() }
}
