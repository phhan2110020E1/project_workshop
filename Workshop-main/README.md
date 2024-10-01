Workshop Project 04 - Installation and Usage Guide
Prerequisites
Before getting started, make sure you have the following software installed on your machine:

Java Development Kit (JDK) for Java Spring Boot.
Node.js and npm for Next.js.
Flutter SDK for mobile development.
An Integrated Development Environment (IDE) for Java and JavaScript/TypeScript.
Backend (Java Spring Boot)
Step 1: Clone the Repository
bash
Copy code
git clone <repository-url>
cd <project-folder>
Step 2: Configure Email
Update the application.properties file in the backend project with the provided workshop email credentials:

properties
Copy code
spring.mail.username=workshopproject04@gmail.com
spring.mail.password=iebqtqjsfqzskuyf
Step 3: Run the Backend
bash
Copy code
./mvnw spring-boot:run
The backend should now be running at http://localhost:8080.

Frontend (Next.js)
Step 4: Navigate to Frontend Folder
bash
Copy code
cd frontend
Step 5: Install Dependencies
bash
Copy code
npm install
Step 6: Configure API Endpoint
Update the NEXT_PUBLIC_API_URL in the .env.local file with the backend API URL:

env
Copy code
NEXT_PUBLIC_API_URL=http://localhost:8080/api
Step 7: Run the Frontend
bash
Copy code
npm run dev
The Next.js frontend should now be accessible at http://localhost:3000.

Mobile (Flutter)
Step 8: Navigate to Mobile Folder
bash
Copy code
cd mobile
Step 9: Run the App
bash
Copy code
flutter run
Ensure an emulator or physical device is connected. The Flutter app should launch on the device.

Testing Payment Accounts
Use the provided test accounts for payment testing.

Customer Accounts
Email: userAccountPoor@gmail.com / userAccountRich@gmail.com
Password: Matkhau1
Store Account
Email: workshopproject04@gmail.com
Password: Matkhau1
Visit PayPal Sandbox Activity to view payment results.

Conclusion
The Workshop Project 04 is now set up with the backend, frontend, and mobile components ready to use. Refer to the specific sections for any troubleshooting or additional information. Happy coding!
