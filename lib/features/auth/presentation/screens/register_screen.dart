import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
import '../widgets/auth_logo.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.customer;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final pendingEmail = ref.watch(pendingVerificationEmailProvider);

    if (pendingEmail != null) {
      return _VerificationSentView(email: pendingEmail);
    }

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
              _RoleChoice(
                selected: _selectedRole,
                onChanged: (role) => setState(() => _selectedRole = role),
              ),
              const SizedBox(height: AppSpacing.lg),
              CustomTextField(
                controller: _nameController,
                label: 'Nama Lengkap',
                hintText: 'Contoh: Sandhy Prasetyo',
                prefixIcon: const Icon(Icons.person_outline_rounded),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                controller: _phoneController,
                label: 'Nomor HP',
                hintText: '08xxxxxxxxxx',
                prefixIcon: const Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'nama@email.com',
                prefixIcon: const Icon(Icons.mail_outline_rounded),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                helperText: 'Minimal 8 karakter dengan kombinasi angka.',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: const Icon(Icons.visibility_off_rounded),
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
                onPressed: () => _submit(context, ref),
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

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    // Validasi input
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap harus diisi'),
          backgroundColor: AppColors.errorText,
        ),
      );
      return;
    }

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor HP harus diisi'),
          backgroundColor: AppColors.errorText,
        ),
      );
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email tidak valid'),
          backgroundColor: AppColors.errorText,
        ),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password minimal 8 karakter'),
          backgroundColor: AppColors.errorText,
        ),
      );
      return;
    }

    final repository = ref.read(authRepositoryProvider);

    // Mock fallback: Supabase not configured, keep prototype behavior.
    if (repository == null) {
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
      return;
    }

    FocusScope.of(context).unfocus();
    ref.read(authLoadingProvider.notifier).setLoading(true);
    try {
      final result = await repository.signUp(
        email: email,
        password: password,
        fullName: name,
        role: _selectedRole,
        phone: phone,
      );
      if (!context.mounted) return;
      if (result.needsEmailVerification) {
        ref
            .read(pendingVerificationEmailProvider.notifier)
            .setEmail(email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dibuat. Silakan masuk.')),
        );
        context.go(AppRoutes.login);
      }
    } on AuthFailure catch (failure) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: AppColors.errorText,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (error, stackTrace) {
      // Tangkap error tak terduga
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error tidak terduga: $error'),
            backgroundColor: AppColors.errorText,
            duration: const Duration(seconds: 5),
          ),
        );
        debugPrint('Register error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
    } finally {
      if (context.mounted) {
        ref.read(authLoadingProvider.notifier).setLoading(false);
      }
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
          const AuthLogo(
            size: 38,
            cardSize: 64,
            showText: false,
            logoMode: AuthLogoMode.mark,
          ),
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

/// Tampil setelah Supabase membuat akun dengan mode "Confirm email" aktif.
/// Meminta user cek inbox dan menawarkan kirim ulang link verifikasi.
class _VerificationSentView extends ConsumerStatefulWidget {
  const _VerificationSentView({required this.email});

  final String email;

  @override
  ConsumerState<_VerificationSentView> createState() =>
      _VerificationSentViewState();
}

class _VerificationSentViewState extends ConsumerState<_VerificationSentView> {
  bool _isResending = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLoading = ref.watch(authLoadingProvider);

    return AuthScaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(backgroundColor: const Color(0xFFFAF8FF)),
      children: [
        const SizedBox(height: AppSpacing.xl),
        const Icon(
          Icons.mark_email_read_rounded,
          size: 96,
          color: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Cek Email Anda',
          textAlign: TextAlign.center,
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Link verifikasi sudah dikirim ke ${widget.email}. Buka email tersebut dan klik tautan untuk mengaktifkan akun Anda.',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        PrimaryButton(
          label: _isResending ? 'Mengirim...' : 'Kirim Ulang Link',
          icon: Icons.refresh_rounded,
          isLoading: _isResending,
          onPressed: _isResending ? null : _resend,
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: TextButton(
            onPressed: () {
              ref
                  .read(pendingVerificationEmailProvider.notifier)
                  .setEmail(null);
              if (isLoading) {
                ref.read(authLoadingProvider.notifier).setLoading(false);
              }
              context.go(AppRoutes.login);
            },
            child: const Text('Kembali ke Login'),
          ),
        ),
      ],
    );
  }

  Future<void> _resend() async {
    final repository = ref.read(authRepositoryProvider);
    if (repository == null) return;

    setState(() => _isResending = true);
    try {
      await repository.resendVerification(widget.email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link verifikasi baru sudah dikirim.'),
        ),
      );
    } on AuthFailure catch (failure) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(failure.message),
          backgroundColor: AppColors.errorText,
        ),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }
}

class _RoleChoice extends StatelessWidget {
  const _RoleChoice({required this.selected, required this.onChanged});

  final UserRole selected;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: [
          Expanded(
            child: _RoleOption(
              icon: Icons.shopping_bag_rounded,
              title: 'Customer',
              selected: selected == UserRole.customer,
              onTap: () => onChanged(UserRole.customer),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _RoleOption(
              icon: Icons.engineering_rounded,
              title: 'Teknisi',
              selected: selected == UserRole.technician,
              onTap: () => onChanged(UserRole.technician),
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
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.medium,
      child: Container(
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
