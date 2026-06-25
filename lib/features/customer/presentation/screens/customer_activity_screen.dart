import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

// ── Model ─────────────────────────────────────────────────────────────────────

enum _BookingStatus { ongoing, completed, cancelled }

class _BookingItem {
  const _BookingItem({
    required this.id,
    required this.title,
    required this.technicianName,
    required this.date,
    required this.price,
    required this.status,
    required this.icon,
  });

  final String id;
  final String title;
  final String technicianName;
  final String date;
  final String price;
  final _BookingStatus status;
  final IconData icon;
}

// ── Dummy provider ─────────────────────────────────────────────────────────────

final _bookingHistoryProvider = Provider<List<_BookingItem>>((ref) {
  return const [
    _BookingItem(
      id: 'BK-001',
      title: 'Servis AC Tidak Dingin',
      technicianName: 'Andi Kurniawan',
      date: 'Hari ini, 10:30',
      price: 'Rp 175.000',
      status: _BookingStatus.ongoing,
      icon: Icons.ac_unit_rounded,
    ),
    _BookingItem(
      id: 'BK-002',
      title: 'Servis HP – Ganti LCD',
      technicianName: 'Budi Santoso',
      date: '12 Okt 2024',
      price: 'Rp 350.000',
      status: _BookingStatus.completed,
      icon: Icons.phone_android_rounded,
    ),
    _BookingItem(
      id: 'BK-003',
      title: 'Servis Mesin Cuci',
      technicianName: 'Rina Wijaya',
      date: '5 Okt 2024',
      price: 'Rp 220.000',
      status: _BookingStatus.completed,
      icon: Icons.local_laundry_service_rounded,
    ),
    _BookingItem(
      id: 'BK-004',
      title: 'Servis TV LED',
      technicianName: 'Hendra Putra',
      date: '28 Sep 2024',
      price: 'Rp 180.000',
      status: _BookingStatus.cancelled,
      icon: Icons.tv_rounded,
    ),
    _BookingItem(
      id: 'BK-005',
      title: 'Ganti Baterai HP',
      technicianName: 'Budi Santoso',
      date: '20 Sep 2024',
      price: 'Rp 120.000',
      status: _BookingStatus.completed,
      icon: Icons.battery_charging_full_rounded,
    ),
  ];
});

// ── Screen ────────────────────────────────────────────────────────────────────

class CustomerActivityScreen extends ConsumerStatefulWidget {
  const CustomerActivityScreen({super.key});

  @override
  ConsumerState<CustomerActivityScreen> createState() =>
      _CustomerActivityScreenState();
}

class _CustomerActivityScreenState
    extends ConsumerState<CustomerActivityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allBookings = ref.watch(_bookingHistoryProvider);

    final ongoing =
        allBookings.where((b) => b.status == _BookingStatus.ongoing).toList();
    final completed =
        allBookings.where((b) => b.status == _BookingStatus.completed).toList();
    return CustomerShell(
      currentIndex: 1,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.screenPadding,
                AppSpacing.screenPadding,
                0,
              ),
              child: CustomerHeader(
                title: 'Aktivitas',
                subtitle: 'Pantau pesanan dan riwayat servis Anda.',
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Tab bar
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelPadding: EdgeInsets.zero,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textMuted,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
              tabs: [
                Tab(text: 'Semua (${allBookings.length})'),
                Tab(text: 'Berlangsung (${ongoing.length})'),
                Tab(text: 'Selesai (${completed.length})'),
              ],
            ),

            const Divider(height: 1),

            // Tab views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _BookingList(items: allBookings),
                  _BookingList(
                    items: ongoing,
                    emptyTitle: 'Tidak ada pesanan aktif',
                    emptyMessage:
                        'Saat ini tidak ada servis yang sedang berjalan.',
                    emptyIcon: Icons.assignment_outlined,
                    emptyAction: 'Buat Request',
                    onEmptyAction: () => context.go(AppRoutes.customerHome),
                  ),
                  _BookingList(
                    items: completed,
                    emptyTitle: 'Belum ada riwayat',
                    emptyMessage:
                        'Riwayat servis yang selesai akan muncul di sini.',
                    emptyIcon: Icons.task_alt_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Booking list ──────────────────────────────────────────────────────────────

class _BookingList extends StatelessWidget {
  const _BookingList({
    required this.items,
    this.emptyTitle = 'Belum ada aktivitas',
    this.emptyMessage = 'Aktivitas servis kamu akan muncul di sini.',
    this.emptyIcon = Icons.inbox_rounded,
    this.emptyAction,
    this.onEmptyAction,
  });

  final List<_BookingItem> items;
  final String emptyTitle;
  final String emptyMessage;
  final IconData emptyIcon;
  final String? emptyAction;
  final VoidCallback? onEmptyAction;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return EmptyState(
        icon: emptyIcon,
        title: emptyTitle,
        message: emptyMessage,
        actionLabel: emptyAction,
        onAction: onEmptyAction,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => _BookingCard(item: items[index]),
    );
  }
}

// ── Booking card ──────────────────────────────────────────────────────────────

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.item});

  final _BookingItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isOngoing = item.status == _BookingStatus.ongoing;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: isOngoing ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: isOngoing ? 0.2 : 0.08),
            blurRadius: isOngoing ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isOngoing
                        ? AppColors.primary
                        : AppColors.primaryLight.withValues(alpha: 0.7),
                    borderRadius: AppRadius.medium,
                  ),
                  child: Icon(
                    item.icon,
                    color: isOngoing ? AppColors.surface : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _statusChip(item.status),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        item.technicianName,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 13,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            item.date,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.price,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
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

          // Action buttons untuk ongoing
          if (isOngoing) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text('Fitur lacak segera hadir.'))),
                      icon: const Icon(Icons.map_rounded, size: 16),
                      label: const Text('Lacak'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(38),
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          context.go(AppRoutes.customerMessages),
                      icon: const Icon(Icons.chat_rounded, size: 16),
                      label: const Text('Chat'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(38),
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action button untuk completed
          if (item.status == _BookingStatus.completed) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text('Invoice akan segera tersedia.'))),
                      icon: const Icon(Icons.receipt_long_rounded, size: 16),
                      label: const Text('Invoice'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(38),
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.go(AppRoutes.customerReview),
                      icon: const Icon(Icons.star_outline_rounded, size: 16),
                      label: const Text('Beri Rating'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(38),
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusChip(_BookingStatus status) {
    return switch (status) {
      _BookingStatus.ongoing => const StatusChip.neutral(label: 'Berlangsung'),
      _BookingStatus.completed => const StatusChip.success(label: 'Selesai'),
      _BookingStatus.cancelled => const StatusChip.warning(label: 'Dibatalkan'),
    };
  }
}
