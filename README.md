
# ShopEasy – Flutter E-Commerce App

![ShopEasy Banner](assets/images/app_banner.png)

**ShopEasy** is a full-featured e-commerce mobile app built using Flutter. It serves as a modern, portfolio-worthy example of mobile app development with clean architecture, state management, and a smooth user experience.

---

## ✨ Features

### 🛒 Core Functionality
- **Product Catalog** – Browse products by categories
- **Product Details** – Detailed view with description and pricing
- **Search** – Quickly find items using keyword search
- **Shopping Cart** – Add, remove, and update quantities
- **Checkout** – Multi-step checkout with dummy payment UI
- **Order History** – View past orders and their statuses
- **User Profile** – Manage account details and settings

### ⚙️ Technical Highlights
- Modular architecture with proper separation of concerns
- State management using `Provider`
- Fully responsive UI for all screen sizes
- Custom reusable widgets for consistency
- Built-in error handling and loading indicators
- Material Design 3 compliance for a modern look

---

## 📸 Screenshots

| Home | Product Details | Cart |
|------|------------------|------|
| ![Home](assets/screenshots/home.png) | ![Details](assets/screenshots/product_detail.png) | ![Cart](assets/screenshots/cart.png) |

| Search | Checkout | Orders |
|--------|----------|--------|
| ![Search](assets/screenshots/search.png) | ![Checkout](assets/screenshots/checkout.png) | ![Orders](assets/screenshots/orders.png) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code with Flutter plugins
- Emulator or physical device

### Installation

Clone the repository:
```bash
git clone https://github.com/yourusername/shopeasy-flutter.git
cd shopeasy-flutter
````

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── core/                # Core utilities and constants
│   ├── constants/       # Colors, strings, etc.
│   └── utils/           # Helper functions
│
├── features/            # Modular feature directories
│   ├── auth/            # Authentication flow
│   ├── cart/            # Cart logic and UI
│   ├── checkout/        # Checkout process
│   ├── home/            # Home page and product feed
│   ├── orders/          # Order viewing and history
│   ├── product/         # Product models and logic
│   ├── product_detail/  # Detailed product view
│   ├── profile/         # User profile management
│   └── search/          # Product search
│
├── main.dart            # App entry point
└── routes.dart          # App routing
```

---

## 📦 Dependencies

| Package                                                                 | Description            |
| ----------------------------------------------------------------------- | ---------------------- |
| [`provider`](https://pub.dev/packages/provider)                         | State management       |
| [`intl`](https://pub.dev/packages/intl)                                 | Date/number formatting |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | Network image caching  |
| [`flutter_credit_card`](https://pub.dev/packages/flutter_credit_card)   | UI for card input      |
| [`badges`](https://pub.dev/packages/badges)                             | Badge overlays         |
| [`flutter_slidable`](https://pub.dev/packages/flutter_slidable)         | Swipe actions on lists |

---

## 🤝 Contribution

Contributions are welcome! Follow these steps:

1. Fork this repository
2. Create your branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add feature'`
4. Push to your branch: `git push origin feature/my-feature`
5. Open a Pull Request


## 🙏 Acknowledgments

* [Flutter](https://flutter.dev)
* [Material Design](https://material.io)
* All the amazing open source packages used

```
