class exp {  //expクラス
  float x, y;
  float spx, spy;
  float sp = 0.2;
  float digree = random(-180, 180);
  float rad;
  float r;
  float exp_distant;
  float exp_digree;
  int exp_time;
  int exp_clr;
  boolean exp_deth;
  exp(float xpos, float ypos) {  //コンストラクタ

    x = xpos;
    y = ypos;
  }
  void draw_exp(int exp_num) {  //expを描く関数
    if (exp_deth == false && deth == false) {

      exp_distant = sqrt((playerX - x)* (playerX - x) + (playerY- y)* (playerY - y));  //経験値とプレイヤーとの距離
      noStroke();
      fill(3, 155, 255, 255 - exp_clr);   //経験値の色
      sp = 0.2;
      spx = sp * cos(digree);
      spy = sp * sin(digree);

      push();                  //経験値の回転動作の設定
      rad = radians(r += 3);
      translate(x, y);
      rotate(rad);
      rect(0, 0, 7, 7);
      pop();

      if (x <= 314 || x >= 886) {   //経験値が壁にあたった時の反射

        digree = radians(180) - digree;
      }
      if (y <= 9 || y >= 589) {
        digree = radians(360) - digree;
      }


      if (exp_time >= 300 && exp_time <= 600) {  //時間経過による経験値の透明化

        exp_clr = 85;
      } else if (exp_time >= 601 && exp_time <= 900) {

        exp_clr = 170;
      } else if (exp_time >= 901) {

        exp_clr = 255;
        exp_deth = true;
      }
      if (exp_distant <= 10) { //プレイヤーに吸収されたら
        level_exp += exp_get;
        exp_deth = true;
      }
      if (exp_distant <= ep_magnet) { //プレイヤーに経験値が近づいたら寄る
        sp = 12;

        exp_digree = atan2(y - playerY, x - playerX);
        spx = sp * cos(exp_digree);
        spy = sp * sin(exp_digree);
      }

      x = x - spx;  //経験値の移動
      y = y - spy;


      exp_time++;
    } else if (exp_deth == true) {
      
      ep.remove(exp_num);
    }
  }
}

void level_up() {  //レベルを司る関数

  noStroke();
  fill(#788186);
  rectMode(CENTER);
  rect(220, 280, 30, 380);

  fill(255);
  rectMode(CORNER);
  rect(210, 95, 20, level_exp);

  fill(0);
  rect(210, 470, 20, 200);
  fill(#788186);
  rect(210, 465, 20, 5);
  rectMode(CENTER);

  if (level_exp >= 380) { //レベルが上がったら
    if (level_up_time == 0) {
      try {  //エラーが起きたら音を出さない
        level_up_sound.rewind();
        level_up_sound.play();
      }
      catch(NullPointerException e) {
      }
      ep_magnet += 1000;//一度だけ経験値を寄せる力を最大に
    }
    level_up = true;

    level_up_time+= 1;

    if (level_up_time >= 140) { //戻す↑
      ep_magnet-= 1000;

      skill1 = int(random(1, 10.9));  //スキル1の選択
      skill2 = int(random(1, 10.9));  //2
      skill3 = int(random(1, 10.9));  //3

      while ( skill1 == skill2) {
        skill2 = int(random(1, 10.9));//1と2が被った時の再選択
      }
      while ( skill1 == skill3 || skill2 == skill3) {//3が1か2に被った時の再選択
        skill3 = int(random(1, 10.9));
      }

      level++;
      scine = "skill";
      level_up = false;
      level_exp = 0;
      level_up_time = 0;
      if (level % 2 == 1) enemy_num++;
      if (level >= 3 && level % 2 == 1) enemy1_num++;
      if (level >= 4 && level % 2 == 0) enemy2_num++;
      exp_get   /= 1.5; //レベルが上がるごとにexpを得た時に上がる経験値量の減少
      enemy_exp /= 1.5; //レベルが上がるごとに敵を倒した時に上がる経験値量の減少
    }
  }
  textSize(40);
  fill(255);
  text("Lv" + level, 150, 300);

  textSize(57);
}
