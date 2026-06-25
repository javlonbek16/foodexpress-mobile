import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLength = 50,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool shouldTrim = widget.text.length > widget.trimLength;

    if (!shouldTrim) {
      return Text(
        widget.text,
        style: const TextStyle(fontSize: 12),
      );
    }

    final String displayedText =
        isExpanded
            ? widget.text
            : '${widget.text.substring(0, widget.trimLength)}...';

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: displayedText),
          TextSpan(
            text: isExpanded ? ' Kamroq' : ' Ko\'proq',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
          ),
        ],
      ),
    );
  }
}