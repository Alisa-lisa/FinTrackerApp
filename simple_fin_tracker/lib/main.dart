import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

enum TransactionDirection { incoming, outgoing }

class _MyHomePageState extends State<MyHomePage> {
	// controllers -> text input
	final _amountController = TextEditingController();  // raw amount
	final _tagsController = TextEditingController();  // transaction function for now strings devided by ;
	final _commentController = TextEditingController();  // transaction coment
	final _accountController = TextEditingController();  // origin of transaction: cash, account1, etc.

	// variables to update
	String? _amount = null;
	String? _tags = null;
	String? _comment = null;
	String? _account = null;
	bool _cost = true;

	Future<void> _showTextInputDialog(BuildContext context) async {
		double screenWidth = MediaQuery.of(context).size.width;
		double screenHeight = MediaQuery.of(context).size.height;
		double dialogWidth = screenWidth * 0.9;
		double dialogHeight = screenHeight * 0.8;
		return showDialog(context: context, builder: (context) {
			return Dialog(
				child: Container(
				width: dialogWidth, 
				height: dialogHeight,
				child: Column(
					children: <Widget>[
						Expanded(child:Padding(
							padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
							child:TextFormField(
								decoration: const InputDecoration(
									border: UnderlineInputBorder(),
									labelText: 'Transaction amount'),
								controller: _amountController,
						))),
						Expanded(child:Padding(
							padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
							child:TextFormField(
							decoration: const InputDecoration(
							border: UnderlineInputBorder(),
							labelText: 'Tags'),
							controller: _tagsController,
						))),
						Expanded(child:Padding(
							padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
							child:TextFormField(
							decoration: const InputDecoration(
							border: UnderlineInputBorder(),
							labelText: 'Comments'),
							controller: _commentController,
						))),
						Expanded(child:Padding(
							padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
							child:TextFormField(
							decoration: const InputDecoration(
							border: UnderlineInputBorder(),
							labelText: 'Account'),
							controller: _accountController,
						))),
						Expanded(child:Padding(
							padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
							child: Row(children: <Widget>[
								Expanded(child:Padding(
									padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
									child:ListTile(
										title: const Text('Outgoing'),
										leading: Radio<bool>(
										value: true,
										groupValue: _cost,
										onChanged: (bool? value) {
											setState(() {_cost = value!;});
										})
									))),
								Expanded(child:Padding(
									padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
									child:ListTile(
										title: const Text('Incoming'),
										leading: Radio<bool>(
										value: false,
										groupValue: _cost,
										onChanged: (bool? value) {
											setState(() {_cost = value!;});
										})
								)))
							]))),
						Padding(
							padding: EdgeInsets.fromLTRB(0, 25, 0, 15),
							child: FloatingActionButton(
								onPressed: () async {
									// await _showTextInputDialog(context);
								},
							child: const Text("Save"),
						))
				])
			  ));
			});
		}

  @override
  Widget build(BuildContext context) {
	if (_amount == null) { _amount = "0.0";}
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
              _amount!,
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
        onPressed: () async {
			await _showTextInputDialog(context);
		},
        tooltip: 'Add new transaction',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
