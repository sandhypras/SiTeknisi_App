import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_login_screen.dart';
import '../../features/auth/domain/auth_user.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_home_screen.dart';
import '../../features/customer/presentation/screens/customer_activity_screen.dart';
import '../../features/customer/presentation/screens/customer_profile_screen.dart';
import '../../features/customer/presentation/screens/booking/create_service_request_screen.dart';
import '../../features/customer/presentation/screens/booking/customer_flow_screens.dart';
import '../../features/customer/presentation/screens/booking/invoice_screen.dart';
import '../../features/customer/presentation/screens/booking/payment_screen.dart';
import '../../features/customer/presentation/screens/booking/review_screen.dart';
import '../../features/customer/presentation/screens/booking/technician_offers_screen.dart';
import '../../features/customer/presentation/screens/search_service_screen.dart';
import '../../features/customer/presentation/screens/service_categories_screen.dart';
import '../../features/customer/presentation/screens/service_detail_screen.dart';
import '../../features/technician/presentation/screens/technician_screens.dart';
import '../../features/technician/presentation/screens/technician_detail_screens.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const customerHome = '/customer/home';
  static const customerActivity = '/customer/activity';
  static const customerCategories = '/customer/categories';
  static const customerSearch = '/customer/search';
  static const customerProfile = '/customer/profile';
  static const customerOffers = '/customer/offers';
  static const customerPayment = '/customer/payment';
  static const customerInvoice = '/customer/invoice';
  static const customerReview = '/customer/review';
  static const customerLocation = '/customer/location';
  static const customerRequestSuccess = '/customer/request-success';
  static const customerOfferDetail = '/customer/offer-detail';
  static const customerOfferComparison = '/customer/offer-comparison';
  static const customerPaymentSuccess = '/customer/payment-success';
  static const customerTracking = '/customer/tracking';
  static const customerBookingDetail = '/customer/booking-detail';
  static const customerBookingHistory = '/customer/booking-history';
  static const customerInvoiceHistory = '/customer/invoice-history';
  static const technicianJoin = '/technician/join';
  static const technicianDashboard = '/technician/dashboard';
  static const technicianRequests = '/technician/requests';
  static const technicianJobs = '/technician/jobs';
  static const technicianEarnings = '/technician/earnings';
  static const technicianApplication = '/technician/application';
  static const technicianUploadKtp = '/technician/upload-ktp';
  static const technicianUploadProfile = '/technician/upload-profile';
  static const technicianBankInfo = '/technician/bank-info';
  static const technicianVerification = '/technician/verification';
  static const technicianRequestDetail = '/technician/request-detail';
  static const technicianCreateOffer = '/technician/create-offer';
  static const technicianCompletedJobs = '/technician/completed-jobs';
  static const technicianBankAccount = '/technician/bank-account';
  static const technicianProfile = '/technician/profile';
  static const adminLogin = '/admin/login';
  static const adminDashboard = '/admin/dashboard';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  const appMode = String.fromEnvironment('APP_MODE');
  // Only use admin web when explicitly set to 'admin'
  final useAdminWeb = kIsWeb && appMode == 'admin';
  final supabaseEnabled = ref.watch(supabaseEnabledProvider);

  return GoRouter(
    initialLocation: useAdminWeb ? AppRoutes.adminLogin : AppRoutes.splash,
    refreshListenable: supabaseEnabled
        ? GoRouterRefreshStream(ref)
        : null,
    redirect: supabaseEnabled
        ? (context, state) => _guard(ref, state)
        : null,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>
            LoginScreen(returnUrl: state.uri.queryParameters['returnUrl']),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(
          isAdmin: state.uri.queryParameters['from'] == 'admin',
        ),
      ),
      GoRoute(
        path: AppRoutes.customerHome,
        builder: (context, state) => const CustomerHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerActivity,
        builder: (context, state) => const CustomerActivityScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerCategories,
        builder: (context, state) => ServiceCategoriesScreen(
          selectedCategoryId: state.uri.queryParameters['category'],
        ),
      ),
      GoRoute(
        path: AppRoutes.customerSearch,
        builder: (context, state) => const SearchServiceScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerProfile,
        builder: (context, state) => const CustomerProfileScreen(),
      ),
      GoRoute(
        path: '/customer/services/:id',
        builder: (context, state) =>
            ServiceDetailScreen(serviceId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: '/customer/request/:serviceId',
        builder: (context, state) => CreateServiceRequestScreen(
          serviceId: state.pathParameters['serviceId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.customerOffers,
        builder: (context, state) => const TechnicianOffersScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerPayment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerInvoice,
        builder: (context, state) => const InvoiceScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerReview,
        builder: (context, state) => const ReviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerLocation,
        builder: (context, state) => const LocationPickerScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerRequestSuccess,
        builder: (context, state) => const RequestSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerOfferDetail,
        builder: (context, state) => const OfferDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerOfferComparison,
        builder: (context, state) => const OfferComparisonScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerPaymentSuccess,
        builder: (context, state) => const PaymentSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerTracking,
        builder: (context, state) => const BookingTrackingScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerBookingDetail,
        builder: (context, state) => const BookingDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerBookingHistory,
        builder: (context, state) => const BookingHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerInvoiceHistory,
        builder: (context, state) => const InvoiceHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianJoin,
        builder: (context, state) => const JoinTechnicianScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianDashboard,
        builder: (context, state) => const TechnicianDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianRequests,
        builder: (context, state) => const TechnicianRequestsScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianJobs,
        builder: (context, state) => const TechnicianJobsScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianEarnings,
        builder: (context, state) => const TechnicianEarningsScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianApplication,
        builder: (context, state) => const TechnicianApplicationFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianUploadKtp,
        builder: (context, state) =>
            const TechnicianUploadDocumentScreen(profilePhoto: false),
      ),
      GoRoute(
        path: AppRoutes.technicianUploadProfile,
        builder: (context, state) =>
            const TechnicianUploadDocumentScreen(profilePhoto: true),
      ),
      GoRoute(
        path: AppRoutes.technicianBankInfo,
        builder: (context, state) => const TechnicianBankInformationScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianVerification,
        builder: (context, state) => const TechnicianVerificationStatusScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianRequestDetail,
        builder: (context, state) => const TechnicianRequestDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianCreateOffer,
        builder: (context, state) => const TechnicianCreateOfferScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianCompletedJobs,
        builder: (context, state) => const TechnicianCompletedJobsScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianBankAccount,
        builder: (context, state) => const TechnicianBankAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.technicianProfile,
        builder: (context, state) => const TechnicianProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: '/admin',
        redirect: (context, state) => AppRoutes.adminLogin,
      ),
      GoRoute(
        path: '/admin/:section',
        builder: (context, state) => AdminDashboardScreen(
          section: state.pathParameters['section'] ?? 'dashboard',
        ),
      ),
    ],
  );
});

