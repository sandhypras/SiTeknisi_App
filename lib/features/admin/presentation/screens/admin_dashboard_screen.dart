import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key, required this.section});

  final String section;

  static const _items = <_AdminNavItem>[
    _AdminNavItem('dashboard', 'Dashboard', Icons.dashboard_outlined),
    _AdminNavItem('users', 'Pengguna', Icons.people_outline),
    _AdminNavItem(
      'technicians',
      'Verifikasi Teknisi',
      Icons.engineering_outlined,
    ),
    _AdminNavItem('services', 'Layanan', Icons.home_repair_service_outlined),
    _AdminNavItem('bookings', 'Booking', Icons.event_note_outlined),
    _AdminNavItem('payments', 'Pembayaran', Icons.payments_outlined),
    _AdminNavItem('invoices', 'Invoice', Icons.receipt_long_outlined),
    _AdminNavItem('reports', 'Laporan', Icons.bar_chart_outlined),
    _AdminNavItem('settings', 'Pengaturan', Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = _items.any((item) => item.id == section)
        ? section
        : 'dashboard';
    final compact = MediaQuery.sizeOf(context).width < 1100;

    return Scaffold(
      drawer: compact ? Drawer(child: _Sidebar(selected: selected)) : null,
      body: Row(
        children: [
          if (!compact)
            SizedBox(width: 260, child: _Sidebar(selected: selected)),
          Expanded(
            child: Column(
              children: [
                _TopBar(compact: compact),
                Expanded(
                  child: ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(compact ? 20 : 32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1440),
                        child: _AdminSection(section: selected),
                      ),
                    ),
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

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selected});

  final String selected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF0B1F3A),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 18, 28),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      AppAssets.siteknisiLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SiTeknisi',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Operations Console',
                          style: TextStyle(
                            color: Color(0xFF8FA6C1),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: Text(
                      'MENU UTAMA',
                      style: TextStyle(
                        color: Color(0xFF6F88A5),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  for (final item in AdminDashboardScreen._items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        selected: item.id == selected,
                        selectedTileColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          item.icon,
                          color: item.id == selected
                              ? Colors.white
                              : const Color(0xFFA8BAD0),
                        ),
                        title: Text(
                          item.label,
                          style: TextStyle(
                            color: item.id == selected
                                ? Colors.white
                                : const Color(0xFFD5E0EC),
                            fontWeight: item.id == selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          context.go('/admin/${item.id}');
                          if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF263D59), height: 1),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF233E5F),
                child: Text('SA', style: TextStyle(color: Colors.white)),
              ),
              title: const Text(
                'Sandhy Admin',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              subtitle: const Text(
                'Super Admin',
                style: TextStyle(color: Color(0xFF8FA6C1), fontSize: 11),
              ),
              trailing: IconButton(
                tooltip: 'Keluar',
                onPressed: () => context.go(AppRoutes.adminLogin),
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFA8BAD0),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (compact)
            Builder(
              builder: (context) => IconButton(
                tooltip: 'Buka menu',
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ),
          if (compact) const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Pusat Operasional',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: compact ? 44 : 260,
            child: compact
                ? IconButton(
                    tooltip: 'Cari',
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  )
                : const TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari booking, invoice, pengguna...',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Badge(
            label: const Text('3'),
            child: IconButton(
              tooltip: 'Notifikasi',
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminSection extends StatelessWidget {
  const _AdminSection({required this.section});

  final String section;

  @override
  Widget build(BuildContext context) {
    switch (section) {
      case 'users':
        return const _DataPage(
          title: 'Manajemen Pengguna',
          subtitle: 'Kelola akun customer, teknisi, dan administrator.',
          columns: ['Nama', 'Kontak', 'Peran', 'Bergabung', 'Status'],
          rows: [
            [
              'Budi Santoso',
              'budi@email.com',
              'Customer',
              '12 Jun 2026',
              'Aktif',
            ],
            [
              'Andi Kurniawan',
              '0812 4455 9012',
              'Teknisi',
              '10 Jun 2026',
              'Aktif',
            ],
            [
              'Rina Amelia',
              'rina@email.com',
              'Customer',
              '08 Jun 2026',
              'Aktif',
            ],
          ],
        );
      case 'technicians':
        return const _DataPage(
          title: 'Verifikasi Teknisi',
          subtitle: 'Periksa identitas, keahlian, dan rekening pendaftar.',
          actionLabel: 'Review Pengajuan',
          columns: ['Teknisi', 'Keahlian', 'Pengalaman', 'Diajukan', 'Status'],
          rows: [
            ['Dimas Pratama', 'AC & Kulkas', '5 tahun', 'Hari ini', 'Menunggu'],
            ['Sari Dewi', 'Laptop & HP', '3 tahun', 'Kemarin', 'Menunggu'],
            [
              'Agus Setiawan',
              'TV & Audio',
              '7 tahun',
              '16 Jun 2026',
              'Ditinjau',
            ],
          ],
        );
      case 'services':
        return const _DataPage(
          title: 'Manajemen Layanan',
          subtitle: 'Atur kategori layanan yang tampil di marketplace.',
          actionLabel: 'Tambah Layanan',
          columns: ['Layanan', 'Deskripsi', 'Teknisi', 'Dibuat', 'Status'],
          rows: [
            [
              'Servis AC',
              'Perawatan dan perbaikan AC',
              '48',
              '02 Mei 2026',
              'Aktif',
            ],
            [
              'Servis Mesin Cuci',
              'Perbaikan semua tipe mesin',
              '32',
              '02 Mei 2026',
              'Aktif',
            ],
            [
              'Servis Laptop',
              'Hardware dan software',
              '41',
              '03 Mei 2026',
              'Aktif',
            ],
          ],
        );
      case 'bookings':
        return const _DataPage(
          title: 'Monitoring Booking',
          subtitle: 'Pantau perjalanan request hingga pekerjaan selesai.',
          columns: [
            'Booking ID',
            'Customer',
            'Teknisi',
            'Layanan',
            'Pembayaran',
            'Status',
          ],
          rows: [
            [
              'BKG-260618-041',
              'Budi',
              'Andi K.',
              'Servis AC',
              'Lunas',
              'Dikerjakan',
            ],
            [
              'BKG-260618-038',
              'Rina',
              'Sari D.',
              'Servis Laptop',
              'Lunas',
              'Menuju Lokasi',
            ],
            [
              'BKG-260617-129',
              'Fajar',
              'Dimas P.',
              'Servis TV',
              'Pending',
              'Menunggu',
            ],
          ],
        );
      case 'payments':
        return const _DataPage(
          title: 'Monitoring Pembayaran',
          subtitle: 'Audit transaksi Midtrans dan pembagian pendapatan.',
          columns: [
            'Order ID',
            'Booking',
            'Metode',
            'Nilai',
            'Komisi',
            'Status',
          ],
          rows: [
            [
              'MT-932891',
              'BKG-260618-041',
              'QRIS',
              'Rp350.000',
              'Rp35.000',
              'Lunas',
            ],
            [
              'MT-932874',
              'BKG-260618-038',
              'BCA VA',
              'Rp475.000',
              'Rp47.500',
              'Lunas',
            ],
            [
              'MT-932810',
              'BKG-260617-129',
              'GoPay',
              'Rp225.000',
              'Rp22.500',
              'Pending',
            ],
          ],
        );
      case 'invoices':
        return const _DataPage(
          title: 'Monitoring Invoice',
          subtitle: 'Cari dan audit invoice seluruh transaksi platform.',
          columns: [
            'Invoice',
            'Booking',
            'Customer',
            'Teknisi',
            'Total',
            'Status',
          ],
          rows: [
            [
              'INV-20260618-041',
              'BKG-260618-041',
              'Budi',
              'Andi K.',
              'Rp350.000',
              'Terbit',
            ],
            [
              'INV-20260618-038',
              'BKG-260618-038',
              'Rina',
              'Sari D.',
              'Rp475.000',
              'Terbit',
            ],
            [
              'INV-20260617-112',
              'BKG-260617-112',
              'Nadia',
              'Agus S.',
              'Rp280.000',
              'Terbit',
            ],
          ],
        );
      case 'reports':
        return const _ReportsPage();
      case 'settings':
        return const _SettingsPage();
      default:
        return const _DashboardOverview();
    }
  }
}

class _DashboardOverview extends StatelessWidget {
  const _DashboardOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeading(
          title: 'Dashboard',
          subtitle: 'Ringkasan operasional SiTeknisi hari ini, 18 Juni 2026.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1100
                ? 4
                : constraints.maxWidth >= 650
                ? 2
                : 1;
            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: columns == 1 ? 3 : 2.1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _KpiCard(
                  'Total Pengguna',
                  '2.485',
                  '+8,4%',
                  Icons.people_outline,
                  AppColors.primary,
                ),
                _KpiCard(
                  'Booking Aktif',
                  '128',
                  '+12 hari ini',
                  Icons.event_note_outlined,
                  AppColors.secondary,
                ),
                _KpiCard(
                  'Menunggu Verifikasi',
                  '14',
                  'Perlu ditinjau',
                  Icons.verified_user_outlined,
                  AppColors.warning,
                ),
                _KpiCard(
                  'Komisi Bulan Ini',
                  'Rp18,4 jt',
                  '+11,2%',
                  Icons.account_balance_wallet_outlined,
                  AppColors.success,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        const _DataPanel(
          title: 'Booking Terbaru',
          columns: ['Booking', 'Customer', 'Layanan', 'Teknisi', 'Status'],
          rows: [
            [
              'BKG-260618-041',
              'Budi Santoso',
              'Servis AC',
              'Andi K.',
              'Dikerjakan',
            ],
            [
              'BKG-260618-038',
              'Rina Amelia',
              'Servis Laptop',
              'Sari D.',
              'Menuju Lokasi',
            ],
            [
              'BKG-260618-035',
              'Fajar Putra',
              'Servis TV',
              'Dimas P.',
              'Menunggu',
            ],
          ],
        ),
      ],
    );
  }
}

class _DataPage extends StatelessWidget {
  const _DataPage({
    required this.title,
    required this.subtitle,
    required this.columns,
    required this.rows,
    this.actionLabel,
  });

  final String title;
  final String subtitle;
  final List<String> columns;
  final List<List<String>> rows;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PageHeading(
          title: title,
          subtitle: subtitle,
          actionLabel: actionLabel,
        ),
        const SizedBox(height: 24),
        _FilterBar(title: title),
        const SizedBox(height: 16),
        _DataPanel(title: 'Daftar $title', columns: columns, rows: rows),
      ],
    );
  }
}

class _PageHeading extends StatelessWidget {
  const _PageHeading({
    required this.title,
    required this.subtitle,
    this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (actionLabel != null)
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: Text(actionLabel!),
          ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(this.label, this.value, this.detail, this.icon, this.color);

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    detail,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 320,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari $title...',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              width: 170,
              child: DropdownButtonFormField<String>(
                initialValue: 'Semua status',
                decoration: const InputDecoration(labelText: 'Status'),
                items: const ['Semua status', 'Aktif', 'Menunggu']
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (_) {},
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataPanel extends StatelessWidget {
  const _DataPanel({
    required this.title,
    required this.columns,
    required this.rows,
  });

  final String title;
  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  '${rows.length} data',
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              columns: [
                for (final column in columns) DataColumn(label: Text(column)),
                const DataColumn(label: Text('Aksi')),
              ],
              rows: [
                for (final row in rows)
                  DataRow(
                    cells: [
                      for (var index = 0; index < row.length; index++)
                        DataCell(
                          index == row.length - 1
                              ? _TableStatus(label: row[index])
                              : Text(row[index]),
                        ),
                      DataCell(
                        IconButton(
                          tooltip: 'Lihat detail',
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Menampilkan 1-3 dari 3',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableStatus extends StatelessWidget {
  const _TableStatus({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final pending = label == 'Menunggu' || label == 'Pending';
    final active = label == 'Aktif' || label == 'Lunas' || label == 'Terbit';
    final color = pending
        ? AppColors.warningText
        : active
        ? AppColors.successText
        : AppColors.infoText;
    final background = pending
        ? AppColors.warningContainer
        : active
        ? AppColors.successContainer
        : AppColors.infoContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ReportsPage extends StatelessWidget {
  const _ReportsPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeading(
          title: 'Laporan',
          subtitle: 'Analisis performa marketplace dan permintaan layanan.',
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              crossAxisCount: constraints.maxWidth > 850 ? 2 : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [_BarChartCard(), _ServiceDemandCard()],
            );
          },
        ),
      ],
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard();

  @override
  Widget build(BuildContext context) {
    const heights = [70.0, 92.0, 64.0, 118.0, 102.0, 136.0, 126.0];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Mingguan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final height in heights)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Container(
                          height: height,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
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

class _ServiceDemandCard extends StatelessWidget {
  const _ServiceDemandCard();

  @override
  Widget build(BuildContext context) {
    const data = [
      ('Servis AC', .82),
      ('Laptop', .66),
      ('Mesin Cuci', .54),
      ('Televisi', .39),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permintaan Layanan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            for (final item in data) ...[
              Row(
                children: [
                  Expanded(child: Text(item.$1)),
                  Text('${(item.$2 * 100).round()}%'),
                ],
              ),
              const SizedBox(height: 7),
              LinearProgressIndicator(value: item.$2, minHeight: 8),
              const SizedBox(height: 17),
            ],
          ],
        ),
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeading(
          title: 'Pengaturan',
          subtitle: 'Konfigurasi dasar platform dan profil administrator.',
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konfigurasi Platform',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Komisi platform',
                      suffixText: '%',
                    ),
                    controller: null,
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Nama admin'),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Email dukungan'),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Simpan Pengaturan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AdminNavItem {
  const _AdminNavItem(this.id, this.label, this.icon);

  final String id;
  final String label;
  final IconData icon;
}
