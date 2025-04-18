void boost_up() {  //クラスを実行する関数

  for (int i = 0; i < bs.size(); i++) {
    bs.get(i).draw_boost(i);
  }
}

class boost { //弾くエフェクトのクラス
  int clr;
  float enemyX, enemyY;
  float spx, spy;
  int line_num;
  int boost_time;
  String kind;
  ArrayList<Float> boostX = new ArrayList<>();
  ArrayList<Float> digree = new ArrayList<>();
  ArrayList<Float> boost_len = new ArrayList<>();
  ArrayList<Float> speed = new ArrayList<>();

  boost(float x, float y, int line_numPos, int clrPos) { //コンストラクタ
    enemyX = x;
    enemyY = y;
    line_num = line_numPos;
    clr = clrPos;
    for (int i = 0; i < line_num; i++) {
      boostX.add(0.0);
      digree.add(random(0, 359));
      boost_len.add(random(1, 15));
      speed.add(random(1, 6));
      kind = "deth";
    }
  }
  boost(float x, float y) {  //オーバーロード(敵が生成される時)
    enemyX = x;
    enemyY = y;
    line_num = 100;
    clr = 1;
    for (int i = 0; i < line_num; i++) {
      boostX.add(random(70, 120));
      digree.add(random(0, 359));
      boost_len.add(random(5, 15));
      speed.add(random(5, 7));
      kind = "make";
    }
  }

  void draw_boost(int boost_num) {
    boost_time++;
    if (enemyX >= 315 && enemyY <= 885 && enemyY >= 10 && enemyY <= 590) {  //弾けるオブジェクトが枠内にいる時
      switch(clr) { //弾ける物によって色を変える

      case 0: //弾,プレイヤー(白)
        stroke(255);
        strokeWeight(1);

        break;
      case 1:  //敵(赤色)
        stroke(255, 23, 70);
        strokeWeight(2);

        break;
      case 2: //ビーム(青)
        stroke(#0258CE);
        strokeWeight(2);

        break;
      }
      if (kind == "deth") {
        for (int i = 0; i < line_num; i++) {
          if (boost_len.get(i) > 0.1) {
            boost_len.set(i, boost_len.get(i) - 0.1);
            boostX.set(i, boostX.get(i) + speed.get(i));

            push();
            translate(enemyX, enemyY);
            rotate(radians(digree.get(i)));
            line(boostX.get(i), 0, boostX.get(i) + boost_len.get(i), 0);
            pop();
          }
        }
      } else if ( kind == "make" ) {

        for (int i = 0; i < line_num; i++) {
          if (boostX.get(i) > 0.1) {
            boostX.set(i, boostX.get(i) - speed.get(i));

            push();
            translate(enemyX, enemyY);
            rotate(radians(digree.get(i)));
            line(boostX.get(i), 0, boostX.get(i) + boost_len.get(i), 0);
            pop();
          }
        }
      }
    }
    
    if(boost_time >= 160) bs.remove(boost_num);
       
  }
}
