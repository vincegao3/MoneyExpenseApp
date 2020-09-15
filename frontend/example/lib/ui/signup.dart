import 'package:example/data/apimanager.dart';
import 'package:flutter/material.dart' hide Action;

class Signup extends StatelessWidget {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  bool checkUserInput(){
    if(usernameController.text != "" && nameController.text != "" && emailController.text != "" && passwordController.text != "" && repasswordController.text != ""){
      if(checkEmail(emailController.text)){
        if(passwordController.text == repasswordController.text){
          return true;
        }
      }
    }
    else
      return false;
  }
  bool checkEmail(String email){
      RegExp reg = new RegExp(r'^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$');
      return reg.hasMatch(email);
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: CustomPaint(
                painter: BluePainter(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24.0),
                      Opacity(
                          opacity: 0.75,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue.shade300,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height*0.01,),
                                Container(
                                    decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                    height: 36.0,
                                    child: Center(
                                      child: TextField(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Name",
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height*0.01,)
                                    ,
                                    Container(
                                      decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                      height: 36.0,
                                      child: TextField(
                                        controller: usernameController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Username",
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                              ),
                                        
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.01,)
                                    ,
                                    Container(
                                      decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                      height: 36.0,
                                      child: TextField(
                                        controller: emailController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                              ),
                                        
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.01,)
                                    ,
                                    Container(
                                      decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                      height: 36.0,
                                      child: TextField(
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                              ),
                                        
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.01,)
                                    ,
                                    Container(
                                      decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                      height: 36.0,
                                      child: TextField(
                                        controller: repasswordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Re-Input Password",
                                                
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                              ),
                                        
                                      ),
                                    ),
                                    Container(
                                      child: MaterialButton(
                                        shape: StadiumBorder(),
                                        color: Colors.blueGrey,
                                        child: Text("Register"),
                                        onPressed: (){
                                          if(checkUserInput()){
                                            //APIManager().createNewUser();
                                            print("New User");
                                          }
                                        },
                                        ),
                                    )      
                              ],
                            ),
                          ))
                    ],
                  ),
                ))));
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.blue.shade700;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, height * 0.2);
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.5, height * 0.5);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.quadraticBezierTo(width * 0.6, height * 0.8, width * 0.1, height);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.lineTo(0, height);
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
    ovalPath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelgate) {
    return oldDelgate != this;
  }
}
