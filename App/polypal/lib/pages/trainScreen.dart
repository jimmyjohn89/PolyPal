import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polypal/pages/launchScreen.dart';
import 'package:polypal/models/PolyTimer.dart';
import 'package:flutter_beep/flutter_beep.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  //timer/stopwatch
  Stopwatch stopwatch = Stopwatch();
  Stopwatch reactionStopwatch = Stopwatch();
  bool state = false;
  int start = 0;
  int stop = 0;
  int dif = 0;
  Color stateColor1 = Colors.white;
  Color stateColor2 = Colors.white;
  int reaction1 = 0;
  int reaction2 = 0;
  int time = 0;
  //int durMil = 500;
  bool isStarted = false;

  double _bpmSliderValue = 20;
  int subD1 = 2;
  int subD2 = 3;

  PolyTimer poly = PolyTimer();

  bool selected = false;
  bool selected2 = false;
  bool selectedB = false;
  bool selectedB2 = false;
  bool isPressed = false;
  bool isPressed2 = false;

  Color thumbColor = Colors.transparent;

  // int getTime() {
  //   return reactionStopwatch.elapsedMilliseconds;
  // }

  // int compareTime() {
  //   int cmp = getTime() - time;
  //   if (cmp > durMil / 2) {
  //     return cmp - durMil;
  //   }
  //   return cmp;
  //   //return getTime() - time;
  // }

  void callbackFunction() {
    FlutterBeep.playSysSound(iOSSoundIDs.TouchTone1);
    setState(() {
      stateColor1 = Colors.teal;
      selected = !selected;
    });
    Future.delayed(Duration(milliseconds: poly.getDuration1()), () {
      setState(() {
        selected2 = !selected2;
      });
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        stateColor1 = Colors.white;
      });
    });
  }

  void callbackFunction2() {
    FlutterBeep.playSysSound(iOSSoundIDs.TouchTone2);
    setState(() {
      stateColor2 = Colors.teal;
      selectedB = !selectedB;
    });
    Future.delayed(Duration(milliseconds: poly.getDuration2()), () {
      setState(() {
        selectedB2 = !selectedB2;
      });
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        stateColor2 = Colors.white;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    reactionStopwatch.start();
    super.initState();
  }

  @override
  void dispose() {
    stopwatch.stop();
    stopwatch.reset();
    reactionStopwatch.stop();
    reactionStopwatch.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/second');
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(seconds: 2),
                      pageBuilder: (_, __, ___) => const LaunchScreen(),
                    ),
                  );
                  stopwatch.stop();
                  stopwatch.reset();
                  reactionStopwatch.stop();
                  reactionStopwatch.reset();
                  poly.disposePolyTimer();
                  //dispose();
                },
                child: Hero(
                  tag: 'PolyPal',
                  child: RichText(
                    text: const TextSpan(
                      //text: '',
                      //style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Poly',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 45)),
                        TextSpan(
                            text: 'Pal',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 45)),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                //L and R pulse indicators
                children: [
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: stateColor1,
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: const [
                          Text(
                            'L',
                            style: TextStyle(
                                color: Colors.tealAccent, fontSize: 65),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: stateColor2,
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: const [
                          Text(
                            'R',
                            style: TextStyle(
                                color: Colors.amberAccent, fontSize: 65),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ), //*L and R pulse indicator end
              SizedBox(
                //animated falling notes / icons
                width: 200,
                height: 350,
                child: Stack(
                  children: <Widget>[
                    //LEFT
                    AnimatedPositioned(
                      left: 0,
                      bottom: selected ? 8 : 300.0,
                      duration: Duration(milliseconds: poly.getDuration1()),
                      //curve: Curves.bounceIn,
                      child: Icon(
                        Icons.circle,
                        color: selected ? Colors.teal : Colors.transparent,
                      ),
                    ),
                    AnimatedPositioned(
                      left: 0,
                      bottom: !selected ? 8 : 300.0,
                      duration: Duration(milliseconds: poly.getDuration1()),
                      //curve: Curves.bounceIn,
                      child: Icon(Icons.circle,
                          color: selected2 ? Colors.teal : Colors.transparent),
                    ),
                    //beat marker icon
                    const Positioned(
                        bottom: 8,
                        left: 0,
                        child: Icon(Icons.circle_outlined, color: Colors.teal)),
                    //RIGHT
                    AnimatedPositioned(
                      right: 0,
                      bottom: selectedB ? 8 : 300.0,
                      duration: Duration(milliseconds: poly.getDuration2()),
                      //curve: Curves.bounceIn,
                      child: Icon(
                        Icons.circle,
                        color: selectedB ? Colors.teal : Colors.transparent,
                      ),
                    ),
                    AnimatedPositioned(
                      right: 0,
                      bottom: !selectedB ? 8 : 300.0,
                      duration: Duration(milliseconds: poly.getDuration2()),
                      //curve: Curves.bounceIn,
                      child: Icon(Icons.circle,
                          color: selectedB2 ? Colors.teal : Colors.transparent),
                    ),
                    //beat marker icon
                    const Positioned(
                        bottom: 8,
                        right: 0,
                        child: Icon(Icons.circle_outlined, color: Colors.teal)),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      //Text('$reaction1'),
                      // SliderTheme(
                      //   data: const SliderThemeData(
                      //     thumbColor: Colors.black,
                      //     thumbShape:
                      //         RoundSliderThumbShape(enabledThumbRadius: 4),
                      //     activeTrackColor: Colors.grey,

                      //     inactiveTrackColor: Colors.grey,
                      //   ),
                      //   child: Slider(
                      //     min: -poly.getDuration1(2).toDouble(),
                      //     max: poly.getDuration1(2).toDouble(),
                      //     value: reaction1.toDouble(),
                      //     onChanged: (val) {},
                      //   ),
                      // ),
                      !isPressed
                          ? const Icon(Icons.thumbs_up_down,
                              color: Colors.transparent)
                          : Icon(
                              reaction1 <= 150 && reaction1 >= -150
                                  ? Icons.thumb_up_rounded
                                  : Icons.thumb_down_rounded,
                              color: reaction1 <= 150 && reaction1 >= -150
                                  ? Colors.green
                                  : Colors.red),
                      AnimatedContainer(
                        height: 70,
                        width: 70,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                        child: Material(
                          color: Colors.tealAccent,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                  child: Text("Tap",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPressed = true;
                                    //sideLength == 50 ? sideLength = 100 : sideLength = 50;
                                    reaction1 = poly.compareTime1();
                                    Future.delayed(
                                        Duration(
                                            milliseconds:
                                                poly.getDuration1() - 150), () {
                                      reaction1 = -12118702;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      //Text(accuracyString(reaction2, 150)),
                      !isPressed2
                          ? const Icon(Icons.thumbs_up_down,
                              color: Colors.transparent)
                          : Icon(
                              reaction2 <= 150 && reaction2 >= -150
                                  ? Icons.thumb_up_rounded
                                  : Icons.thumb_down_rounded,
                              color: reaction2 <= 150 && reaction2 >= -150
                                  ? Colors.green
                                  : Colors.red),
                      AnimatedContainer(
                        height: 70,
                        width: 70,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                        child: Material(
                          color: Colors.yellow,
                          child: Stack(children: <Widget>[
                            Center(
                                child: Text("Tap",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  //sideLength == 50 ? sideLength = 100 : sideLength = 50;
                                  isPressed2 = true;
                                  reaction2 = poly.compareTime2();
                                  Future.delayed(
                                      Duration(
                                          milliseconds:
                                              poly.getDuration2() - 150), () {
                                    reaction2 = -12118702;
                                  });
                                });
                              },
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              // ElevatedButton.icon(
              //   onPressed: state
              //       ? () {
              //           stopwatch.stop();
              //           stop = stopwatch.elapsedMilliseconds;
              //           setState(() {
              //             dif = stop - start;
              //             state = !state;
              //           });
              //         }
              //       : () {
              //           stopwatch.start();
              //           start = stopwatch.elapsedMilliseconds;
              //           setState(() {
              //             state = !state;
              //           });
              //         },
              //   icon: const Icon(Icons.join_full_sharp),
              //   label: const Text('Time Difference'),
              // ),
              // Text('$dif'),
              const Spacer(flex: 2),
              Row(
                children: [
                  const Spacer(),
                  DropdownButton<int>(
                    iconEnabledColor: Colors.tealAccent,
                    dropdownColor: Colors.tealAccent,
                    //Don't forget to pass your variable to the current value
                    value: subD1,
                    items: <int>[1, 2, 3, 4, 5, 6, 7].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    //On changed update the variable name and don't forgot the set state!
                    onChanged: !isStarted
                        ? (newValue) {
                            //SystemSound.play(SystemSoundType.click);
                            setState(() {
                              subD1 = newValue!;
                            });
                          }
                        : null,
                  ),
                  const Spacer(),
                  const Text(
                    'BPM',
                    style: TextStyle(color: Colors.teal),
                  ),
                  Slider(
                    value: _bpmSliderValue,
                    min: 20,
                    max: 220,
                    divisions: 5,
                    label: _bpmSliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _bpmSliderValue = value;
                        poly.disposePolyTimer();
                        setState(() {
                          isStarted = false;
                        });
                        //start
                        poly.createPolyTimer(_bpmSliderValue.round(), subD1,
                            subD2, callbackFunction, callbackFunction2, () {});
                        setState(() {
                          isStarted = true;
                        });
                      });
                    },
                  ),
                  const Spacer(),
                  //const SizedBox(width: 32),
                  DropdownButton<int>(
                    iconEnabledColor: Colors.amberAccent,
                    dropdownColor: Colors.amberAccent,
                    //Don't forget to pass your variable to the current value
                    value: subD2,
                    items: <int>[1, 2, 3, 4, 5, 6, 7].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    //On changed update the variable name and don't forgot the set state!
                    onChanged: !isStarted
                        ? (newValue) {
                            //SystemSound.play(SystemSoundType.click);
                            setState(() {
                              subD2 = newValue!;
                            });
                          }
                        : null,
                  ),
                  const Spacer(),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (!isStarted) {
                    poly.createPolyTimer(_bpmSliderValue.round(), subD1, subD2,
                        callbackFunction, callbackFunction2, () {});
                    setState(() {
                      isStarted = true;
                    });
                  } else {
                    poly.disposePolyTimer();
                    setState(() {
                      isStarted = false;
                      isPressed = false;
                      isPressed2 = false;
                    });
                  }
                },
                icon: isStarted
                    ? const Icon(Icons.stop)
                    : const Icon(Icons.play_arrow),
                label: isStarted ? const Text('Stop') : const Text('Start'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> positiveFeedback = ["Nice!", "Good!", "Perfect!"];
int max = positiveFeedback.length;
int randomNumber = Random().nextInt(max);
int counter = 0;

String accuracyString(int reaction, int limit) {
  if (reaction < -limit) return "Early";
  if (reaction > limit) return "Late";
  if (reaction == 0) {
    return "";
  }
  if (reaction == -12118702) {
    return "Miss";
  } else {
    return positiveFeedback[counter % max];
  }
}

////TODO:
///-isolate
///-