/// Public routes reachable without a session.
const _publicRoutes = {
  AppRoutes.splash,
  AppRoutes.onboarding,
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.forgotPassword,
  AppRoutes.adminLogin,
};

/// Katalog yang boleh ditelusuri Guest tanpa login (beranda, daftar layanan,
/// daftar/detail teknisi). Aksi transaksional di luar set ini butuh login.
const _customerPublicRoutes = {
  AppRoutes.customerHome,
  AppRoutes.customerCategories,
  AppRoutes.customerSearch,
  AppRoutes.customerOffers,
};

/// Apakah [location] dapat diakses tanpa sesi login.
bool _isPublic(String location) {
  if (_publicRoutes.contains(location)) return true;
  if (_customerPublicRoutes.contains(location)) return true;
  // Detail layanan publik: /customer/services/:id
  if (location.startsWith('/customer/services/')) return true;
  return false;
}

/// Technician onboarding routes a signed-in customer may also reach in order
/// to convert into a technician.
const _technicianOnboardingRoutes = {
  AppRoutes.technicianJoin,
  AppRoutes.technicianApplication,
  AppRoutes.technicianUploadKtp,
  AppRoutes.technicianUploadProfile,
  AppRoutes.technicianBankInfo,
  AppRoutes.technicianVerification,
};

String _homeFor(UserRole role) {
  switch (role) {
    case UserRole.technician:
      return AppRoutes.technicianDashboard;
    case UserRole.admin:
      return AppRoutes.adminDashboard;
    case UserRole.customer:
      return AppRoutes.customerHome;
  }
}

/// Session-aware redirect. Only installed when Supabase is configured.
String? _guard(Ref ref, GoRouterState state) {
  final authState = ref.read(authUserProvider);
  if (authState.isLoading) return null;

  final user = authState.value;
  final location = state.matchedLocation;
  final isPublic = _isPublic(location);
  final isAdminPath = location.startsWith('/admin');

  if (user == null) {
    if (isPublic) return null;
    if (isAdminPath) return AppRoutes.adminLogin;
    return '${AppRoutes.login}?returnUrl=${Uri.encodeComponent(location)}';
  }

  final home = _homeFor(user.role);
  if (isPublic) {
    // Pengguna sudah login tidak perlu lagi melihat halaman auth/onboarding,
    // tapi katalog customer tetap boleh diakses.
    if (_customerPublicRoutes.contains(location) ||
        location.startsWith('/customer/services/')) {
      return null;
    }
    return home;
  }

  switch (user.role) {
    case UserRole.admin:
      return isAdminPath ? null : AppRoutes.adminDashboard;
    case UserRole.technician:
      return location.startsWith('/technician') ? null : home;
    case UserRole.customer:
      if (location.startsWith('/customer')) return null;
      if (_technicianOnboardingRoutes.contains(location)) return null;
      return home;
  }
}

/// Bridges Riverpod auth changes to GoRouter so guards re-run on sign-in/out.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Ref ref) {
    _subscription = ref.listen<AsyncValue<AuthUser?>>(
      authUserProvider,
      (_, _) => notifyListeners(),
    );
  }

  late final ProviderSubscription<AsyncValue<AuthUser?>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
