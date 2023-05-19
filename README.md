# Vending Machine Provider

This Flutter application, named Vending Machine Provider, provides a vending machine experience where users can browse and purchase products from different categories. The app integrates with a remote API to fetch product data, which is then stored locally using the `sqflite` package for offline access and improved performance. It utilizes the provider package for state management following the MVVM (Model-View-ViewModel) architecture.

## Features

- **Data Fetching:** Upon starting the app, data is fetched from a remote API. The API contains products from four different categories.
- **Local Persistence:** The fetched data is then stored locally using the `sqflite` package, allowing for offline access and improved performance.
- **Category Selection:** The first screen of the app displays all available categories. Users can choose a category to view the products within that category.
- **Product Listing:** The second screen displays all the products from the selected category. Users can browse through the available products.
- **Selling Page:** The third screen represents the selling page, where users can insert specific coins (0.10, 0.20, 0.50, 1). As the customer inserts the correct coins, the entered amount is displayed. Once the accumulated amount is enough to buy the selected product, the purchase is finalized. The respective change is provided, and the product quantity is updated in the database.
- **Product Availability Handling:** If a customer purchases the last available product of a specific type, they are navigated out of the selling page and prompted with a snackbar to collect their change.
- **Navigation Flow:** Upon returning to the second screen, if there are no more products of the same category available, users are prompted to choose a different category.
- **Refill Option:** If there are no products in the vending machine, users are informed about the situation and offered a free refill option. Choosing the refill option restarts the process.
- **Navigation Gestures:** Navigating out of the app is accomplished by a double tap gesture, and a snackbar is displayed to prompt the user before exiting.
## Getting Started

To run the **Vending Machine Provider** app on your local machine, follow these steps:

1. Ensure that you have Flutter installed on your system. You can refer to the official Flutter documentation for instructions on how to install Flutter: [Flutter - Get Started](https://flutter.dev/docs/get-started)
2. Clone this repository to your local machine using the following command:
'''
git clone https://github.com/storeIt/vending_machine_provider.git
'''
3. Open the project in your preferred Flutter IDE (e.g., Android Studio, Visual Studio Code).
4. Run the app on an emulator or a physical device using the `flutter run` command or the run option in your IDE.

Feel free to explore and enjoy the vending machine experience provided by the app!

## Acknowledgments

The **Vending Machine Provider** app was developed as a demonstration of Flutter's capabilities and the use of the `provider` package as a state management solution following the MVVM architecture. It incorporates various features and functionality to provide a realistic vending machine experience.