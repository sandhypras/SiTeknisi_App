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

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);
    final textTheme = Theme.of(context).textTheme;

    return AuthScaffold(
      appBar: AppBar(),
      children: [
        Text(
          'Buat Akun Baru',
          style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Daftar sebagai customer untuk mulai memesan layanan servis.',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xl),
        const CustomTextField(
          label: 'Nama Lengkap',
          prefixIcon: Icon(Icons.person_rounded),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),
        const CustomTextField(
          label: 'Nomor HP',
          hintText: '08xxxxxxxxxx',
          prefixIcon: Icon(Icons.phone_rounded),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),
        const CustomTextField(
          label: 'Email',
          hintText: 'nama@email.com',
          prefixIcon: Icon(Icons.email_rounded),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),
        const CustomTextField(
          label: 'Password',
          prefixIcon: Icon(Icons.lock_rounded),
          suffixIcon: Icon(Icons.visibility_rounded),
          obscureText: true,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: true, onChanged: (_) {}),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  'Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi SiTeknisi.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Daftar',
          isLoading: isLoading,
          onPressed: () => _mockSubmit(context, ref),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text('Masuk'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _mockSubmit(BuildContext context, WidgetRef ref) async {
    ref.read(authLoadingProvider.notifier).setLoading(true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    ref.read(authLoadingProvider.notifier).setLoading(false);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Mock register berhasil. Integrasi Supabase belum aktif.',
          ),
        ),
      );
      context.go(AppRoutes.login);
    }
  }
}
