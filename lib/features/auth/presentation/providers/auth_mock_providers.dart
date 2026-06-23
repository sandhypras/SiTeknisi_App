import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool value) => state = value;
}

class LoginErrorNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool value) => state = value;
}

class ForgotPasswordSentNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool value) => state = value;
}

class PendingVerificationEmailNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? value) => state = value;
}

final authLoadingProvider = NotifierProvider<AuthLoadingNotifier, bool>(AuthLoadingNotifier.new);
final loginErrorProvider = NotifierProvider<LoginErrorNotifier, bool>(LoginErrorNotifier.new);
final forgotPasswordSentProvider = NotifierProvider<ForgotPasswordSentNotifier, bool>(ForgotPasswordSentNotifier.new);
final pendingVerificationEmailProvider = NotifierProvider<PendingVerificationEmailNotifier, String?>(PendingVerificationEmailNotifier.new);

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final String icon;
  
  OnboardingItem({required this.title, required this.description, required this.image, this.icon = ''});
}

final onboardingItemsProvider = Provider<List<OnboardingItem>>((ref) => [
  OnboardingItem(title: 'Temukan Teknisi', description: 'Cari teknisi terdekat', image: '', icon: 'search'),
  OnboardingItem(title: 'Booking Mudah', description: 'Pesan layanan dengan cepat', image: '', icon: 'calendar'),
  OnboardingItem(title: 'Bayar Aman', description: 'Pembayaran terpercaya', image: '', icon: 'payment'),
]);
