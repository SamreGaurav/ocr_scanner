📱 Flutter Assignment – Card & Passbook Parser
🚀 Overview

This project is a Flutter application that scans financial documents (Card & Passbook), extracts relevant data using OCR, and processes it using structured parsers and validation algorithms.

The application is built with Clean Architecture, BLoC state management, and follows best practices for scalability, testability, and performance.

✨ Features
🔹 Card Parser
Extracts:
Card Number
Expiry Date
Card Holder Name
Validates card number using Luhn Algorithm (Mandatory)
Handles noisy OCR input
🔹 Passbook Parser
Extracts:
Account Number
IFSC Code
Account Holder Name
Uses pattern-based parsing (Regex + heuristics)
🔹 OCR Integration
Scan image using camera or gallery
Extract raw text using Google ML Kit Text Recognition
🔹 Luhn Algorithm (Mandatory)
Validates card numbers
Ensures correctness of extracted data
🔹 State Management
Implemented using Flutter BLoC
Clear separation between UI and business logic
🔹 Clean Architecture

Project follows 3-layer architecture:

Presentation → Domain → Data

🧠 Architecture Explanation
🔸 Presentation Layer
UI Screens
BLoC (State Management)
🔸 Domain Layer
Business Logic
Use Cases
Entities
🔸 Data Layer
Parsers
Models
Data sources
📸 How Image Scanning Works
User selects image (Camera/Gallery)
Image passed to OCR service
OCR extracts raw text
Raw text passed to parser
Parser extracts structured data
