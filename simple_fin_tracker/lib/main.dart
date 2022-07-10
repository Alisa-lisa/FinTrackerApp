import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:path_provider/path_provider.dart';

import './src/tracking.dart';

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
	
	loadCsvFromStorage() async {
		// FilePickerResult? result = await FilePicker.platform.pickFiles(
		// 	allowedExtensions: ['csv'],
		// 	type: FileType.custom,
		// );
		// print(result);
		// String path = "";
		// if (result != null) { 
		// 	List<String?> paths = result.paths.toList();
		// 	print(paths);
		// 	if (paths.length > 0) {path = paths.first!; }
		// }

		// print(path);
		String dir = (await getApplicationDocumentsDirectory()).path;
		final myDir = Directory("$dir/");
		String filePath = "$dir/budget.csv";
		var f = File(filePath).openRead();
		var lines = await f.transform(utf8.decoder).transform(CsvToListConverter()).toList();
		print(lines.length);
		// var _csvFiles = myDir.listSync(recursive: true, followLinks: false);
		// print(_csvFiles);

	}

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
              "TBD",
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
				builder: (context) {
					loadCsvFromStorage();
					return TrackingDialog(path: "PATH");
				}
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
