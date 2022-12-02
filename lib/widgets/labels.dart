import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String subTitle;
  final String title;

  const Labels({
    Key? key,
    required this.route,
    required this.subTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            subTitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                route,
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff1a535c),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
