class AdminRecord {
  final String id;
  final String type;
  final String title;
  final String status;
  final Map<String, dynamic> data;
  final Map<String, dynamic> values;
  
  AdminRecord({required this.id, required this.type, required this.title, required this.status, required this.data, Map<String, dynamic>? values}) : values = values ?? data;
}

class AdminMockStore {
  static final AdminMockStore instance = AdminMockStore._();
  AdminMockStore._();
  
  final List<AdminRecord> _records = [];
  
  List<AdminRecord> records(String type) => _records.where((r) => r.type == type).toList();
  
  void create(String type, Map<String, dynamic> data) {
    _records.add(AdminRecord(id: DateTime.now().toString(), type: type, title: data['name'] ?? '', status: 'active', data: data, values: data));
  }
  
  void update(String type, String id, Map<String, dynamic> data) {
    final index = _records.indexWhere((r) => r.id == id);
    if (index != -1) {
      _records[index] = AdminRecord(id: id, type: type, title: data['name'] ?? '', status: _records[index].status, data: data, values: data);
    }
  }
  
  void delete(String type, String id) => _records.removeWhere((r) => r.id == id && r.type == type);
  
  void setStatus(String type, String id, String status) {
    final index = _records.indexWhere((r) => r.id == id && r.type == type);
    if (index != -1) {
      final rec = _records[index];
      _records[index] = AdminRecord(id: rec.id, type: rec.type, title: rec.title, status: status, data: rec.data, values: rec.values);
    }
  }
}
