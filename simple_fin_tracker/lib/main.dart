import 'package:flutter/material.dart';
import './src/tracking.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TrackingTool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
	
  @override
  Widget build(BuildContext context) {
	String _amount = "0.0";
	// building an input dialog
    return Scaffold(
      appBar: AppBar(
		centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'TBD: last 5 transactions',
            ),
            Text(
              _amount,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
	  bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
			showDialogSuper(context: context, 
				onDismissed: (context) { },
				builder: (context) {return TrackingDialog(path: "PATH");}
			);
			setState((){});
		},
        tooltip: 'Add new transaction',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
