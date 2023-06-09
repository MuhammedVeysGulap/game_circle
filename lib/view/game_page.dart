// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Timer timer1;

  bool baslat = true;
  double sag = 10,
      ust = 70,
      sol = 25,
      ustIki = 70,
      solIki = 175,
      zeminTopPositoned = 650,
      balonYukseklik = 70,
      solUc = 315,
      ustUc = 70;
  int puan = 0, hiz = 1;
  void start() {
    print("OYUN BAŞLADI");
    setState(() {
      timer1 = Timer.periodic(const Duration(milliseconds: 40), (timer) {
        setState(() {
          ust = ust + hiz;
          ustIki = ustIki + hiz;
          ustUc = ustUc + hiz;
          if (puan < 100) {
            ustIki = -80;
          }
          if (puan < 200) {
            ustUc = -80;
          }
          if (ust + balonYukseklik >= zeminTopPositoned ||
              ustIki + balonYukseklik >= zeminTopPositoned ||
              ustUc + balonYukseklik >= zeminTopPositoned) {
            timer1.cancel();

            showDialog(
              barrierColor: const Color.fromARGB(110, 244, 242, 242),
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: Center(
                  child: Text(
                    "GAME OVER",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                content: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GamePage()));
                    },
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 50,
                      color: Colors.black,
                    )),
              ),
            );
            print('OYUN BİTTİ');
          }
        });
      });
    });
  }

  void puanKontrol() {
    var puanlar = [100, 200, 300, 400, 500, 600, 700, 800];
    var hizlar = [1, 2, 3, 4, 5, 6, 7, 8];

    for (var i = 0; i < puanlar.length; i++) {
      if (puan == puanlar[i]) {
        hiz = hizlar[i];
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorChangeBackground(puan, color),
        body: Stack(
          children: [
            _textPuan(),
            _sariTop(),
            _kirmiziTop(),
            _maviTop(),
            _baslatButton(),
            _bariyer(context)
          ],
        ),
      ),
    );
  }

  Positioned _baslatButton() {
    return Positioned(
        bottom: 30,
        left: 10,
        child: Row(
          children: [
            TextButton(
                onPressed: () {
                  if (baslat == true) {
                    setState(() {
                      baslat = false;
                      start();
                    });
                  }
                },
                child: const Text(
                  'Başlat',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                )),
          ],
        ));
  }

  Positioned _bariyer(BuildContext context) {
    return Positioned(
        left: 0,
        top: zeminTopPositoned,
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
        ));
  }

  Positioned _textPuan() {
    return Positioned(
        right: 30,
        top: 20,
        child: Row(
          children: [
            const Text(
              'Puan :',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$puan',
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ));
  }

  Positioned _maviTop() {
    return Positioned(
        left: solUc,
        top: ustUc,
        child: GestureDetector(
            onTap: () {
              puan = puan + 30;
              ustUc = -90;
              Random random = Random();
              int randomSayi = random.nextInt(350);
              print(randomSayi);
              solUc = randomSayi.toDouble();
              puanKontrol();
              zeminTopPositoned = zeminTopPositoned + 2;
            },
            child: Container(
                height: balonYukseklik,
                width: 70,
                decoration: const BoxDecoration(
                    color: Colors.blue, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.mood,
                    color: Colors.black,
                    size: 60,
                  ),
                ))));
  }

  Positioned _kirmiziTop() {
    return Positioned(
        left: solIki,
        top: ustIki,
        child: GestureDetector(
            onTap: () {
              puan = puan + 0;
              ustIki = -80;
              Random random = Random();
              int randomSayi = random.nextInt(350);
              print(randomSayi);
              solIki = randomSayi.toDouble();
              puanKontrol();
              zeminTopPositoned = zeminTopPositoned - 12;
            },
            child: Container(
                height: balonYukseklik,
                width: 70,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.mood_bad_outlined,
                    color: Colors.black,
                    size: 60,
                  ),
                ))));
  }

  Positioned _sariTop() {
    return Positioned(
        top: ust,
        left: sol,
        child: GestureDetector(
          onTap: () {
            puan = puan + 20;
            ust = -50;
            Random random = Random();
            int randomSayi = random.nextInt(350);
            print(randomSayi);
            sol = randomSayi.toDouble();
            puanKontrol();
            zeminTopPositoned = zeminTopPositoned + 1;
          },
          child: Container(
            height: balonYukseklik,
            width: 70,
            decoration: const BoxDecoration(
                color: Colors.yellow, shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.mood,
                color: Colors.black,
                size: 60,
              ),
            ),
          ),
        ));
  }

  colorChangeBackground(int puan, Color color) {
    switch (puan) {
      case 150:
        return color = Colors.lime.shade900;
      case 300:
        return color = Colors.orange;

      case 500:
        return color = Colors.orange.shade900;
      case 700:
        return color = Colors.brown;
      case 1000:
        return color = Colors.brown.shade900;
      case 1200:
        return color = Colors.green;
      case 1500:
        return color = Colors.green.shade900;
      default:
        return color = Colors.lime;
    }
  }
}
