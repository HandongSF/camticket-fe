# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CamTicket is a Flutter-based campus ticketing system for performances at Handong Global University. It features Kakao login authentication, QR code ticket generation, seat selection, and separate interfaces for users (ticket buyers) and artists (performance managers).

## Common Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK
flutter build apk --release

# Clean build artifacts
flutter clean

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test
```

## Architecture Overview

### State Management
Uses Provider pattern with 20+ providers managing different aspects:
- **AuthProvider**: Manages authentication state and Kakao login
- **UserProvider**: Manages user information and roles
- **TicketProvider**: Handles ticket operations
- **SeatProvider**: Manages seat selection and availability
- **PerformanceProvider**: Manages performance listings and details

### API Integration
- **Base URL**: Configured in `lib/utility/endpoint.dart`
- **Authentication**: JWT Bearer tokens stored in secure storage
- **API Service**: `lib/utility/api_provider.dart` handles all HTTP requests
- **Headers**: All requests include UTF-8 encoding and bearer token

Example API call pattern:
```dart
final response = await apiProvider.get('/auth/user-info', requireAuth: true);
```

### Authentication Flow
1. **Kakao OAuth Login**: `lib/utility/kakaoLogin.dart`
2. **Backend Authentication**: Exchange Kakao token for JWT
3. **Token Storage**: Using `flutter_secure_storage`
4. **Auto-login**: Check stored tokens on app startup

### Project Structure
```
lib/
├── main.dart                    # App entry point
├── model/                       # Data models (User, Performance, Ticket, etc.)
├── provider/                    # State management providers
├── components/                  # Reusable UI components
│   ├── basic/                  # Basic UI elements
│   └── dialog/                 # Dialog components
├── pages/                      # Screen implementations
│   ├── artist/                 # Artist/Manager interface
│   │   ├── reservation_management.dart
│   │   ├── qr_scan_page.dart
│   │   └── performance_info_management.dart
│   ├── user/                   # User/Buyer interface
│   │   ├── ticket_list.dart
│   │   ├── ticket_purchase.dart
│   │   └── seat_selection_page.dart
│   └── common/                 # Shared pages (login, etc.)
└── utility/                    # Utilities and services
    ├── api_provider.dart       # HTTP client
    ├── endpoint.dart          # API configuration
    └── kakaoLogin.dart        # Kakao authentication
```

## Key Features Implementation

### User Roles
- **USER**: Can browse and purchase tickets
- **MANAGER**: Can create performances and scan tickets
- **ADMIN**: Full system access

### QR Code Functionality
- **Generation**: Uses `qr_flutter` package for ticket QR codes
- **Scanning**: `mobile_scanner` for ticket validation by managers

### Seat Selection
- **Real-time Updates**: WebSocket or polling for seat availability
- **Visual Grid**: Custom grid layout for seat map
- **Status Management**: Available, Selected, Sold states

### Performance Management
- **Image Upload**: Using multipart form data
- **Date/Time**: Properly formatted for API (ISO 8601)
- **Location**: Google Maps integration for venue display

## Common Issues and Solutions

### Korean Text Encoding
Always set UTF-8 encoding in API requests:
```dart
headers: {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept-Charset': 'UTF-8',
}
```

### Navigation After Login
Use `Navigator.pushAndRemoveUntil` to prevent back navigation to login:
```dart
Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MyPage()),
  (Route<dynamic> route) => false,
);
```

### Secure Storage
For sensitive data (tokens, user info):
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
const storage = FlutterSecureStorage();
await storage.write(key: 'jwt_token', value: token);
```

## API Endpoints Reference

Common endpoints used throughout the app:
- **Auth**: `/auth/login`, `/auth/user-info`, `/auth/kakao`
- **Performances**: `/performance/list`, `/performance/detail/{id}`
- **Tickets**: `/ticket/purchase`, `/ticket/list`, `/ticket/validate`
- **Seats**: `/seat/status/{performanceId}`, `/seat/select`

## Development Guidelines

1. **Provider Usage**: Always use `context.read<Provider>()` for actions and `context.watch<Provider>()` for UI updates
2. **Error Handling**: Wrap API calls in try-catch blocks and show user-friendly error messages
3. **Loading States**: Use `isLoading` flags in providers to show loading indicators
4. **Image Assets**: Store in `assets/` directory and reference in `pubspec.yaml`
5. **Date Formatting**: Use `intl` package for consistent date/time display

## Testing Considerations

- Test files should mirror the lib/ structure in test/
- Mock API responses for unit tests
- Use `flutter_test` for widget testing
- Focus on critical user flows: login, ticket purchase, QR scanning

## Security Notes

- JWT tokens expire and need refresh handling
- Never log sensitive information (tokens, passwords)
- Validate all user inputs before API calls
- Use HTTPS for all API communications