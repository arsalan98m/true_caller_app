# true_caller_app

## Structure of code

1. I used MVVM architecture for the project
2. All Of our screen are present inside the feature folder.
3. Inside the Main Folder our routes are defined and initial our app starts with app.dart file where our initial route is defined which is splash screen.
4. On the same Main folder inside main.dart file our initial app logic will starts on this files.
5. Inside main.dart file, the initializeService handler is defined and it will trigger background service
   and inside home model the function getCallLogs was called and if there is any preserved data then it will fetched and after 10 seconds the calls are generating and preserving on local storage.

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
