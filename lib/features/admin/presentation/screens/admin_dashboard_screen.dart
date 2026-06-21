import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/admin_mock_store.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key, required this.section});

  final String section;

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const _items = <_NavItem>[
    _NavItem('dashboard', 'Dashboard', Icons.dashboard_outlined),
    _NavItem('users', 'Pengguna', Icons.people_outline),
    _NavItem('technicians', 'Verifikasi Teknisi', Icons.engineering_outlined),
    _NavItem('services', 'Layanan', Icons.home_repair_service_outlined),
    _NavItem('bookings', 'Booking', Icons.event_note_outlined),
    _NavItem('payments', 'Pembayaran', Icons.payments_outlined),
    _NavItem('invoices', 'Invoice', Icons.receipt_long_outlined),
    _NavItem('reports', 'Laporan', Icons.bar_chart_outlined),
    _NavItem('settings', 'Pengaturan', Icons.settings_outlined),
  ];

  final _store = AdminMockStore.instance;

  String get _section => _items.any((item) => item.id == widget.section)
      ? widget.section
      : 'dashboard';

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 1100;
    return Scaffold(
      drawer: compact ? Drawer(child: _Sidebar(selected: _section)) : null,
      body: Row(
        children: [
          if (!compact)
            SizedBox(width: 260, child: _Sidebar(selected: _section)),
          Expanded(
            child: Column(
              children: [
                _TopBar(compact: compact),
                Expanded(
                  child: ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: AnimatedBuilder(
                      animation: _store,
                      builder: (context, _) => SingleChildScrollView(
                        padding: EdgeInsets.all(compact ? 20 : 32),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1440),
                            child: _buildSection(),
                          ),
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
    );
  }

  Widget _buildSection() {
    if (_section == 'dashboard') return _DashboardOverview(store: _store);
    if (_section == 'reports') return const _ReportsPage();
    if (_section == 'settings') return const _SettingsPage();
    return _CrudPage(section: _section, store: _store);
  }

  void _showNotifications() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifikasi'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NotificationItem(
              Icons.engineering_outlined,
              '2 pengajuan teknisi menunggu review',
            ),
            Divider(),
            _NotificationItem(
              Icons.payments_outlined,
              '1 pembayaran masih pending',
            ),
            Divider(),
            _NotificationItem(
              Icons.event_note_outlined,
              '12 booking dibuat hari ini',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
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
                    child: Image.asset(AppAssets.siteknisiLogo),
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
                  for (final item in _AdminDashboardScreenState._items)
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    final state = context.findAncestorStateOfType<_AdminDashboardScreenState>();
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
          const Expanded(
            child: Text(
              'Pusat Operasional',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (!compact)
            SizedBox(
              width: 280,
              child: TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Gunakan pencarian pada halaman untuk "$value".',
                        ),
                      ),
                    );
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Cari data operasional...',
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
              onPressed: state?._showNotifications,
              icon: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
    );
  }
}

class _CrudConfig {
  const _CrudConfig({
    required this.title,
    required this.subtitle,
    required this.singular,
    required this.fields,
    required this.columns,
    required this.statuses,
    this.canCreate = true,
  });

  final String title;
  final String subtitle;
  final String singular;
  final List<_Field> fields;
  final List<String> columns;
  final List<String> statuses;
  final bool canCreate;
}

const _configs = <String, _CrudConfig>{
  'users': _CrudConfig(
    title: 'Manajemen Pengguna',
    subtitle: 'Kelola akun customer, teknisi, dan administrator.',
    singular: 'Pengguna',
    fields: [
      _Field('name', 'Nama'),
      _Field('contact', 'Email atau telepon'),
      _Field('role', 'Peran', options: ['Customer', 'Teknisi', 'Admin']),
      _Field('joined', 'Tanggal bergabung'),
      _Field('status', 'Status', options: ['Aktif', 'Nonaktif']),
    ],
    columns: ['name', 'contact', 'role', 'joined', 'status'],
    statuses: ['Semua', 'Aktif', 'Nonaktif'],
  ),
  'technicians': _CrudConfig(
    title: 'Verifikasi Teknisi',
    subtitle: 'Periksa identitas, keahlian, dan rekening pendaftar.',
    singular: 'Pengajuan Teknisi',
    fields: [
      _Field('name', 'Nama'),
      _Field('expertise', 'Keahlian'),
      _Field('experience', 'Pengalaman'),
      _Field('submitted', 'Tanggal pengajuan'),
      _Field('bank', 'Rekening'),
      _Field('status', 'Status', options: ['Menunggu', 'Disetujui', 'Ditolak']),
    ],
    columns: ['name', 'expertise', 'experience', 'submitted', 'status'],
    statuses: ['Semua', 'Menunggu', 'Disetujui', 'Ditolak'],
    canCreate: false,
  ),
  'services': _CrudConfig(
    title: 'Manajemen Layanan',
    subtitle: 'Atur kategori layanan yang tampil di marketplace.',
    singular: 'Layanan',
    fields: [
      _Field('name', 'Nama layanan'),
      _Field('description', 'Deskripsi'),
      _Field('technicians', 'Jumlah teknisi'),
      _Field('created', 'Tanggal dibuat'),
      _Field('status', 'Status', options: ['Aktif', 'Nonaktif']),
    ],
    columns: ['name', 'description', 'technicians', 'created', 'status'],
    statuses: ['Semua', 'Aktif', 'Nonaktif'],
  ),
  'bookings': _CrudConfig(
    title: 'Monitoring Booking',
    subtitle: 'Pantau dan perbarui perjalanan pekerjaan.',
    singular: 'Booking',
    fields: [
      _Field('customer', 'Customer'),
      _Field('technician', 'Teknisi'),
      _Field('service', 'Layanan'),
      _Field('payment', 'Pembayaran', options: ['Pending', 'Lunas', 'Gagal']),
      _Field(
        'status',
        'Status',
        options: [
          'Menunggu',
          'Menuju Lokasi',
          'Dikerjakan',
          'Selesai',
          'Dibatalkan',
        ],
      ),
    ],
    columns: ['customer', 'technician', 'service', 'payment', 'status'],
    statuses: ['Semua', 'Menunggu', 'Dikerjakan', 'Selesai', 'Dibatalkan'],
  ),
  'payments': _CrudConfig(
    title: 'Monitoring Pembayaran',
    subtitle: 'Audit transaksi Midtrans dan pembagian pendapatan.',
    singular: 'Pembayaran',
    fields: [
      _Field('booking', 'Booking ID'),
      _Field('method', 'Metode'),
      _Field('amount', 'Nilai'),
      _Field('commission', 'Komisi'),
      _Field('status', 'Status', options: ['Pending', 'Lunas', 'Gagal']),
    ],
    columns: ['booking', 'method', 'amount', 'commission', 'status'],
    statuses: ['Semua', 'Pending', 'Lunas', 'Gagal'],
  ),
  'invoices': _CrudConfig(
    title: 'Monitoring Invoice',
    subtitle: 'Cari dan audit invoice seluruh transaksi platform.',
    singular: 'Invoice',
    fields: [
      _Field('booking', 'Booking ID'),
      _Field('customer', 'Customer'),
      _Field('technician', 'Teknisi'),
      _Field('total', 'Total'),
      _Field('status', 'Status', options: ['Draft', 'Terbit', 'Dibatalkan']),
    ],
    columns: ['booking', 'customer', 'technician', 'total', 'status'],
    statuses: ['Semua', 'Draft', 'Terbit', 'Dibatalkan'],
  ),
};

class _CrudPage extends StatefulWidget {
  const _CrudPage({required this.section, required this.store});

  final String section;
  final AdminMockStore store;

  @override
  State<_CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<_CrudPage> {
  final _searchController = TextEditingController();
  String _status = 'Semua';

  _CrudConfig get config => _configs[widget.section]!;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminRecord> get filteredRecords {
    final query = _searchController.text.toLowerCase().trim();
    return widget.store.records(widget.section).where((record) {
      final matchesQuery =
          query.isEmpty ||
          record.id.toLowerCase().contains(query) ||
          record.values.values.any(
            (value) => value.toLowerCase().contains(query),
          );
      final matchesStatus =
          _status == 'Semua' || record.values['status'] == _status;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final records = filteredRecords;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PageHeading(
          title: config.title,
          subtitle: config.subtitle,
          actionLabel: config.canCreate ? 'Tambah ${config.singular}' : null,
          onAction: config.canCreate ? () => _openForm() : null,
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Cari ${config.singular.toLowerCase()}...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Hapus pencarian',
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    initialValue: _status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: config.statuses
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _status = value ?? 'Semua'),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _status = 'Semua');
                  },
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _DataPanel(
          title: 'Daftar ${config.title}',
          config: config,
          records: records,
          onView: _showDetail,
          onEdit: _openForm,
          onDelete: _confirmDelete,
          onApprove: widget.section == 'technicians'
              ? (record) => _setTechnicianStatus(record, 'Disetujui')
              : null,
          onReject: widget.section == 'technicians'
              ? (record) => _setTechnicianStatus(record, 'Ditolak')
              : null,
        ),
      ],
    );
  }

  Future<void> _openForm([AdminRecord? record]) async {
    final controllers = {
      for (final field in config.fields)
        field.key: TextEditingController(text: record?.values[field.key] ?? ''),
    };
    final formKey = GlobalKey<FormState>();
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          record == null
              ? 'Tambah ${config.singular}'
              : 'Edit ${config.singular}',
        ),
        content: SizedBox(
          width: 520,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final field in config.fields) ...[
                    if (field.options == null)
                      TextFormField(
                        controller: controllers[field.key],
                        decoration: InputDecoration(labelText: field.label),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? '${field.label} wajib diisi'
                            : null,
                      )
                    else
                      DropdownButtonFormField<String>(
                        initialValue:
                            field.options!.contains(
                              controllers[field.key]!.text,
                            )
                            ? controllers[field.key]!.text
                            : field.options!.first,
                        decoration: InputDecoration(labelText: field.label),
                        items: field.options!
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            controllers[field.key]!.text = value ?? '',
                      ),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              for (final field in config.fields) {
                if (field.options != null &&
                    controllers[field.key]!.text.isEmpty) {
                  controllers[field.key]!.text = field.options!.first;
                }
              }
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, {
                  for (final entry in controllers.entries)
                    entry.key: entry.value.text.trim(),
                });
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    for (final controller in controllers.values) {
      controller.dispose();
    }
    if (result == null || !mounted) return;
    if (record == null) {
      widget.store.create(widget.section, result);
    } else {
      widget.store.update(widget.section, record.id, result);
    }
    _notify(
      record == null ? 'Data berhasil ditambahkan' : 'Data berhasil diperbarui',
    );
  }

  void _showDetail(AdminRecord record) {
    final isTechnician = widget.section == 'technicians';
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.description_outlined, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(child: Text('${config.singular} ${record.id}')),
          ],
        ),
        content: SizedBox(
          width: isTechnician ? 780 : 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isTechnician) ...[
                  _TechnicianDocuments(record: record),
                  const SizedBox(height: 22),
                  const Divider(),
                  const SizedBox(height: 8),
                ],
                for (final field in config.fields)
                  _DetailRow(
                    label: field.label,
                    value: record.values[field.key] ?? '-',
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _openForm(record);
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(AdminRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline, color: AppColors.error),
        title: Text('Hapus ${config.singular}?'),
        content: Text('Data ${record.id} akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    widget.store.delete(widget.section, record.id);
    _notify('Data berhasil dihapus');
  }

  void _setTechnicianStatus(AdminRecord record, String status) {
    widget.store.setStatus(widget.section, record.id, status);
    _notify('Pengajuan ${record.values['name']} $status');
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: 'Tutup', onPressed: () {}),
        ),
      );
  }
}

