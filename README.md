**Dummy Product App**

This App is an **iOS** application built using **SwiftUI** and follows the **Clean Architecture** principles. It allows users to explore various products, view detailed product information, and enjoy a smooth, intuitive UI experience.

📌 **Features**

1. View different products
2. View product detail
3. MVVM architecture with protocol-oriented programming (POP)

🏗️ **Architecture**

This project follows Clean Architecture with the following layers:

🔹 **Presentation Layer**

Handles the UI using SwiftUI and manages user interactions through ViewModels following the MVVM pattern.

🔹 **Domain Layer**

Contains the business logic, use cases, and protocols that define interactions between the presentation and data layers.

🔹 **Data Layer**

Responsible for fetching data from APIs or local storage using repositories.

🔧 **Requirements**

      1. Xcode: Version: 16+
      2. Swift:Version: 5+
      3. iOS Deployment Target: Version: 16.2+
      4. macOS: Sequoia 15.5
      
      

🚀 **Getting Started**

1️⃣ **Clone the Repository**

    git clone https://github.com/ashpal4/DemoProductApp.git
    cd DemoProductApp

2️⃣ **Install Dependencies**

The app uses Swift Package Manager (SPM) for dependencies. Open the project in Xcode, and it will fetch the required packages automatically.

3️⃣ **Build & Run**

1. Open DemoProductApp.xcodeproj in Xcode

2. Select an iOS Simulator or your device

3. Press Cmd + R to build and run

🛠️ **Technologies Used**

1. SwiftUI - UI framework for declarative and reactive UI

2. Combine - Handle asynchronous and event-driven code

3. URLSession - Networking

🧪 **Testing**

This project includes:
1. Unit Tests
2. Snapshot testing (tested on iPhone 16 Pro with iOS 18.5)

✅ **Run Tests**

    Cmd + U

📊 **Check Code Coverage**

1. Open Xcode
2. Go to Product → Test (Cmd + U)
3. Open Report Navigator (Cmd + 9)
4. Select the latest test run and check Code Coverage

🤝 **Contributing**

Contributions are welcome! Feel free to open issues or submit pull requests to enhance the project.
