import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../data/auth_repository.dart';
import '../../domain/auth_user.dart';
import '../providers/auth_mock_providers.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_illustrations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.returnUrl});

  final String? returnUrl;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  _LoginRole _selectedRole = _LoginRole.customer;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final hasError = ref.watch(loginErrorProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Hero background ──────────────────────────────────────
          SizedBox(
            height: size.height * 0.48,
            width: double.infinity,
            child: CustomPaint(painter: _HeroBgPainter()),
          ),

          // ── Hero content ─────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Logo + app name row
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.medium,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          AppAssets.siteknisiLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Text(
                        'SiTeknisi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Text(
                    'Selamat\nDatang Kembali!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _selectedRole == _LoginRole.customer
                        ? 'Masuk untuk memesan layanan servis elektronik.'
                        : 'Masuk untuk menerima pekerjaan servis.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Form card (slides up) ─────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: size.height * 0.32,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Role selector
                    _RoleSelector(
                      selected: _selectedRole,
                      onChanged: (role) =>
                          setState(() => _selectedRole = role),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Email
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'user@example.com',
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if (hasError) {
                          ref
                              .read(loginErrorProvider.notifier)
                              .setError(false);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Password
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Masukkan password',
                      errorText: hasError
                          ? 'Email atau password tidak sesuai'
                          : null,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? 'Tampilkan password'
                            : 'Sembunyikan password',
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        if (hasError) {
                          ref
                              .read(loginErrorProvider.notifier)
                              .setError(false);
                        }
                      },
                    ),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.go(AppRoutes.forgotPassword),
                        child: const Text('Lupa Password?'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Login button
                    PrimaryButton(
                      label: 'Masuk',
                      icon: Icons.arrow_forward_rounded,
                      isLoading: isLoading,
                      onPressed: () => _submit(context),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun?',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppRoutes.register),
                          child: const Text('Daftar sekarang'),
                        ),
                      ],
                    ),

                    // Guest button
                    OutlinedButton.icon(
                      onPressed: () => context.go(AppRoutes.customerHome),
                      icon: const Icon(Icons.person_outline_rounded),
                      label: const Text('Lanjut sebagai Tamu'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),

                    // Error toast
                    if (hasError) ...[
                      const SizedBox(height: AppSpacing.md),
                      ErrorToastCard(
                        message: 'Login gagal, silakan coba lagi',
                        onDismiss: () =>
                            ref
                                .read(loginErrorProvider.notifier)
                                .setError(false),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final repository = ref.read(authRepositoryProvider);

    if (repository == null) {
      ref.read(authLoadingProvider.notifier).setLoading(true);
      await Future<void>.delayed(const Duration(milliseconds: 700));
      ref.read(authLoadingProvider.notifier).setLoading(false);
      ref.read(loginErrorProvider.notifier).setError(false);

      // Simpan nama mock dari email (bagian sebelum @)
      final mockName = _emailController.text.trim().split('@').first;
      if (mockName.isNotEmpty) {
        ref.read(mockUserNameProvider.notifier).setName(
          mockName[0].toUpperCase() + mockName.substring(1),
        );
      }

      if (context.mounted) {
        FocusScope.of(context).unfocus();
        final returnUrl = widget.returnUrl;
        if (returnUrl != null && returnUrl.isNotEmpty) {
          context.go(returnUrl);
          return;
        }
        context.go(
          _selectedRole == _LoginRole.customer
              ? AppRoutes.customerHome
              : AppRoutes.technicianDashboard,
        );
      }
      return;
    }

    FocusScope.of(context).unfocus();
    ref.read(loginErrorProvider.notifier).setError(false);
    ref.read(authLoadingProvider.notifier).setLoading(true);
    try {
      final user = await repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!context.mounted) return;
      final returnUrl = widget.returnUrl;
      if (returnUrl != null && returnUrl.isNotEmpty) {
        context.go(returnUrl);
      } else {
        context.go(_homeRouteFor(user.role));
      }
    } on AuthFailure {
      ref.read(loginErrorProvider.notifier).setError(true);
    } finally {
      if (context.mounted) {
        ref.read(authLoadingProvider.notifier).setLoading(false);
      }
    }
  }

  String _homeRouteFor(UserRole role) {
    switch (role) {
      case UserRole.technician:
        return AppRoutes.technicianDashboard;
      case UserRole.admin:
        return AppRoutes.adminDashboard;
      case UserRole.customer:
        return AppRoutes.customerHome;
    }
  }
}

enum _LoginRole { customer, technician }

// ── Role selector ────────────────────────────────────────────────────────────

class _RoleSelector extends StatelessWidget {
  const _RoleSelector({required this.selected, required this.onChanged});

  final _LoginRole selected;
  final ValueChanged<_LoginRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: [
          _RoleTab(
            icon: Icons.person_rounded,
            label: 'Customer',
            selected: selected == _LoginRole.customer,
            onTap: () => onChanged(_LoginRole.customer),
          ),
          _RoleTab(
            icon: Icons.engineering_rounded,
            label: 'Teknisi',
            selected: selected == _LoginRole.technician,
            onTap: () => onChanged(_LoginRole.technician),
          ),
        ],
      ),
    );
  }
}

class _RoleTab extends StatelessWidget {
  const _RoleTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: AppRadius.medium,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.white : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textMuted,
                  fontWeight:
                      selected ? FontWeight.w800 : FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hero background painter ──────────────────────────────────────────────────

class _HeroBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient base
    final rect = Offset.zero & size;
    final gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF3B82F6)],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );

    // Decorative circles
    final circlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.18),
      size.width * 0.38,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.75),
      size.width * 0.28,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height * 0.9),
      size.width * 0.18,
      Paint()..color = Colors.white.withValues(alpha: 0.05),
    );

    // Bottom curve cutout (white)
    final curvePaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height - 40)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + 20,
        size.width,
        size.height - 40,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
