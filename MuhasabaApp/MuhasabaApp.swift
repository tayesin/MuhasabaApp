import SwiftUI
import SwiftData

@main
struct MuhasabaApp: App {
    let container: ModelContainer = {
        do {
            let schema = Schema(versionedSchema: HabitsSchemaV2.self)
            let modelContainer = try ModelContainer(
                for: schema,
                migrationPlan: HabitsMigrationPlan.self
            )
            return modelContainer
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainPage() // or TablePage() if that's your entry
        }
        .modelContainer(container)
    }
}
