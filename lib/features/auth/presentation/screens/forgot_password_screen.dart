import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_mock_providers.dart';
import '../widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, this.isAdmin = false});

  final bool isAdmin;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        ref.read(forgotPasswordSentProvider.notifier).setSent(false);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final isSent = ref.watch(forgotPasswordSentProvider);
    final textTheme = Theme.of(context).textTheme;

    return AuthScaffold(
      appBar: AppBar(),
      children: [
        if (isSent) ...[
          const SizedBox(height: AppSpacing.xl),
          Icon(
            Icons.mark_email_read_rounded,
            size: 96,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Link Reset Sudah Dikirim',
            textAlign: TextAlign.center,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.isAdmin
                ? 'Silakan cek email admin Anda untuk melanjutkan proses reset password.'
                : 'Silakan cek email Anda untuk melanjutkan proses reset password.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Kembali ke Login',
            onPressed: () {
              ref.read(forgotPasswordSentProvider.notifier).setSent(false);
              context.go(
                widget.isAdmin ? AppRoutes.adminLogin : AppRoutes.login,
              );
            },
          ),
        ] else ...[
          Text(
            widget.isAdmin ? 'Lupa Password Admin' : 'Lupa Password',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.isAdmin
                ? 'Masukkan email admin. Kami akan mengirim link reset password.'
                : 'Masukkan email akun Anda. Kami akan mengirim link reset password.',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Form(
            key: _formKey,
            child: CustomTextField(
              controller: _emailController,
              label: widget.isAdmin ? 'Email admin' : 'Email',
              hintText: widget.isAdmin
                  ? 'admin@siteknisi.id'
                  : 'nama@email.com',
              prefixIcon: const Icon(Icons.email_rounded),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: _validateEmail,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Kirim Link Reset',
            isLoading: isLoading,
            onPressed: _mockSubmit,
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: () =>
                  context.go(widget.isAdmin ? AppRoutes.adminLogin : AppRoutes.login),
              child: Text(
                widget.isAdmin ? 'Kembali ke Login Admin' : 'Kembali ke Login',
              ),
            ),
          ),
        ],
      ],
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return widget.isAdmin ? 'Email admin wajib diisi' : 'Email wajib diisi';
    }

    final isValidEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    if (!isValidEmail) {
      return 'Format email tidak valid';
    }

    return null;
  }

  Future<void> _mockSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref.read(authLoadingProvider.notifier).setLoading(true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    ref.read(authLoadingProvider.notifier).setLoading(false);
    ref.read(forgotPasswordSentProvider.notifier).setSent(true);
  }
}