class _DataPanel extends StatelessWidget {
  const _DataPanel({
    required this.title,
    required this.config,
    required this.records,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    this.onApprove,
    this.onReject,
  });

  final String title;
  final _CrudConfig config;
  final List<AdminRecord> records;
  final ValueChanged<AdminRecord> onView;
  final ValueChanged<AdminRecord> onEdit;
  final ValueChanged<AdminRecord> onDelete;
  final ValueChanged<AdminRecord>? onApprove;
  final ValueChanged<AdminRecord>? onReject;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
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
                  '${records.length} data',
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (records.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off_outlined,
                    size: 48,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(height: 12),
                  Text('Data tidak ditemukan'),
                  SizedBox(height: 4),
                  Text(
                    'Ubah kata pencarian atau filter status.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ],
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 28,
                horizontalMargin: 20,
                headingRowHeight: 54,
                dataRowMinHeight: 64,
                dataRowMaxHeight: 72,
                headingRowColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.surfaceContainerLowest,
                ),
                columns: [
                  const DataColumn(label: Text('ID', softWrap: false)),
                  for (final key in config.columns)
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: _columnWidth(key),
                        ),
                        child: Text(
                          _labelFor(config, key),
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  const DataColumn(
                    label: SizedBox(
                      width: 220,
                      child: Text('Aksi', softWrap: false),
                    ),
                  ),
                ],
                rows: [
                  for (final record in records)
                    DataRow(
                      cells: [
                        DataCell(
                          SelectableText(
                            record.id,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        for (final key in config.columns)
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: _columnWidth(key),
                                maxWidth: _columnWidth(key) + 70,
                              ),
                              child: key == 'status'
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: _TableStatus(
                                        label: record.values[key] ?? '-',
                                      ),
                                    )
                                  : Text(
                                      record.values[key] ?? '-',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ),
                        DataCell(
                          SizedBox(
                            width: 220,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Lihat detail',
                                  onPressed: () => onView(record),
                                  icon: const Icon(Icons.visibility_outlined),
                                ),
                                if (onApprove != null &&
                                    record.values['status'] == 'Menunggu') ...[
                                  IconButton(
                                    tooltip: 'Setujui',
                                    onPressed: () => onApprove!(record),
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.success,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Tolak',
                                    onPressed: () => onReject!(record),
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                                IconButton(
                                  tooltip: 'Edit',
                                  onPressed: () => onEdit(record),
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                                IconButton(
                                  tooltip: 'Hapus',
                                  onPressed: () => onDelete(record),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Menampilkan ${records.length} data',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _labelFor(_CrudConfig config, String key) =>
      config.fields.firstWhere((field) => field.key == key).label;

  static double _columnWidth(String key) => switch (key) {
    'name' || 'customer' || 'technician' => 150,
    'contact' || 'description' || 'bank' => 190,
    'expertise' || 'service' => 140,
    'joined' || 'submitted' || 'created' => 125,
    'status' || 'payment' || 'role' => 105,
    'experience' || 'method' => 110,
    'amount' || 'commission' || 'total' => 115,
    'booking' => 145,
    _ => 100,
  };
}

class _DashboardOverview extends StatelessWidget {
  const _DashboardOverview({required this.store});

  final AdminMockStore store;

  @override
  Widget build(BuildContext context) {
    final pending = store
        .records('technicians')
        .where((record) => record.values['status'] == 'Menunggu')
        .length;
    final activeBookings = store
        .records('bookings')
        .where(
          (record) =>
              !['Selesai', 'Dibatalkan'].contains(record.values['status']),
        )
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeading(
          title: 'Dashboard',
          subtitle: 'Ringkasan operasional SiTeknisi hari ini.',
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
              childAspectRatio: columns == 1 ? 3 : 2.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _KpiCard(
                  'Total Pengguna',
                  '${store.records('users').length}',
                  'Kelola data',
                  Icons.people_outline,
                  AppColors.primary,
                  () => context.go('/admin/users'),
                ),
                _KpiCard(
                  'Booking Aktif',
                  '$activeBookings',
                  'Pantau progres',
                  Icons.event_note_outlined,
                  AppColors.secondary,
                  () => context.go('/admin/bookings'),
                ),
                _KpiCard(
                  'Menunggu Verifikasi',
                  '$pending',
                  'Perlu ditinjau',
                  Icons.verified_user_outlined,
                  AppColors.warning,
                  () => context.go('/admin/technicians'),
                ),
                _KpiCard(
                  'Pembayaran',
                  '${store.records('payments').length}',
                  'Audit transaksi',
                  Icons.account_balance_wallet_outlined,
                  AppColors.success,
                  () => context.go('/admin/payments'),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Aksi Cepat',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/admin/reports'),
                      child: const Text('Lihat laporan'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: () => context.go('/admin/technicians'),
                      icon: const Icon(Icons.fact_check_outlined),
                      label: const Text('Review Teknisi'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/admin/bookings'),
                      icon: const Icon(Icons.event_note_outlined),
                      label: const Text('Pantau Booking'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/admin/services'),
                      icon: const Icon(Icons.add_business_outlined),
                      label: const Text('Kelola Layanan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(
    this.label,
    this.value,
    this.detail,
    this.icon,
    this.color,
    this.onTap,
  );

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
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
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportsPage extends StatefulWidget {
  const _ReportsPage();

  @override
  State<_ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<_ReportsPage> {
  String _range = '7 hari terakhir';

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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<String>(
                    initialValue: _range,
                    decoration: const InputDecoration(labelText: 'Periode'),
                    items: ['7 hari terakhir', '30 hari terakhir', 'Tahun ini']
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _range = value ?? _range),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Laporan $_range diperbarui')),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Terapkan'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
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
                        child: Tooltip(
                          message: '${height.round()} booking',
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
      ('Servis Laptop', .82),
      ('Laptop', .66),
      ('Komputer', .54),
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

class _SettingsPage extends StatefulWidget {
  const _SettingsPage();

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _commission = TextEditingController(text: '10');
  final _name = TextEditingController(text: 'Sandhy Admin');
  final _email = TextEditingController(text: 'support@siteknisi.id');

  @override
  void dispose() {
    _commission.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Konfigurasi Platform',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _commission,
                      decoration: const InputDecoration(
                        labelText: 'Komisi platform',
                        suffixText: '%',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final number = double.tryParse(value ?? '');
                        if (number == null || number < 0 || number > 100) {
                          return 'Masukkan nilai 0 sampai 100';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Nama admin',
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        labelText: 'Email dukungan',
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pengaturan berhasil disimpan'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Simpan Pengaturan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Wajib diisi' : null;
}

class _PageHeading extends StatelessWidget {
  const _PageHeading({
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        );
        final action = actionLabel == null
            ? null
            : FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!, softWrap: false),
              );
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading,
              if (action != null) ...[const SizedBox(height: 16), action],
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: heading),
            if (action != null) ...[const SizedBox(width: 24), action],
          ],
        );
      },
    );
  }
}

class _TechnicianDocuments extends StatelessWidget {
  const _TechnicianDocuments({required this.record});

  final AdminRecord record;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.badge_outlined, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              'Dokumen Verifikasi',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 620;
            final profile = _DocumentPreview(
              title: 'Foto Profil',
              imageUrl: record.values['profilePhotoUrl'],
              icon: Icons.person_outline,
              aspectRatio: 1,
            );
            final ktp = _DocumentPreview(
              title: 'Foto KTP',
              imageUrl: record.values['ktpPhotoUrl'],
              icon: Icons.credit_card_outlined,
              aspectRatio: 1.58,
            );
            if (compact) {
              return Column(
                children: [profile, const SizedBox(height: 14), ktp],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: profile),
                const SizedBox(width: 16),
                Expanded(flex: 3, child: ktp),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _DocumentPreview extends StatelessWidget {
  const _DocumentPreview({
    required this.title,
    required this.imageUrl,
    required this.icon,
    required this.aspectRatio,
  });

  final String title;
  final String? imageUrl;
  final IconData icon;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                border: Border.all(color: AppColors.border),
              ),
              child: hasImage
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          _DocumentPlaceholder(icon: icon),
                    )
                  : _DocumentPlaceholder(icon: icon),
            ),
          ),
        ),
      ],
    );
  }
}

class _DocumentPlaceholder extends StatelessWidget {
  const _DocumentPlaceholder({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 42, color: AppColors.textMuted),
          const SizedBox(height: 8),
          const Text(
            'Belum ada gambar',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
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
    final warning = ['Menunggu', 'Pending', 'Draft'].contains(label);
    final success = [
      'Aktif',
      'Lunas',
      'Terbit',
      'Disetujui',
      'Selesai',
    ].contains(label);
    final error = [
      'Gagal',
      'Ditolak',
      'Dibatalkan',
      'Nonaktif',
    ].contains(label);
    final color = warning
        ? AppColors.warningText
        : success
        ? AppColors.successText
        : error
        ? AppColors.errorText
        : AppColors.infoText;
    final background = warning
        ? AppColors.warningContainer
        : success
        ? AppColors.successContainer
        : error
        ? AppColors.errorContainer
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: AppColors.primaryLight,
      child: Icon(icon, color: AppColors.primary),
    ),
    title: Text(text),
  );
}

class _Field {
  const _Field(this.key, this.label, {this.options});
  final String key;
  final String label;
  final List<String>? options;
}

class _NavItem {
  const _NavItem(this.id, this.label, this.icon);
  final String id;
  final String label;
  final IconData icon;
}
