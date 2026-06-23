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

/// Email yang sedang menunggu verifikasi setelah register. Null saat tidak ada
/// pendaftaran yang perlu konfirmasi email.
final pendingVerificationEmailProvider =
    NotifierProvider<PendingVerificationEmailNotifier, String?>(
      PendingVerificationEmailNotifier.new,
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

class PendingVerificationEmailNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setEmail(String? value) {
    state = value;
  }
}
