import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../auth/domain/auth_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final repository = ref.read(authRepositoryProvider);

    // Mock fallback: Supabase not configured, keep prototype behavior.
    if (repository == null) {
      context.go(AppRoutes.adminDashboard);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _errorText = null;
    });
    try {
      final user = await repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (user.role != UserRole.admin) {
        setState(() => _errorText = 'Akun ini bukan administrator.');
        return;
      }
      context.go(AppRoutes.adminDashboard);
    } on AuthFailure catch (failure) {
      if (mounted) setState(() => _errorText = failure.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.sizeOf(context).width >= 900)
            Expanded(
              child: Container(
                color: const Color(0xFF0B1F3A),
                padding: const EdgeInsets.all(64),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AdminBrand(onDark: true),
                    Spacer(),
                    Icon(
                      Icons.monitor_heart_outlined,
                      color: Color(0xFF60A5FA),
                      size: 72,
                    ),
                    SizedBox(height: 28),
                    Text(
                      'Kendalikan operasional\nlayanan dalam satu tempat.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Verifikasi teknisi, pantau booking, pembayaran,\ndan kesehatan marketplace SiTeknisi.',
                      style: TextStyle(
                        color: Color(0xFFB8C7DA),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'SiTeknisi Operations Console',
                      style: TextStyle(color: Color(0xFF7890AC)),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (MediaQuery.sizeOf(context).width < 900) ...[
                        const _AdminBrand(onDark: false),
                        const SizedBox(height: 48),
                      ],
                      Text(
                        'Selamat datang',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Masuk menggunakan akun administrator.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email admin',
                          hintText: 'admin@siteknisi.id',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: _errorText,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword
                                ? 'Tampilkan password'
                                : 'Sembunyikan password',
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.go(
                            '${AppRoutes.forgotPassword}?from=admin',
                          ),
                          child: const Text('Lupa password?'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: _isLoading ? null : _submit,
                        icon: _isLoading
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.login),
                        label: const Text('Masuk ke Dashboard'),
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 16,
                            color: AppColors.textMuted,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Akses khusus administrator',
                            style: TextStyle(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminBrand extends StatelessWidget {
  const _AdminBrand({required this.onDark});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Image.asset(AppAssets.siteknisiLogo, fit: BoxFit.contain),
        ),
        const SizedBox(width: 14),
        Text(
          'SiTeknisi Admin',
          style: TextStyle(
            color: onDark ? Colors.white : AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
