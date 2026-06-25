import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

  static const _pages = [
    _OnboardingData(
      gradient: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF3B82F6)],
      icon: Icons.verified_rounded,
      iconBg: Color(0xFF1D4ED8),
      tag: 'Teknisi Terverifikasi',
      title: 'Servis Elektronik\nJadi Lebih Pasti',
      description:
          'Pilih teknisi terverifikasi di sekitar kamu. Rating terbuka, harga transparan.',
      illustrationCircle1: Color(0x1AFFFFFF),
      illustrationCircle2: Color(0x0DFFFFFF),
    ),
    _OnboardingData(
      gradient: [Color(0xFF065F46), Color(0xFF059669), Color(0xFF34D399)],
      icon: Icons.price_check_rounded,
      iconBg: Color(0xFF047857),
      tag: 'Penawaran Terbaik',
      title: 'Bandingkan Harga,\nPilih yang Cocok',
      description:
          'Terima beberapa penawaran sekaligus. Lihat estimasi waktu dan biaya sebelum memutuskan.',
      illustrationCircle1: Color(0x1AFFFFFF),
      illustrationCircle2: Color(0x0DFFFFFF),
    ),
    _OnboardingData(
      gradient: [Color(0xFF4C1D95), Color(0xFF7C3AED), Color(0xFFA78BFA)],
      icon: Icons.receipt_long_rounded,
      iconBg: Color(0xFF6D28D9),
      tag: 'Aman & Terpercaya',
      title: 'Bayar Aman,\nInvoice Otomatis',
      description:
          'Pembayaran via Midtrans, invoice tersimpan otomatis, dan status servis bisa dipantau realtime.',
      illustrationCircle1: Color(0x1AFFFFFF),
      illustrationCircle2: Color(0x0DFFFFFF),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == _pages.length - 1;
    final page = _pages[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          // ── Animated gradient background ─────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: page.gradient,
              ),
            ),
          ),

          // ── Decorative circles ───────────────────────────────────
          Positioned(
            right: -60,
            top: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: page.illustrationCircle1,
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: 120,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: page.illustrationCircle2,
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: AppSpacing.md, top: AppSpacing.xs),
                    child: TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withValues(alpha: 0.8),
                      ),
                      child: const Text('Lewati'),
                    ),
                  ),
                ),

                // Page content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (context, index) =>
                        _PageContent(data: _pages[index]),
                  ),
                ),

                // Bottom section
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      // Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xxs),
                            width: _currentIndex == i ? 28 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentIndex == i
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.35),
                              borderRadius: AppRadius.pill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Buttons
                      Row(
                        children: [
                          if (_currentIndex > 0) ...[
                            OutlinedButton(
                              onPressed: () => _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                    color:
                                        Colors.white.withValues(alpha: 0.5)),
                                minimumSize: const Size(56, 52),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: AppRadius.large),
                              ),
                              child: const Icon(Icons.arrow_back_rounded),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                          ],
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                if (isLast) {
                                  context.go(AppRoutes.login);
                                  return;
                                }
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: page.gradient.first,
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(
                                    borderRadius: AppRadius.large),
                              ),
                              icon: Icon(isLast
                                  ? Icons.rocket_launch_rounded
                                  : Icons.arrow_forward_rounded),
                              label: Text(
                                isLast ? 'Mulai Sekarang' : 'Lanjut',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun?',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(AppRoutes.login),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({required this.data});

  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: size.width * 0.55,
            height: size.width * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: size.width * 0.38,
                height: size.width * 0.38,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.icon,
                  size: size.width * 0.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Tag
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: AppRadius.pill,
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Text(
              data.tag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 15,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.gradient,
    required this.icon,
    required this.iconBg,
    required this.tag,
    required this.title,
    required this.description,
    required this.illustrationCircle1,
    required this.illustrationCircle2,
  });

  final List<Color> gradient;
  final IconData icon;
  final Color iconBg;
  final String tag;
  final String title;
  final String description;
  final Color illustrationCircle1;
  final Color illustrationCircle2;
}
