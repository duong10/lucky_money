
import 'package:flutter/material.dart';
import 'package:lucky_money/presenation/page/page1.dart';

class CustomBottom extends StatefulWidget {
  const CustomBottom({super.key});

  @override
  State<CustomBottom> createState() => _CustomBottomState();
}

class _CustomBottomState extends State<CustomBottom> {
  List<bool> isSelected = [ true, false];
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey,),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        height: MediaQuery.sizeOf(context).height*0.14,
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.share,),
            InkWell(
              child: Icon(Icons.add_card),
              onTap: (){Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false, // quan trọng
                  pageBuilder: (_, __, ___) => const FakeBottomSheetPage(),
                ),
              );
              },
              //     () {
              //   showModalBottomSheet(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              //     isScrollControlled: true,
              //     context: context,
              //     builder: (context) {
              //       return Container(
              //         height: MediaQuery.sizeOf(context).height*0.9,
              //         alignment: Alignment.center,
              //         child: Text('Hello Bottom Sheet'),
              //       );
              //     },
              //   );
              // },

            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
              color: Colors.white60,
              child: Column(
                children: [
                  ToggleButtons(
                      onPressed: (index) {
                        setState(() {
                          isSelected = [index == 0, index == 1];
                        });
                      },
                      children: [Text('on'),
                        Text('off')], isSelected: isSelected),
                  Switch(
                    value: isOn,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (value) {
                      setState(() => isOn = value);
                    },
                  )

                ],
              )
          )
      ),
    );
  }
}
