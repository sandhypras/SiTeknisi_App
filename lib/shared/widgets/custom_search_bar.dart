import 'package:flutter/material.dart';

import 'search_bar.dart' as shared;

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Cari layanan',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return shared.SearchBar(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onClear: onClear,
      enabled: enabled,
      autofocus: autofocus,
    );
  }
}
