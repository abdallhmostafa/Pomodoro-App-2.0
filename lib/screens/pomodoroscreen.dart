import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';


class PomodoroAppV2 extends StatefulWidget {
  const PomodoroAppV2({Key? key}) : super(key: key);

  @override
  State<PomodoroAppV2> createState() => _PomodoroAppV2State();
}

class _PomodoroAppV2State extends State<PomodoroAppV2> {
  static Duration initialDuration = const Duration(minutes:25);
  int minute = 25;
  int second = 0;
  Timer? timerFunc;
  bool isTimerRunning = false;
  bool isTimerStop= true;
  startTimer()  {
    timerFunc = Timer.periodic(const Duration(seconds : 1), (timer) {
      setState(() {
        int newSecond = initialDuration.inSeconds - 1;
        initialDuration = Duration(seconds: newSecond);
        second = initialDuration.inSeconds.remainder(60);
        minute = initialDuration.inMinutes.remainder(60);
        if (initialDuration.inSeconds==0) {
          timer.cancel();
          setState(() {
            isTimerRunning=false;
            initialDuration = const Duration(minutes:25);
            minute=initialDuration.inMinutes ;
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,

        leadingWidth: 30.0,

        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
             Text("Pomodoro",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30.0,letterSpacing: 7.0,color: Colors.white),),
            SizedBox(width: 10.0,),
             Icon(Icons.watch_later,color: Colors.white,size: 30.0,)
          ],
        ),

      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircularPercentIndicator(
                  radius: 125.0,
                   curve: Curves.ease,

                   animation: true,
                  animateFromLastPercent: true,
                  lineWidth: 7.0,
                  animationDuration: 1000,
                  percent:initialDuration.inMinutes.toDouble()/ 25,
                  backgroundColor: Colors.grey,
                  progressColor:isTimerStop?  Colors.blueAccent :Colors.red,
                   center:Text(
                     "${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2,"0")}",
                     style: const TextStyle(
                         fontWeight: FontWeight.w700,
                         fontSize: 65.0,
                         color: Colors.white,
                         letterSpacing: 7.0),
                   ),

                ),


        ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            isTimerRunning
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  const SizedBox(width: 20.0,),
                ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            const Size(200.0, 45.0)),
                        backgroundColor: timerFunc!.isActive
                            ? MaterialStateProperty.all(Colors.red)
                            : MaterialStateProperty.all(
                            Colors.blueAccent),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 10.0)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0))),
                        alignment: Alignment.center),
                    onPressed: () {
                      setState(() {
                        if (timerFunc!.isActive) {
                          timerFunc!.cancel();
                          isTimerStop=true;
                        } else {
                          isTimerStop=false;

                          startTimer();
                        }
                      });
                    },
                    child: Text(
                      timerFunc!.isActive ? "Stop Studying!" : "Resume Studying",
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            const Size(120.0, 45.0)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0))),
                        alignment: Alignment.center),
                    onPressed: () {
                      setState(() {
                        timerFunc!.cancel();
                        second = 0;
                        minute = 25;
                        initialDuration = const Duration(minutes: 25);
                        isTimerRunning = false;

                      });
                    },
                    child: const Text(
                      "Cansel",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            )
                : ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                    MaterialStateProperty.all(const Size(200.0, 45.0)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.blueAccent),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    alignment: Alignment.center),
                onPressed: () {
                  startTimer();
                  setState(() {
                    isTimerRunning = true;
                    isTimerStop=false;
                  });
                },
                child: const Text(
                  "Start Studying",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        ),
      ),
    );

  }
}
