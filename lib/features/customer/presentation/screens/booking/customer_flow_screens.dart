import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../../shared/widgets/status_chip.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FlowScaffold(
      title: 'Pilih Lokasi',
      bottom: PrimaryButton(
        label: 'Gunakan Lokasi Ini',
        onPressed: () => context.pop(),
      ),
      children: [
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: AppRadius.large,
          ),
          child: const Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.map_rounded, size: 150, color: AppColors.primary),
              Icon(Icons.location_pin, size: 52, color: AppColors.error),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const ListTile(
          leading: Icon(Icons.home_rounded),
          title: Text('Rumah'),
          subtitle: Text('Jl. Merdeka No. 12, Bandung'),
          trailing: Icon(Icons.check_circle_rounded, color: AppColors.primary),
        ),
      ],
    );
  }
}

class RequestSuccessScreen extends StatelessWidget {
  const RequestSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => _SuccessFlow(
    title: 'Request Berhasil Dikirim',
    message: 'Teknisi di sekitar Anda akan segera mengirim penawaran.',
    button: 'Lihat Penawaran',
    onPressed: () => context.go(AppRoutes.customerOffers),
  );
}

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => _FlowScaffold(
    title: 'Detail Penawaran',
    bottom: PrimaryButton(
      label: 'Pilih Penawaran',
      onPressed: () => context.go(AppRoutes.customerPayment),
    ),
    children: const [
      MobileFlowStepper(
        steps: ['Detail', 'Penawaran', 'Bayar', 'Lacak'],
        currentStep: 1,
      ),
      SizedBox(height: AppSpacing.lg),
      _HeroSummary(
        icon: Icons.engineering_rounded,
        title: 'Andi Kurniawan',
        subtitle: 'Teknisi AC • Rating 4,9',
      ),
      SizedBox(height: AppSpacing.lg),
      _DetailCard(
        title: 'Penawaran Harga',
        rows: {
          'Jasa servis': 'Rp 150.000',
          'Transport': 'Rp 25.000',
          'Total': 'Rp 175.000',
        },
      ),
      SizedBox(height: AppSpacing.md),
      _DetailCard(
        title: 'Catatan Teknisi',
        rows: {
          'Pesan':
              'Saya dapat tiba dalam 30 menit. Harga sparepart akan dikonfirmasi setelah pengecekan.',
        },
      ),
    ],
  );
}

class OfferComparisonScreen extends StatelessWidget {
  const OfferComparisonScreen({super.key});
  @override
  Widget build(BuildContext context) => _FlowScaffold(
    title: 'Bandingkan Offer',
    children: const [
      _ComparisonTile(
        name: 'Andi',
        price: 'Rp 175k',
        rating: '4.9',
        eta: '30 menit',
        best: true,
      ),
      SizedBox(height: AppSpacing.sm),
      _ComparisonTile(
        name: 'Budi',
        price: 'Rp 150k',
        rating: '4.8',
        eta: '1 jam',
      ),
      SizedBox(height: AppSpacing.sm),
      _ComparisonTile(
        name: 'Rina',
        price: 'Rp 190k',
        rating: '4.9',
        eta: '45 menit',
      ),
    ],
  );
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => _SuccessFlow(
    title: 'Pembayaran Berhasil',
    message: 'Rp 192.500 dibayar melalui QRIS. Invoice otomatis telah dibuat.',
    button: 'Lihat Invoice',
    onPressed: () => context.go(AppRoutes.customerInvoice),
  );
}

