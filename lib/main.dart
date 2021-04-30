import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Auto Text Test'),
    );
  }
}

class QuotePainter extends CustomPainter {
  TextSpan text;
  BoxConstraints constraints;

  QuotePainter({this.text, this.constraints});

  @override
  void paint(Canvas canvas, Size size) {

    var painter = TextPainter(
        text: text ,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        textScaleFactor: 1
    );

    painter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);

    var adjusted = false;
    do{
      adjusted = painter.width < constraints.maxWidth && painter.height < constraints.maxHeight;

      if (!adjusted) {
        var currentFontSize = painter.text.style.fontSize;
        var newText = TextSpan(text: text.text, style: text.style.copyWith(fontSize: (currentFontSize - 12)*0.80 + 12));
        painter.text = newText;
        painter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
      }

    }while(!adjusted && painter.text.style.fontSize >= 12);

    painter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return true;
  }

}

class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  var testText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          width: double.infinity,
          height: 200,
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return CustomPaint(painter: QuotePainter(text: TextSpan(text: testText, style: TextStyle(fontSize: 30)), constraints: constraints));
            },) ,)
            //Text(testText, style: TextStyle(fontSize: 50), textAlign: TextAlign.center,),
          ),
        ),
    );
  }
}
