import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_mock_providers.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);
    final textTheme = Theme.of(context).textTheme;

    return AuthScaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8FF),
        title: const Text('Daftar'),
      ),
      children: [
        const _RegisterHeader(),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.extraLarge,
            border: Border.all(color: const Color(0xFFD8DCEF)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 34,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informasi Akun',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Gunakan data aktif agar teknisi mudah menghubungi Anda.',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _RoleChoice(),
              const SizedBox(height: AppSpacing.lg),
              const CustomTextField(
                label: 'Nama Lengkap',
                hintText: 'Contoh: Sandhy Prasetyo',
                prefixIcon: Icon(Icons.person_outline_rounded),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              const CustomTextField(
                label: 'Nomor HP',
                hintText: '08xxxxxxxxxx',
                prefixIcon: Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              const CustomTextField(
                label: 'Email',
                hintText: 'nama@email.com',
                prefixIcon: Icon(Icons.mail_outline_rounded),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              const CustomTextField(
                label: 'Password',
                helperText: 'Minimal 8 karakter dengan kombinasi angka.',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: Icon(Icons.visibility_off_rounded),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: AppSpacing.md),
              const _PasswordHint(),
              const SizedBox(height: AppSpacing.md),
              const _AgreementRow(),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: 'Buat Akun',
                icon: Icons.arrow_forward_rounded,
                isLoading: isLoading,
                onPressed: () => _mockSubmit(context, ref),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: textTheme.bodySmall?.copyWith(
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

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: AppRadius.extraLarge,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F4FD9), AppColors.primary],
        ),
      ),
      child: Row(
        children: [
          const AuthLogo(size: 52, cardSize: 64, showText: false),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mulai servis tanpa ribet',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w900,
                    height: 1.18,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Akun customer untuk request servis, memilih teknisi, dan menyimpan invoice.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.86),
                    height: 1.4,
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

class _RoleChoice extends StatelessWidget {
  const _RoleChoice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: const [
          Expanded(
            child: _RoleOption(
              icon: Icons.shopping_bag_rounded,
              title: 'Customer',
              selected: true,
            ),
          ),
          SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _RoleOption(
              icon: Icons.engineering_rounded,
              title: 'Teknisi',
              selected: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.icon,
    required this.title,
    required this.selected,
  });

  final IconData icon;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.surface : Colors.transparent,
        borderRadius: AppRadius.medium,
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
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
            color: selected ? AppColors.primary : AppColors.textMuted,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium?.copyWith(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordHint extends StatelessWidget {
  const _PasswordHint();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: const [
        _HintChip(label: '8+ karakter'),
        _HintChip(label: 'Nomor aktif'),
        _HintChip(label: 'Email valid'),
      ],
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.successContainer,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.successText,
            size: 14,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.successText,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgreementRow extends StatelessWidget {
  const _AgreementRow();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.42),
        borderRadius: AppRadius.medium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox.square(
            dimension: 28,
            child: Checkbox(
              value: true,
              onChanged: (_) {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi SiTeknisi.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
