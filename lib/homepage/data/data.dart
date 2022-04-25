import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Data {
  static List<List<String>> contacts = [
    ['0', 'Ellcase', 'https://ellcase.my.id', 'logo'],
    ['1', 'Telephone', 'tel:+6281282099920', 'telp'],
    ['2', 'Whatsapp', 'http://wa.me/6281282099920', 'wa'],
    ['3', 'Line', 'https://page.line.me/?accountId=038zztvh', 'line'],
    ['4', 'Email', 'mailto:id.ellcase@gmail.com', 'mail']
  ];
}

List<Widget> contacts(Axis axis) => List.generate(Data.contacts.length, (x) {
      List<String> data = Data.contacts[x];

      return Padding(
          padding: axis == Axis.vertical
              ? const EdgeInsets.only(top: kToolbarHeight * 0.1)
              : const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.1),
          child: Tooltip(
              message: data[1],
              child: InkWell(
                  onTap: () async => await launchUrl(Uri.parse(data[2])),
                  customBorder: const CircleBorder(),
                  child: Image.asset('assets/${data[3]}.png',
                      width: 40,
                      height: 40,
                      color: axis == Axis.vertical
                          ? (data[0] == '0' ? Colors.red : Colors.black)
                          : Colors.white))));
    });
