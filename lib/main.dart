import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // main entry point
}

// app bar, scaffold, text
class MyApp extends StatelessWidget {
  // root, constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // grab all common features with theme, navigate, title
      home: DefaultTabController(
        length: 4, // how many tabs
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    // lifecycle
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this, // makes animation run smooth
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // used whenever you move, only load one tab at a time
    _tabController.dispose(); // release all resources, prevent memory leaks
    tabIndex.dispose();
    super.dispose(); // ref parent class
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      // standard layout for screen
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController, // highlight active tab
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content: Text("This is an alert"),
                          actions: [
                            TextButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Show Alert"),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://media.istockphoto.com/id/1463580205/photo/united-states-marines-boeing-f-a-18d-hornet-multirole-fighter-from-vmfa-225-vikings.jpg?s=612x612&w=0&k=20&c=oPI7IJBFPbL0oiUwZ9Gu55c0wIy3JxtdGwGg0-ZIkww=',
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Text',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Button was pressed')));
              },
              child: Text('click'),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Item 1'),
                  subtitle: Text('This is a colored in star'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Item 2'),
                  subtitle: Text('This is a star outline'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Item 3'),
                  subtitle: Text('This is a colored in heart'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
