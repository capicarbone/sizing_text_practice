import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class Quote extends StatelessWidget {
  double minFontSize;
  TextSpan text;
  TextAlign align;
  BoxConstraints constraints;

  Quote({this.text, this.constraints, this.minFontSize = 12, this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    var painter = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        textScaleFactor: MediaQuery.of(context).textScaleFactor);

    painter.layout(
        minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);

    var adjusted = false;
    do {
      adjusted = painter.width < constraints.maxWidth &&
          painter.height < constraints.maxHeight;

      if (!adjusted) {
        var currentFontSize = painter.text.style.fontSize;
        var newText = TextSpan(
            text: text.text,
            style: text.style.copyWith(
                fontSize:
                    (currentFontSize - minFontSize) * 0.80 + minFontSize));
        painter.text = newText;
        painter.layout(
            minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
      }
    } while (!adjusted && painter.text.style.fontSize >= minFontSize);

    return SizedBox(
      width: painter.size.width,
      height: painter.size.height,
      child: Text(
        text.text,
        style: painter.text.style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  var texts = [
    "Be water, my friend",
    "You will never be happy if you continue to search for what happiness consists of. You will never live if you are looking for the meaning of life.",
    "Beauty is not in the face; beauty is a light in the heart.",
    "Each time a new war is disclosed in the name of the fight of the good against evil, those who are killed are all poor. It's always the same story repeating once and again and again.",
    "Unreasonable haste is the direct road to error.",
    "There are five freedoms: The freedom to see and hear what is; The freedom to say what you feel and think; The freedom to feel what you actually feel; The freedom to ask for what you want; The freedom to take risks on your own behalf.",
    "Difficult times have helped me to understand better than before how infinitely rich and beautiful life is in every way, and that so many things that one goes worrying about are of no importance whatsoever.",
  ];

  var testText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: Colors.amber,
        child: ListView.builder(
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Quote(
                                text: TextSpan(
                                    text: texts[i],
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Colors.black87)),
                                constraints: constraints,
                              ),
                            );
                          },
                        ),
                      )),
                  Center(
                    child: Container(
                      height: 10,
                      width: 100,
                      color: Colors.black87,
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
