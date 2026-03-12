# Referral Management System – Mobile Application MVP

## Overview

The **Referral Management System (RMS) Mobile Application** is a healthcare mobile platform designed to improve the management of patient referrals between healthcare facilities. The system replaces manual paper-based referral processes with a structured digital workflow, enabling healthcare workers to register patients, create referrals, and track referral outcomes efficiently.

The mobile application is built using **Flutter** and supports an **offline-first architecture**, allowing healthcare workers to continue using the application even when internet connectivity is unavailable. Patient and referral data are stored locally using **SQLite** and synchronized with a central backend server when connectivity becomes available.

This system is designed to support **frontline healthcare workers**, such as nurses and clinicians working in clinics and health centers, especially in environments with limited internet connectivity.

---

# Key Features

The Mobile MVP includes the following core features:

* Secure user authentication (Login)
* Patient registration and management
* Referral creation
* Referral tracking
* Local offline data storage using SQLite
* Offline-first data entry
* Data synchronization with backend server
* Referral dashboard for quick overview

These features form the foundation of a **real-world healthcare referral management system**.

---

# MVP Features Implemented

✔ Login
✔ Patient Registration
✔ Referral Creation
✔ Referral Tracking
✔ SQLite Offline Database
✔ Offline Storage
✔ Sync Service
✔ Dashboard

This represents a **real MVP architecture used in production mobile applications**.

---

# Technology Stack

## Mobile Application

* **Framework:** Flutter
* **Language:** Dart
* **Local Database:** SQLite
* **Networking:** REST API
* **Connectivity Detection:** connectivity_plus
* **Secure Storage:** SharedPreferences

## Backend (For Future Integration)

* Node.js / NestJS
* PostgreSQL
* REST APIs

---

# Project Structure

```
referral_mobile_mvp
│
├── pubspec.yaml
│
└── lib
    │
    ├── main.dart
    │
    ├── models
    │   ├── patient_model.dart
    │   └── referral_model.dart
    │
    ├── services
    │   ├── auth_service.dart
    │   ├── database_service.dart
    │   ├── patient_service.dart
    │   ├── referral_service.dart
    │   └── sync_service.dart
    │
    ├── screens
    │   ├── login_screen.dart
    │   ├── dashboard_screen.dart
    │   ├── patient_registration_screen.dart
    │   ├── create_referral_screen.dart
    │   └── referral_tracking_screen.dart
    │
    └── utils
        └── connectivity_service.dart
```

---

# System Architecture

The system follows a **layered architecture** to separate responsibilities within the application.

### Presentation Layer

Contains all UI components and screens including:

* Login Screen
* Dashboard
* Patient Registration
* Referral Creation
* Referral Tracking

### Business Logic Layer

Handles application logic including:

* Authentication service
* Patient service
* Referral service
* Sync service

### Data Layer

Handles local data storage and backend communication:

* SQLite local database
* REST API communication
* Offline synchronization logic

---

# Database Schema (SQLite)

The mobile application stores data locally in **SQLite** before synchronizing with the central system.

## Patients Table

| Field   | Type    |
| ------- | ------- |
| id      | Integer |
| name    | Text    |
| age     | Integer |
| gender  | Text    |
| phone   | Text    |
| address | Text    |
| notes   | Text    |
| synced  | Integer |

## Referrals Table

| Field          | Type    |
| -------------- | ------- |
| id             | Integer |
| patient_id     | Integer |
| hospital       | Text    |
| priority       | Text    |
| clinical_notes | Text    |
| status         | Text    |
| synced         | Integer |

---

# Offline-First Design

Many healthcare facilities operate in environments with unreliable internet connectivity. To address this challenge, the application implements an **offline-first architecture**.

### Offline Capabilities

* Register patients offline
* Create referrals offline
* Store updates locally
* Queue unsynchronized records

All offline data is stored in the **SQLite local database**.

---

# Data Synchronization

When internet connectivity becomes available, the mobile application automatically synchronizes local data with the central backend server.

### Synchronization Process

1. The mobile application detects internet connectivity.
2. The application checks the SQLite database for unsynchronized records.
3. Patient and referral data are sent to the backend server via REST APIs.
4. The backend validates the received data.
5. Records are stored in the central PostgreSQL database.
6. The mobile application marks records as synchronized.

This ensures that no patient or referral information is lost.

---

# Application Workflow

The mobile application follows a structured workflow:

1. A healthcare worker logs into the application.
2. The healthcare worker registers a patient.
3. The healthcare worker creates a referral.
4. If the device is offline, the data is stored locally.
5. Once internet connectivity is available, the system synchronizes the data.
6. Hospitals review the referral.
7. Hospitals send feedback after treatment.
8. Healthcare workers receive the feedback through the mobile application.

---

# Installation Guide

### 1. Clone the Repository

```
git clone https://github.com/kingfillari/referral_mobile_mvp
```

### 2. Navigate to the Project

```
cd referral_mobile_mvp
```

### 3. Install Dependencies

```
flutter pub get
```

### 4. Run the Application

```
flutter run
```

---

# Future Improvements

The MVP focuses on the essential features required to digitize patient referrals. Future versions of the system may include:

* SMS notifications
* GPS location tracking
* Ambulance coordination
* Real-time chat between facilities
* Telemedicine integration
* Advanced analytics dashboard
* Electronic health record integration
* HL7 FHIR interoperability standards

---

# Security Considerations

The system includes several security mechanisms to protect patient data:

* Secure authentication
* Token-based session management
* Encrypted API communication
* Data validation
* Controlled access to patient information

These measures help ensure compliance with healthcare data protection requirements.

---

# Target Users

The mobile application is designed for:

* Nurses
* Healthcare workers
* Clinicians
* Referral coordinators
* Health center staff

These users interact directly with the system to manage patient referrals.

---

# License

This project is released for educational and research purposes. Future versions may include licensing and deployment considerations for healthcare institutions.

---

# Author

**Fillimon (KingFillari)**
Software Developer | CEO & Co-Founder Aspirant
Focus Areas: AI, Healthcare Systems, Scalable Software Platforms

---

# Conclusion

The **Referral Management System Mobile MVP** provides a practical solution for improving the management of patient referrals in healthcare systems. By digitizing referral workflows and supporting offline operations, the system enhances communication between healthcare facilities and ensures continuity of patient care.

The use of **Flutter for cross-platform mobile development and SQLite for offline storage** ensures that the application is scalable, reliable, and suitable for deployment in environments with limited connectivity.

This MVP forms the foundation for a **comprehensive digital healthcare referral ecosystem**.
