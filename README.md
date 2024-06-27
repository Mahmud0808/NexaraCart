# ✨ NexaraCart
This repository contains a fully production-ready full-stack eCommerce application, designed for scalability and performance. The platform includes a robust admin panel, providing seamless management of products, orders, and users.

## Screenshots 📱
<div align="center">
<img src="https://raw.githubusercontent.com/Mahmud0808/NexaraCart/main/banner.png" />
</div>

## Features 🔥

- **User Management:** Register, login, and manage user profiles.

- **Product Catalog:** Browse, search, and filter products with detailed descriptions.

- **Shopping Cart:** Add, remove, and update items in the cart.

- **Order Processing:** Secure checkout process with order history tracking.

- **Admin Panel:** Comprehensive admin dashboard for managing products, orders, and everything.

- **Notification System:** Send notifications to users directly from the admin panel.

## Architecture 🗼

This app uses [***Flutter***](https://flutter.dev/) and Provider app state management.

## Build-Tool 🧰

You need to have [Android Studio](https://developer.android.com/studio) and [Visual Studio Code](https://code.visualstudio.com/) to build this project.

## Prerequisite 📋

- Node.js

- npm

## Getting Started 🚀

### Setup:

- Go to `server_side` > `.env` > Paste your MongoDB connection string, Stripe publishable key, Stripe secret key, Razorpay API key (optional), OneSignal APP ID and OneSignal Rest API key.

- Go to `client_side` > `admin_panel` > `lib` > `utility` > `constants.dart` > Change `MAIN_URL` with your server URL if required.

- Go to `client_side` > `nexara_cart` > `lib` > `utility` > `constants.dart` > Change `SERVER_URL` and OneSignal APP ID with yours.

### Build and run:

- To run the server:
  - Open `server_side` folder with visual studio code.
  - Copy each command from `server_side` > `guides` > `README.md`.
  - Exceute one by one in terminal.

- To run the admin panel:
  - Open `admin_panel` folder with android studio.
  - Run `main.dart` on Desktop or Web. (do not run on mobile)

- To run the client app:
  - Open `nexara_cart` folder with android studio.
  - Run `main.dart` on mobile or virtual emulator.

## Contact 📩

Wanna reach out to me? DM me at 👇

Email: mahmudul15-13791@diu.edu.bd

## Credits 🤝

- [Flutter ECommerce App with Admin Panel](https://www.youtube.com/watch?v=s8lt2bc0rDQ) by rapid flutter

## Disclaimer 📋

I decided to work on this project to learn Flutter full-stack development. Just to be clear, I don't own any part of it. I simply fixed some issues and added features to improve it.
