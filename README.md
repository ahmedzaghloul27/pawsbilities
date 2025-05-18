# Pawsbilities App

Pawsbilities is a modern Flutter application designed to help pet owners find suitable matches for their pets, connect with the pet community, and manage their pet's social and health needs. The app provides a seamless experience for discovering, matching, and communicating with other pet owners, as well as managing your own pet's profile and preferences.

## Features

- **Pet Matching:**
  - Smart matching based on breed, location (auto-detected or set manually), and user preferences.
  - Swipe and discover potential matches for your pet.
  - Filter matches by distance, age, and more.

- **Location Services:**
  - Detects your current location using device GPS (with permission).
  - Allows manual location selection via Google Maps and search.
  - Location is used for accurate matching and can be updated anytime.

- **Pet Profiles:**
  - Create and manage detailed pet profiles with images, breed, age, and health information.
  - View other pets' profiles and connect with their owners.

- **Community & Social:**
  - Community feed for sharing updates, questions, and pet stories.
  - Like, comment, and interact with other pet owners.

- **Lost & Found:**
  - Report lost or found pets in your area.
  - Browse and help reunite pets with their owners.

- **Notifications:**
  - Stay updated with new matches, messages, and community activity.
  - Customizable notification preferences.

- **Settings & Preferences:**
  - Manage account details, security, and two-factor authentication.
  - Set and update matching preferences (distance, age range, etc.).
  - Easily update your location from the settings or matching screens.

- **Modern UI/UX:**
  - Clean, intuitive, and responsive design.
  - Optimized for both Android and iOS devices.

## Tech Stack

- **Flutter** (Dart) for cross-platform mobile development
- **Google Maps & Google Place APIs** for location and place search
- **Geolocator** for device location services
- **Stateful Widgets** for dynamic UI updates
- **Custom Widgets** for navigation, cards, and UI components

## Folder Structure
- `lib/` - Main Dart source files
  - `matching_screen.dart` - Main matching UI and logic
  - `set_location_page.dart` - Location selection and map UI
  - `settings.dart` - User settings and preferences
  - `community_page.dart`, `lost_and_found_page.dart`, etc. - Other main screens
  - `widgets/` - Custom reusable widgets


---

For more information, see the in-app Help Center or contact the development team.

---

## API Key Setup

This app uses Google Maps and Google Place APIs. To set up the API keys:

1. Copy `lib/api_keys.dart.template` to `lib/api_keys.dart`
2. Replace the placeholder values with your actual API keys
3. For Android:
   - The API key is referenced from the `api_keys.dart` file
   - Update `android/app/build.gradle` to read this value during build time
4. For iOS:
   - Update the API key in `ios/Runner/AppDelegate.swift` or `Info.plist`

**NOTE:** The `api_keys.dart` file is listed in `.gitignore` to prevent accidentally committing your API keys to the repository.
