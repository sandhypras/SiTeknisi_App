import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;
}

final onboardingItemsProvider = Provider<List<OnboardingItem>>((ref) {
  return const [
    OnboardingItem(
      title: 'Temukan Teknisi Terpercaya',
      description:
          'Pilih layanan servis elektronik dan temukan teknisi terverifikasi di sekitar Anda.',
      icon: 'verified',
    ),
    OnboardingItem(
      title: 'Bandingkan Penawaran Harga',
      description:
          'Terima beberapa penawaran, lihat rating, estimasi waktu, dan pilih yang paling cocok.',
      icon: 'compare',
    ),
    OnboardingItem(
      title: 'Bayar Aman, Invoice Otomatis',
      description:
          'Pembayaran tercatat, invoice tersimpan, dan status pekerjaan bisa dipantau.',
      icon: 'invoice',
    ),
  ];
});

/// Menyimpan nama user di mock mode (tidak ada Supabase session)
final mockUserNameProvider = NotifierProvider<MockUserNameNotifier, String>(
  MockUserNameNotifier.new,
);

class MockUserNameNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setName(String name) => state = name;
}

/// Status tamu — true kalau user pilih "Lanjut sebagai Tamu"
final guestModeProvider = NotifierProvider<GuestModeNotifier, bool>(
  GuestModeNotifier.new,
);

class GuestModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setGuest(bool value) => state = value;
}

final authLoadingProvider = NotifierProvider<AuthLoadingNotifier, bool>(
  AuthLoadingNotifier.new,
);

final loginErrorProvider = NotifierProvider<LoginErrorNotifier, bool>(
  LoginErrorNotifier.new,
);

final forgotPasswordSentProvider =
    NotifierProvider<ForgotPasswordSentNotifier, bool>(
      ForgotPasswordSentNotifier.new,
    );

class AuthLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLoading(bool value) {
    state = value;
  }
}

class LoginErrorNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setError(bool value) {
    state = value;
  }
}

class ForgotPasswordSentNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setSent(bool value) {
    state = value;
  }
}
