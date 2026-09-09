# Souq App (سوق)

A modern, full-featured e-commerce Flutter application built using Clean Architecture, Riverpod state management, and Firebase Cloud Messaging (FCM) for push notifications.

---

##  Architecture

This project strictly follows **Clean Architecture** combined with **Feature-First Project Structure** to ensure testability, scalability, and loose coupling.

```text
lib/
├── core/                       # Shared app-wide resources
│   ├── localization/           # L10n & i18n support (English & Arabic)
│   ├── network/                # Dio client configuration & interceptors
│   ├── notification/           # FCM initialization & push notification handlers
│   ├── routing/                # GoRouter routing setup
│   └── theme/                  # Material 3 light/dark themes
│
└── features/                   # Feature modules
    ├── cart/                   # Cart state & local storage datasources
    ├── favorites/              # Wishlist / Favorites feature
    └── products/               # Product catalog, search, and filtering
        ├── data/               # Data sources, Models, & Repository implementations
        ├── domain/             # Entities, Repository interfaces, & Use Cases
        └── presentation/       # UI Screens, Widgets, & Riverpod Notifiers/Providers

```

### Key Architectural Layers:

* **Domain Layer**: Contains pure business logic, domain entities (`ProductEntity`), and abstract repository contracts.
* **Data Layer**: Implements repository interfaces, handles API requests via `DioClient`, and manages local persistent storage (e.g., `SharedPreferences`).
* **Presentation Layer**: Built with **Flutter Riverpod** (`NotifierProvider`, `FutureProvider`, `ConsumerWidget`) to manage UI state and reactively render screens.

---

## How to Run the App

### Prerequisites

* **Flutter SDK**: `>=3.0.0` (ensure `flutter doctor` passes).
* **Android Studio / Xcode** for emulators or physical testing devices.
* **Java**: Compatible JDK (Java 17 supported).

### Setup Steps

1. **Clone the repository**:
```bash
git clone https://github.com/Marah31/souq_app.git
cd souq_app

```


2. **Install dependencies**:
```bash
flutter pub get

```


3. **Verify/Generate Localization Files** *(if required)*:
```bash
flutter gen-l10n

```


4. **Run the App**:
```bash
flutter run

```



---

## Testing FCM Push Notifications

The app supports 3 notification states (Foreground, Background, and Terminated) using Firebase Cloud Messaging.

### Step 1: Obtain your Device FCM Token

1. Run the app on a physical device or emulator with **Google Play Services**.
2. Grant notification permissions when prompted.
3. Check your VS Code terminal log for the output:
```text
==================================================
FCM DEVICE TOKEN: <THE_COPIED_DEVICE_TOKEN>
==================================================

```



### Step 2: Send a Test Notification from Firebase Console

1. Go to the [Firebase Console](https://console.firebase.google.com/) and select your project.
2. In the left navigation menu, go to **Engage** $\rightarrow$ **Messaging**.
3. Click **Create your first campaign** (or **New campaign**) and choose **Firebase Notification messages**.
4. Fill in the **Notification Title** and **Notification Text**.
5. On the right panel, click **Send test message**.
6. Paste your copied **FCM Device Token** into the field, click the **`+`** icon to add it, and press **Test**.

>  **Tip for Background / Terminated Testing**: Minimize the app (press Home) or completely close/kill the app on your device before clicking **Test** to view the system tray notification banner.
