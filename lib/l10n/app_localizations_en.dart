// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchProduct => 'Search Product..';

  @override
  String get all => 'All';

  @override
  String get electronics => 'Electronics';

  @override
  String get jewelery => 'Jewelery';

  @override
  String get mensClothing => 'Men\'s Clothing';

  @override
  String get womensClothing => 'Women\'s Clothing';

  @override
  String get homePage => 'Home Page';

  @override
  String get cart => 'Cart';

  @override
  String get favorite => 'Favorite';

  @override
  String get total => 'Total';

  @override
  String get shipping => 'Shipping';

  @override
  String get myCart => 'My Cart';

  @override
  String get savedItems => 'Saved Items';

  @override
  String get favoriteEmpty => 'Your Wishlist is Empty';

  @override
  String get favoriteEmptySubMessage => 'Tap the heart icon on any item to save it here for later';

  @override
  String get explore => 'Explore';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get free => 'Free';

  @override
  String get appTitle => 'Souq';

  @override
  String get switchLanguage => 'Switch Language';

  @override
  String get toggleTheme => 'Toggle Theme';

  @override
  String get errorMessageNoProductSearch => 'No products match your criteria.';

  @override
  String get retry => 'Try Again';

  @override
  String get errorMessageTitle => 'Something Went Wrong;';

  @override
  String get errorMessageSubtitle => 'Could not load products. Please check your connection.';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get noProductsFoundSubtitle => 'Try searching with a different term or category.';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get viewCart => 'View Cart';

  @override
  String addedToCart(String title) {
    return '$title added to cart';
  }

  @override
  String get description => 'Description';

  @override
  String get productNotFound => 'Product Not Found';

  @override
  String get goBack => 'Go Back';

  @override
  String get cartEmpty => 'Your Cart it Empty';

  @override
  String get cartEmptySubMessage => 'Looks like you haven\'t added any items yet.';

  @override
  String get startShopping => 'Start Shopping';

  @override
  String get freeShippingMessage => 'You unlocked FREE Shipping!';

  @override
  String get checkout => 'Checkout';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get add => 'Add';

  @override
  String get items => 'Items';
}
