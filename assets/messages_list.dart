class QuoteList extends StatefulWidget {
@override
_QuoteListState createState() => _QuoteListState();

class _QuoteListState extends State<QuoteList> {

List<Quote> quotes = [
Quote(text: '산다는 건, 치열한 전투지...'),
Quote(text: '용기있는 자는 결코 버림받지 않아!'),
Quote(text: '인생은 오늘의 너 안에 있고 내일은 스스로 만드는 거야'),
Quote(text: '모든 인생은 실험이고 더 많이 실험할수록 더 나아지지'),
Quote(text: '길을 잃는다는 건 곧 길을 알게 된다는 거지'),
Quote(text: '성공으로 가는 엘리베이터는 고장이니 계단을 이용해야 해'),
Quote(text: '실패는 잊어도 실패가 준 교훈은 절대 잊으면 안 돼'),
Quote(text: '인생에 뜻을 세우는 데 있어 늦은 때란 없어'),
Quote(text: '최후의 성공을 거둘 때까지 밀고 나가자'),
Quote(text: '원하는 것을 얻기 위한 첫단계는 네가 무엇을 원하는지 결정하는 거야'),
Quote(text: '너가 해야 할 일을 결정하는 건 오직 너 자신뿐이야'),
Quote(text: '한 번의 실패와 영원한 실패를 혼동하지 마!'),
Quote(text: '지금까지 네가 만들어온 모든 선택으로 인해 지금의 너가 있는 거야'),
Quote(text: '고난의 시기에 동요하지 않는 건 정말 칭찬받을 만한 뛰어난 인물의 증거야'),
Quote(text: '해야할 일을 하는 건 타인의 행복과 무엇보다 너의 행복을 위해서야'),
Quote(text: '중요한 건 스스로의 재능과 자신의 행동에 쏟아 붓는 사랑의 정도지'),
Quote(text: '고난이 지나면 반드시 기쁨이 스며들어'),
Quote(text: '작은 기회에서 종종 위대한 업적이 시작되지'),
Quote(text: '1퍼센트의 가능성, 그것이 너의 길이야'),
Quote(text: '좋은 성과를 얻으려면 한걸음 한걸음이 힘차고 충실해야지'),
Quote(text: '계단을 밟아야 계단 위에 올라설 수 있어'),
Quote(text: '작은 기회에서 종종 위대한 업적이 시작되지'),
Quote(text: '오랫동안 꿈을 그리는 사람은 마침내 그 꿈을 닮아 간대'),
Quote(text: '뜻이 반듯이 서야 만사가 반드시 성공하지.'),
Quote(text: '시간 걱정을 하지 말고 스스로 마음을 바쳐 최선을 다 할 수 있을지를 고민해'),
Quote(text: '이 또한 지나갈 테니 걱정 마'),
Quote(text: '비가 내리고 바람이 불어야만 비옥한 땅이 되지'),
Quote(text: '미래는 꿈의 아름다움을 믿는 사람이 쟁취하지'),
Quote(text: '무언가를 시도할 용기를 갖지 못한다면 인생은 대체 뭐겠어?'),
];

Widget quoteTemplate(quote){
return Card(

margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
child: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch, // 템플렛 꽉 차게

children: <Widget>[
Text( // 인용구
quote.text ,// '' 로 하는 거 아니니까 {}필요 없음
style: TextStyle(
fontSize: 18.0,
color: Colors.grey[600],
SizedBox(height: 6.0),
Text( // 작가

quote. author,
style: TextStyle(
fontSize: 14.0,
color:Colors.grey[600],
              )
            )
            )
          ),
        ],
      ),
    ),
  );
}
/* @override

Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey[200],
appBar: AppBar(
title: Text('도민호의 한마디'),
centerTitle: true,
backgroundColor: Colors.grey,

),
body: Column(// 변수 property에 접근하려면 {} 감싸야함
children: quotes.map((quote) => quoteTemplate(quote)).toList(),
// cycle through the List of data
),
);
} */
}

class _QuoteListState {
}
