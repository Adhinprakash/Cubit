
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final String? title;
  final List<String>? contents;
  final ValueChanged<String>? onChanged;

  const ColorSelector({
    super.key,
    this.contents,
    this.onChanged,
    this.title
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late String selected = widget.contents?.first??''; 

  Future<void> _openSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
               Text(
                'Select ${widget.title}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.contents!.map((c) {
                  final isSelected = c == selected;
                  return ChoiceChip(
                    label: Text(c),
                    selected: isSelected,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                    selectedColor: Colors.black87,
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    onSelected: (_) => Navigator.pop(context, c),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );

    if (result != null && result != selected) {
      setState(() => selected = result);
      widget.onChanged?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openSheet,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title??'',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  selected,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
    );
  }
}