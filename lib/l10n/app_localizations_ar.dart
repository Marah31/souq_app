// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get searchProduct => 'ابحث عما ترغب به';

  @override
  String get all => 'حميع المنتجات';

  @override
  String get electronics => 'الكترونيات';

  @override
  String get jewelery => 'مجوهرات';

  @override
  String get mensClothing => 'ملابس رجالية';

  @override
  String get womensClothing => 'ملابس نسائية';

  @override
  String get homePage => 'الصفحة الرئيسة';

  @override
  String get cart => 'العربة';

  @override
  String get favorite => 'مفضلاتي';

  @override
  String get total => 'المبلغ الكلي';

  @override
  String get shipping => 'تكاليف الشحن';

  @override
  String get myCart => 'عربتي';

  @override
  String get savedItems => 'المحفوظات';

  @override
  String get favoriteEmpty => 'قائمتك المفضلة فارغة';

  @override
  String get favoriteEmptySubMessage => 'اضغط على أيقونة القلب على أي منتج لحفظها هنا';

  @override
  String get explore => 'استكشف';

  @override
  String get clearCart => 'حذف السلة';

  @override
  String get free => 'مجاني';

  @override
  String get appTitle => 'سوق';

  @override
  String get switchLanguage => 'تغيير اللغة';

  @override
  String get toggleTheme => 'تغيير السمات';

  @override
  String get errorMessageNoProductSearch => 'لا يوجد منتجات تطابق البحث الخاص بك';

  @override
  String get retry => 'Try Again';

  @override
  String get errorMessageTitle => 'حدث خطأ';

  @override
  String get errorMessageSubtitle => 'لا يمكن تحميل المنتجات، الرجاء التأكد من اتصالك بالإنترنت';

  @override
  String get noProductsFound => 'لم يتم العثور على المنتجات';

  @override
  String get noProductsFoundSubtitle => 'جرب استخدام كلمات مفتاحية أو تصنيفات أخرى';

  @override
  String get clearFilters => 'مسح الفلتر';

  @override
  String get addToCart => 'إضافة إلى السلة';

  @override
  String get viewCart => 'عرض السلة';

  @override
  String addedToCart(String title) {
    return 'تم إضافة $title إلى السلة';
  }

  @override
  String get description => 'الوصف';

  @override
  String get productNotFound => 'المنتج غير موجود';

  @override
  String get goBack => 'تراجع';

  @override
  String get cartEmpty => 'العربة فارغة';

  @override
  String get cartEmptySubMessage => 'يبدو أنك لم تضف أي منتج في العربة بعد';

  @override
  String get startShopping => 'ابدأ بالتسوق';

  @override
  String get freeShippingMessage => 'لقد حصلت على شحن مجاني!';

  @override
  String get checkout => 'شراء';

  @override
  String get subtotal => 'المبلغ الإجمالي';

  @override
  String get add => 'أضف';

  @override
  String get items => 'منتج';

  @override
  String get shippingProgress => 'إضافي لتحصل على شحن مجاني!';

  @override
  String get priceLowToHigh => 'السعر: منخفض إلى مرتفع';

  @override
  String get priceHighToLow => 'السعر: مرتفع إلى منخفض';

  @override
  String get ratingHighToLow => 'الأعلى تقييمًا';

  @override
  String get sortProduct => 'ترتيب المنتجات';

  @override
  String get defaultSort => 'تلقائي';
}
