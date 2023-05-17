class AppConstant {
  static const String currencySymbol = '€';
  static const String confirm = 'ok';

  // CategoryPage
  static const String vendingTitle = 'Refresh yourself';
  static const String emptyVending = 'We apologize for the inconvenience, the vending machine is currently empty. \n'
      'We are working to restock it as soon as possible. Thank you for your understanding.';
  static const String emptyVendingAction = 'Free refill';
  // VendingPage
  static const String insertCoin = 'Insert coin';
  static const String reset = 'Reset';
  static const int delayBeforeReturnToHomeScreen = 15;
  static final RegExp validInputRegex = RegExp('^(0\\.(10|20|50)|1)\$');
}
