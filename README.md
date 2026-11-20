# Calley App

## Project Description

Calley is a Flutter-based mobile application designed to manage user authentication and calling activities. The project integrates REST APIs to handle user registration, login, OTP verification, and dashboard navigation.

## Key Features

1. **User Registration:** Allows new users to create an account using their name, email, password, and mobile number.
2. **OTP Verification:** Sends an OTP to the user's WhatsApp number and verifies the OTP before granting access.
3. **User Login:** Allows existing users to log in using their registered email and password.
4. **Dashboard:** Provides access to the application's main dashboard after successful authentication.
5. **Logout:** Allows users to log out and return to the authentication screens.

## Application Flow

1. **Registration:** New users enter their details and submit the registration form.
2. **OTP Verification:** The app sends an OTP to the registered WhatsApp number. Users must enter the correct OTP to verify their account.
3. **Dashboard:** After successful verification, users are redirected to the dashboard.
4. **Login:** Existing users can log in using their email and password to access the dashboard.
5. **Logout:** Users can log out and return to the login screen.

## Technical Implementation

- **Framework:** Flutter
- **Programming Language:** Dart
- **API Integration:** REST APIs using Dio
- **Authentication:** Registration, login, and WhatsApp OTP verification
- **Navigation:** Screen-based navigation
- **Platform:** Android, iOS

## Project Objective

To develop a functional Flutter mobile application with API-based authentication, OTP verification, and dashboard navigation while maintaining a structured and user-friendly interface.
