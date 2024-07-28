# Notes App

A Flutter application designed to help users manage their notes and tasks efficiently. This app aims to provide a simple and intuitive interface for users to create, edit, and delete notes, making it easy to stay organized and focused.

# Demo Video

Watch the demo of the app here: [LinkedIn Video]()

## Features

* User authentication using Firebase Auth
* Real-time note management using Firebase Firestore
* Secure data storage and retrieval
* User-friendly interface for creating, editing, and deleting notes
* Support for multiple users

## Technologies Used

* Flutter for building the mobile application
* Firebase for authentication and data storage
* Bloc for state management
* Flutter Bloc for managing the application's state
* Clean Architecture for better code organization and maintainability
* MVVM (Model-View-ViewModel) pattern for separating UI and business logic

## Getting Started

To get started with the app, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in your preferred IDE.
3. Install the required dependencies by running `flutter pub get` in the terminal.
4. Set up your Firebase project and add the necessary configuration files to the project.
5. Run the app on an emulator or a physical device using `flutter run`.

## Project Structure

The project follows the Clean Architecture principles and MVVM pattern, structured as follows:

- **Core**: Contains shared resources and utilities.
- **Features**: Each feature has its own structure:
  - **Domain**: Contains business logic and use cases.
  - **Data**: Handles data sources, including remote and local data.
  - **Presentation**: Contains UI components and ViewModels for the feature.

## Contact Information

For any questions or feedback, please reach out to:

- **Name**: Mahmoud Hassan
- **Email**: Mahmoud Hassan@gmail.com