import 'package:flutter/material.dart';

class categoryWidget extends StatelessWidget {
  bool isSelected;
  String eventName;

  categoryWidget({
    super.key,
    required this.eventName,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).focusColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).focusColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textAlign: TextAlign.center,
          eventName,
          style: isSelected
              ? Theme.of(context).textTheme.labelMedium
              : Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
