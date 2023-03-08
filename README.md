## Simple To-Do App

This is a simple to-do app built with the Flutter framework using the state management BLoC pattern and Clean Architecture principles as taught by Reso Coder.

# Features
- Add a new to-do task
- Mark a task as completed
- Delete a task
- Auth

# Getting Started
To run the app, you will need to have Flutter installed on your machine. Once you have that set up, follow these steps:

- Clone this repository.
- Open the project in your preferred IDE.
- Install the required packages by running flutter pub get in your terminal or IDE terminal.
- Run the app on a simulator or connected device by running flutter run in your terminal or IDE terminal.


# Folder Structure
The app is structured using Clean Architecture principles as follows:

- presentation/ contains the user interface and presentation logic of the app.
- domain/ contains the business logic and entities of the app.
- data/ contains the implementation of repositories and data sources used by the app.


# State Management
The BLoC pattern is used for state management in this app. The presentation/ layer contains the widgets and screens that interact with the user, while the domain/ layer contains the business logic and interfaces for data sources and repositories. The data/ layer contains the implementations of these interfaces.


# Credits
This app was built by Panca Adnan Andrian. The architecture and state management techniques used in this app were taught by Reso Coder.
