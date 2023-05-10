import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clicker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color.fromRGBO(244,134,135,1),
      ),
      home: const MyHomePage(title: 'Clicker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double widthbase = 100;
  double heightbase = 100;



  void _incrementCounter() {
    setState(() {
      _counter += 5;
      if (_counter == 200) {
        var padding = MediaQuery.of(context).viewPadding;
        widthbase = MediaQuery.of(context).size.width;
        heightbase = MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final bool showWinner = _counter == 200;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _incrementCounter();
                  if (_counter <= 200) {
                    if (_counter % 2 == 0) {
                      widthbase += 10;
                    } else {
                      heightbase += 10;
                    }
                  } else {
                    _counter = 0;
                    widthbase = 100;
                    heightbase = 100;
                  }
                });
              },
              onLongPress: () {
                setState(() {
                  _counter = 0;
                  widthbase = 100;
                  heightbase = 100;
                });
              },
              child: AnimatedContainer(
                width: widthbase,
                height: heightbase,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 134, 135, 1),
                  borderRadius: showWinner
                      ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  )
                      : BorderRadius.circular(20),
                ),
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showWinner ?
                    Image.asset(
                      'assets/tetris.gif',
                      width: 300,
                      height: 200,
                    ) :
                    Icon(
                      showWinner ? null :
                      Icons.touch_app,
                      size: 25,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      showWinner ? '' : '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
