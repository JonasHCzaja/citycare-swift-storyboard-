# CityCare - iOS App (Swift)

## 📊 About the Project

CityCare is an iOS application designed to help citizens report and track urban issues in their communities. The goal is to improve communication between citizens and local authorities, ensuring quicker and more efficient responses to problems such as potholes, street lighting failures, and waste management.

## 🚀 Features

- Report and track urban issues
- Interactive map displaying reported occurrences
- Secure user authentication
- Storage and retrieval of issues using Core Data
- Clean and user-friendly interface
- Developed using Swift and Storyboard

## 🛠️ Technologies Used

- **Swift** as the main programming language
- **UIKit** for building the user interface
- **Core Data** for local data persistence
- **MapKit** for displaying occurrences on a map
- **Storyboard** for UI design and navigation

## 🎯 Project Structure

```
citycare-ios/
├── CityCare.xcodeproj/   # Xcode project files
├── CityCare/
│   ├── Controllers/      # ViewControllers for different screens
│   ├── Models/           # Data models (Core Data entities)
│   ├── Views/            # Custom UI elements and table cells
│   ├── Assets.xcassets/  # App icons and assets
│   ├── Base.lproj/       # Storyboards and UI files
│   ├── AppDelegate.swift # App lifecycle management
│   ├── SceneDelegate.swift # Scene management
│   ├── Info.plist        # Application settings
└── README.md             # Documentation
```

## ⚡ How to Run the Project

### Prerequisites

- **macOS** with Xcode installed
- **Xcode 14+**
- **iOS 15+ simulator or device**

### Steps

1. Clone the repository:

    ```sh
    git clone https://github.com/your-user/citycare-ios.git
    cd citycare-ios
    ```

2. Open the project in Xcode:

    ```sh
    open CityCare.xcodeproj
    ```

3. Select a simulator or a physical device.

4. Run the project by clicking **Run** (▶) in Xcode.

## 📌 Main Features

| Feature | Description |
|---------|------------|
| Report an Issue | Users can submit new urban issues with details. |
| View Reports | A list of submitted reports with filtering options. |
| Map View | Displays all reports on an interactive map. |
| User Authentication | Ensures secure login and access to functionalities. |

## 🎓 Academic Context

This project was developed as part of the **Analysis and Systems Development** course at **FIAP**, with the objective of applying concepts studied throughout the discipline. The development covered the following topics:

- **Swift and UIKit** for iOS app development
- **Core Data** for data persistence
- **Storyboard and Auto Layout** for interface design
- **MapKit** for geographic data visualization

#

Developed by **JonasHCzaja**.
