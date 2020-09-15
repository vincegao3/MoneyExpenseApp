import 'package:flutter/material.dart' hide Action;

class Welcome extends StatelessWidget{
  
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:CustomPaint(
        painter: BluePainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
              SizedBox(height:size.height * 0.03),
              MaterialButton(
                child: Text("Log In",),
                shape: StadiumBorder(),
                color: Colors.blue.shade800,
                onPressed: (){
                  Navigator.pushNamed(context, "/Login");
                },
                ),
                MaterialButton(
                  child: Text("Sign Up"),
                  shape: StadiumBorder(),
                  color: Colors.blue.shade800,
                  onPressed: (){
                    Navigator.pushNamed(context, '/Signup');
                  },
                  )
            ],
          ),
        ),
      ),
    )
    );
  }
}

class BluePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0,0,width,height));
    paint.color = Colors.blue.shade700;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, height*0.2);
    ovalPath.quadraticBezierTo(width*0.45, height*0.25, width*0.5, height*0.5);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.quadraticBezierTo(width*0.6, height*0.8, width*0.1, height);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.lineTo(0, height);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.close();

  }
  @override
  bool shouldRepaint(CustomPainter oldDelgate){
    return oldDelgate != this;
  }
}