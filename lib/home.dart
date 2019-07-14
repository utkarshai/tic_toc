import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_toc_again/class.dart';
import 'package:tic_toc_again/winer.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player1;
  var player2;
  var activeplayer;
  List<GameButton> buttonList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = doinit();
  }

  List<GameButton> doinit() {
    player1=new List();
    player2=new List();
    activeplayer=1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tic toc"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),// this will give padding from all side to the my container aor may calkled the grid
              itemCount: buttonList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,// no. of children in cross axis
                childAspectRatio: 1.0,// ratio of the main axis to cross axis
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 9.0,
              ),
              itemBuilder: (context,i)=>SizedBox(
                width: 100.0,
                height: 100.0,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonList[i].enabled? () => playGame(buttonList[i]): null,
                  child: Text(buttonList[i].text, style: TextStyle(color: Colors.green, fontSize: 20.0, ),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                ),
              ),
            ),
          ),
        new RaisedButton(
            onPressed: resetGame,
           color: Colors.lightGreenAccent,
          child: Text("reset"),
        ),
        ],

      ),
    );
  }

  playGame(GameButton gb) {
   setState(() {
    if(activeplayer==1){
      gb.text="x";
      gb.bg=Colors.red;
      activeplayer=2;
      player1.add(gb.id);


    }else{
      gb.text="0";
      gb.bg=Colors.lime;
      activeplayer=1;
      player2.add(gb.id);
    }
    gb.enabled=false;
    int winner=  checkWinner();
    if(winner==-1){
      if(buttonList.every((p)=>p.text!="")){
        showDialog(context: context,
            builder: (_)=> new CustomDialog("game tied", "press reset to start again", resetGame));
      }else{
        activeplayer==2?autoplay():null;
      }
    }

   });
  }


  int checkWinner(){
    var winner=-1;
    if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner=1;
    }
    if(player2.contains(1) && player2.contains(2) && player2.contains(3)){
      winner=2;
    }
    if(player1.contains(6) && player1.contains(4) && player1.contains(5)){
      winner=1;
    }
    if(player2.contains(6) && player2.contains(5) && player2.contains(4)){
      winner=2;
    }
    if(player2.contains(7) && player2.contains(8) && player2.contains(9)){
      winner=2;
    }if(player2.contains(1) && player2.contains(4) && player2.contains(7)){
      winner=2;
    }if(player2.contains(2) && player2.contains(5) && player2.contains(8)){
      winner=2;
    }if(player2.contains(3) && player2.contains(6) && player2.contains(9)){
      winner=2;
    }if(player2.contains(1) && player2.contains(5) && player2.contains(9)){
      winner=2;
    }if(player2.contains(7) && player2.contains(5) && player2.contains(3)){
      winner=2;
    }
    if(player1.contains(7) && player1.contains(8) && player1.contains(9)){
      winner=1;
    }if(player1.contains(7) && player1.contains(4) && player1.contains(1)){
      winner=1;
    }if(player1.contains(8) && player1.contains(5) && player1.contains(2)){
      winner=1;
    }if(player1.contains(9) && player1.contains(6) && player1.contains(3)){
      winner=1;
    }if(player1.contains(1) && player1.contains(9) && player1.contains(5)){
      winner=1;
    }if(player1.contains(3) && player1.contains(5) && player1.contains(7)){
      winner=1;
    }
if(winner!=-1){
  if(winner==1){
    showDialog(
        context: context,
        builder: (_) => new CustomDialog("player 1 won", "press the reset to start again", resetGame)
    );
  }else{
    showDialog(
        context: context,
        builder: (_) => new CustomDialog("player 2 won",
            "press the reset to start again", resetGame)
    );
  }
  return winner;
}

  }

  void resetGame() {
    if(Navigator.canPop(context))  Navigator.pop(context);
    setState(() {
      
      buttonList=doinit();
    });
  }

  void autoplay() {
  var emptyCells= new List();
  var list = new List.generate(9, (i)=>i+1);
  for(var CellId in list){
    if(!player1.contains(CellId) || player2.contains(CellId)){
      // checkig that we will not click on the clicked item
      emptyCells.add(CellId);
    }
  }
  var r= new Random();
  var randIndex = r.nextInt(emptyCells.length-1);
  var cellId= emptyCells[randIndex];
  int i= buttonList.indexWhere((p)=>p.id==cellId);
  playGame(buttonList[i]);
  //
  }
}
