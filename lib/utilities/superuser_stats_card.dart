import 'package:flutter/material.dart';

class SuperUserStatsCard extends StatelessWidget {
  final String value;
  final String title;
  final Color cardColor;

  const SuperUserStatsCard({
    Key? key,
    required this.value,
    required this.title,
    required this.cardColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.05,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
