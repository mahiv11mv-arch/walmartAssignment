
# Countries SOLID (UIKit) — Drop-in Sources

This zip contains the **UIKit SOLID** implementation files only (no .xcodeproj). Add them into a fresh Xcode project.

## Quick Setup (Xcode 15+)

1. **Create** a new iOS App project (UIKit, App life cycle). Name it e.g. `CountriesSOLID`.

2. **Delete** the template ViewController/Storyboard files (we use programmatic UI).

3. **Add Files to Project…** and select the contents of this zip:

   - `App/` (AppDelegate, SceneDelegate)

   - `Presentation/` (Coordinator, ViewController, Cell, States)

   - `Domain/`, `Data/`

   - Optionally `Tests/` (update `@testable import YourAppModuleName` to your module name)

4. **Build & Run** (⌘R). You should see the Countries list after it fetches.


## Notes

- **Dependency Injection** at `AppCoordinator` is the composition root.

- **Dynamic Type** and accessible labels supported.

- **Rotation/iPad** works via self-sizing table cells.

- **Search** filters by *name* or *capital* per keystroke.

