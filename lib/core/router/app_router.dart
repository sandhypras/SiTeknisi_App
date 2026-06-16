import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_home_screen.dart';
import '../../features/customer/presentation/screens/customer_activity_screen.dart';
import '../../features/customer/presentation/screens/customer_messages_screen.dart';
import '../../features/customer/presentation/screens/customer_profile_screen.dart';
import '../../features/customer/presentation/screens/booking/create_service_request_screen.dart';
import '../../features/customer/presentation/screens/booking/invoice_screen.dart';
import '../../features/customer/presentation/screens/booking/payment_screen.dart';
import '../../features/customer/presentation/screens/booking/review_screen.dart';
import '../../features/customer/presentation/screens/booking/technician_offers_screen.dart';
import '../../features/customer/presentation/screens/search_service_screen.dart';
import '../../features/customer/presentation/screens/service_categories_screen.dart';
import '../../features/customer/presentation/screens/service_detail_screen.dart';
import '../../features/technician/presentation/screens/technician_screens.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const customerHome = '/customer/home';
  static const customerActivity = '/customer/activity';
  static const customerMessages = '/customer/messages';
  static const customerCategories = '/customer/categories';
  static const customerSearch = '/customer/search';
  static const customerProfile = '/customer/profile';
  static const customerOffers = '/customer/offers';
  static const customerPayment = '/customer/payment';
  static const customerInvoice = '/customer/invoice';
  static const customerReview = '/customer/review';
  static const technicianJoin = '/technician/join';
  static const technicianDashboard = '/technician/dashboard';
  static const technicianRequests = '/technician/requests';
  static const technicianJobs = '/technician/jobs';
  static const technicianEarnings = '/technician/earnings';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
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
        path: AppRoutes.customerMessages,
        builder: (context, state) => const CustomerMessagesScreen(),
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
    ],
  );
});
