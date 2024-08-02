Container(
  margin: EdgeInsets.only(top: heightRatio * 26,
      left: widthRatio * 30,
      right: widthRatio * 30),
  child: Row(
    children: [
        TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (
              context) => FindPasswordScreen()));
        },
        child: Text(
          "비밀번호 찾기",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationThickness: 1.5,
            decorationColor: Colors.white,
            height: 0,
            letterSpacing: -0.40,
          ),
        ),
      ),
    ],
  ),
)
