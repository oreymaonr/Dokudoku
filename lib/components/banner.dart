import 'package:flutter/material.dart';

class BannerHead extends StatefulWidget {
  final int kValue;

  const BannerHead({
    super.key,
    required this.kValue
  });

  @override
  State<BannerHead> createState() => _BannerHeadState();
}

class _BannerHeadState extends State<BannerHead> {


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: (){},
                  child:const Text("reset")
              ),
              TextButton(
                  onPressed: (){},
                  child:const Text("pause")
              ),
              TextButton(
                  onPressed: (){},
                  child:const Text("new game")
              ),
              TextButton(
                  onPressed: (){
                      setKval(widget.kValue);
                    },
                  child:const Text("k val")
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setKval(int kVal){
    setState(() {
       kVal = 10;
    });
    
  }
}