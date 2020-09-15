import 'package:flutter/material.dart' hide Actions;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
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
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Login',
                                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                                SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                        height: 36.0,
                                        child: Center(
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
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height*0.01 ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(29)),
                                        height: 36.0,
                                        child: Center(
                                          child: TextField(
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 24.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 40,
                                        child: MaterialButton(
                                          child: Text("Login",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          shape: StadiumBorder(),
                                          color: Colors.blueGrey,
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/home');
                                          },
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 40,
                                        child: MaterialButton(
                                          child: Text("Sign Up",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          shape: StadiumBorder(),
                                          color: Colors.blueGrey,
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/Signup');
                                          },
                                        ),
                                      ),
                                    )
                                  ],
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
