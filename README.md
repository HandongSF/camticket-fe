# 🎫 CamTicket - Campus Performance Ticketing System
A backend API system for booking performances and events on the Handong Global University campus.

## 📋 Project Overview
CamTicket is a ticketing system designed to manage various on-campus performances such as musicals, plays, and concerts. It enables club managers to register performances and provides students with a convenient booking experience.

## 🚀 Key Features
### 🎭 Performance Management
- Register Performances: Club managers can create and manage performance posts.
  
- Session Management: Supports multiple performance sessions and schedules.

- Seat Management: Supports both assigned and open seating formats.

- Image Management: Upload profile and detail images via AWS S3 integration.

### 🎟️ Booking System
- Multiple Ticket Options: Allows simultaneous booking of various ticket types (e.g., General, Freshman).

- Seat Selection: Real-time seat availability checking and selection.

- Reservation Status Flow: Transitions between PENDING → APPROVED → REFUNDED.

- Bank Account Information: Collects account details for payment verification.

### 👥 User Management
- Kakao Login: OAuth2-based easy login with Kakao.

- Role Management: Roles include general user, club manager, and system admin.

- Profile Management: Users can edit nickname, bio, and profile image.

### 📊 Admin Features
- Reservation Overview: View reservation requests per performance.

- Approve/Reject Reservations: Change status based on payment verification.

- Refund Management: Approve or deny refund requests.

## 🛠️ Tech Stack
Frontend
Language: Dart

Framework: Flutter

Version Control: Git & GitHub
---
CamTicket – For a Better Campus Performance Culture 🎭✨