class BookingTrackingScreen extends StatelessWidget {
  const BookingTrackingScreen({super.key});
  @override
  Widget build(BuildContext context) => _FlowScaffold(
    title: 'Tracking Booking',
    children: const [
      MobileFlowStepper(
        steps: ['Detail', 'Penawaran', 'Bayar', 'Lacak'],
        currentStep: 3,
      ),
      SizedBox(height: AppSpacing.lg),
      _HeroSummary(
        icon: Icons.local_shipping_rounded,
        title: 'Teknisi dalam perjalanan',
        subtitle: 'Estimasi tiba 10 menit',
      ),
      SizedBox(height: AppSpacing.lg),
      _TimelineItem(label: 'Pembayaran berhasil', complete: true),
      _TimelineItem(label: 'Teknisi menerima booking', complete: true),
      _TimelineItem(label: 'Teknisi dalam perjalanan', complete: true),
      _TimelineItem(label: 'Pengerjaan dimulai'),
      _TimelineItem(label: 'Pekerjaan selesai'),
    ],
  );
}

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => const _FlowScaffold(
    title: 'Detail Booking',
    children: [
      _HeroSummary(
        icon: Icons.ac_unit_rounded,
        title: 'Servis AC',
        subtitle: 'Booking BKG-20260617-001',
      ),
      SizedBox(height: AppSpacing.lg),
      _DetailCard(
        title: 'Informasi',
        rows: {
          'Teknisi': 'Andi Kurniawan',
          'Jadwal': '18 Jun 2026, 14:00',
          'Lokasi': 'Jl. Merdeka No. 12',
          'Status': 'Dalam perjalanan',
        },
      ),
    ],
  );
}

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => const _FlowScaffold(
    title: 'Riwayat Booking',
    children: [
      _HistoryRow(title: 'Servis HP', date: '12 Okt 2023', status: 'Selesai'),
      SizedBox(height: AppSpacing.sm),
      _HistoryRow(
        title: 'Servis Mesin Cuci',
        date: '3 Sep 2023',
        status: 'Selesai',
      ),
    ],
  );
}

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => const _FlowScaffold(
    title: 'Riwayat Invoice',
    children: [
      _HistoryRow(
        title: 'INV/SITEKNISI/20260617/0001',
        date: 'Rp 192.500',
        status: 'Paid',
      ),
      SizedBox(height: AppSpacing.sm),
      _HistoryRow(
        title: 'INV/SITEKNISI/20260502/0008',
        date: 'Rp 225.000',
        status: 'Paid',
      ),
    ],
  );
}

class _FlowScaffold extends StatelessWidget {
  const _FlowScaffold({
    required this.title,
    required this.children,
    this.bottom,
  });
  final String title;
  final List<Widget> children;
  final Widget? bottom;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    bottomNavigationBar: bottom == null
        ? null
        : SafeArea(
            minimum: const EdgeInsets.all(AppSpacing.screenPadding),
            child: bottom!,
          ),
    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: children,
    ),
  );
}

class _SuccessFlow extends StatelessWidget {
  const _SuccessFlow({
    required this.title,
    required this.message,
    required this.button,
    required this.onPressed,
  });
  final String title;
  final String message;
  final String button;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 96,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: button, onPressed: onPressed),
          ],
        ),
      ),
    ),
  );
}

class _HeroSummary extends StatelessWidget {
  const _HeroSummary({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: AppRadius.large,
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 42),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Text(subtitle),
            ],
          ),
        ),
      ],
    ),
  );
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.rows});
  final String title;
  final Map<String, String> rows;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          ...rows.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(e.key)),
                  Flexible(child: Text(e.value, textAlign: TextAlign.end)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ComparisonTile extends StatelessWidget {
  const _ComparisonTile({
    required this.name,
    required this.price,
    required this.rating,
    required this.eta,
    this.best = false,
  });
  final String name, price, rating, eta;
  final bool best;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          CircleAvatar(child: Text(name[0])),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                Text('$rating ★ • $eta'),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (best) const StatusChip.success(label: 'Terbaik'),
              Text(
                price,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.label, this.complete = false});
  final String label;
  final bool complete;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: Row(
      children: [
        Icon(
          complete
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: complete ? AppColors.success : AppColors.disabled,
        ),
        const SizedBox(width: AppSpacing.md),
        Text(label),
      ],
    ),
  );
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.title,
    required this.date,
    required this.status,
  });
  final String title, date, status;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text(date),
      trailing: StatusChip.success(label: status),
    ),
  );
}
