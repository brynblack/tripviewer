import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripViewer',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class TripCard extends StatelessWidget {
  const TripCard(
      {super.key, required this.to, required this.from, required this.time});

  final String to, from, time;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 35, 35, 35),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    to,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'via $from',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 150, 150, 150)),
                  ),
                ]),
                Text(
                  time,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            )));
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Routes', style: TextStyle(fontSize: 24)),
                    Text('+', style: TextStyle(fontSize: 24)),
                  ],
                )),
            Column(
              children: [
                TripCard(
                  to: 'North Sydney',
                  from: 'Quakers Hill',
                  time: '4:23pm',
                ),
                TripCard(
                  to: 'Central',
                  from: 'Schofields',
                  time: '5:06pm',
                ),
                TripCard(
                  to: 'Linfield',
                  from: 'Central',
                  time: '6:48pm',
                ),
                TripCard(
                  to: 'Harris Park',
                  from: 'Paramatta',
                  time: '7:32pm',
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
