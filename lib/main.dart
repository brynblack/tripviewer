import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const TripViewer());

class TripViewer extends StatelessWidget {
  const TripViewer({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.pink, brightness: Brightness.light);

  static final _defaultDarkColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'TripViewer',
        theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true),
        darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true),
        home: const HomePage(),
      );
    });
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
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ]),
                Text(
                  time,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )));
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.selectedIcon);

  final int index;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Routes', Icons.train, Icons.train_outlined),
    Destination(1, 'Map', Icons.pin_drop, Icons.pin_drop_outlined),
    Destination(2, 'People', Icons.people, Icons.people_outline),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripViewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            tooltip: 'Options',
            iconSize: 28.0,
            onPressed: () => {},
          )
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent),
      ),
      body: <Widget>[
        ListView(
          children: const [
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
        ),
        const Text('insert map here'),
        const Text('insert people here')
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: allDestinations.map<NavigationDestination>(
          (Destination destination) {
            return NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.title,
            );
          },
        ).toList(),
      ),
    );
  }
}
