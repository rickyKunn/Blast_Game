class enemy1 {
  float spx, spy;

  float x, y;
  float hitX = -1000, hitY = -1000;
  float firstX, firstY;
  int first;
  float sp = 1;
  float circleR = 30;
  int enemy_hit_r;
  int clrR = 0;
  int count = 0;
  float distant, distant_clean, bullet_distant;
  int time_deth;
  float digree;
  int digree_time;
  float side, hight, deth_r;
  int lv_side;
  int lv_hight;
  int lv_r;
  float enemy1_hp = 10;
  boolean deth_boost;
  boolean score_up;
  boolean enemy_move = false;
  boolean enemy_deth;
  boolean enemy_deth_mode;
  boolean enemy_level_mode = false;
  boolean enemy_hit, enemy_beam_hit;
  ArrayList<Integer> bullet_hit_num_list = new ArrayList<>(); //同じ弾が2回当たらないようにするため
  ArrayList<Integer> bullet_hit_num_listR = new ArrayList<>(); //同じ弾が2回当たらないようにするため
  ArrayList<Integer> bullet_hit_num_listL = new ArrayList<>(); //同じ弾が2回当たらないようにするため

  enemy1(float xpos, float ypos) {  //コンストラクタ

    firstX = xpos;
    firstY = ypos;
  }

  void drawenemy1(int enemy_num) {
    enemy_bool();
    distant_clean = sqrt((firstX - playerX)* (firstX - playerX) + (firstY- playerY)* (firstY - playerY));  //敵が透明の時のプレイヤーとの距離

    if (deth == false) {  //生きている時
      if (count <= 160  && level_up == false) {    //出没した後の半透明時の設定
        enemy_move = false;
        noStroke();
        fill(255, 23, 70, 50 + clrR);

        push();
        translate(firstX, firstY);
        beginShape();
        vertex(13, 13);
        vertex(-13, 0);
        vertex(13, -13);
        vertex(5, 0);
        endShape( CLOSE );
        pop();
        count++;
        if (count == 140) {
          bs.add(new boost(firstX, firstY));  //生成時エフェクト
        }
        if (count >= 102 && count <= 159) {   //動き始める前のサイン
          noFill();
          stroke(255, 23, 70);
          strokeWeight(1);
          //circle(firstX, firstY, circleR);
          push();
          translate(firstX, firstY);
          beginShape();
          vertex(13 + circleR, 13 + circleR);
          vertex(-13 - circleR, 0);
          vertex(13 + circleR, -13 - circleR);
          vertex(5 + circleR, 0);
          endShape( CLOSE );
          pop();
          circleR -=0.5;
          clrR+= 3;
        }

        if (distant_clean < 20) {  //透明時にプレイヤーと敵が接触していたら
          wave_red = true; //波長の線を赤くする
        }
      } else {
        if (enemy_deth == false && level_up == false) {  //弾にあたってなくてレベルアップ画面ではない時

          if (first == 0) {

            x = firstX;
            y = firstY;
          }
          first++;

          digree = atan2(y - playerY, x - playerX);
          spx = sp * cos(digree);
          spy = sp * sin(digree);
          x = x - spx;
          y = y - spy;
          noStroke();
          fill(255, 23, 70);

          push();   //敵の形を形成+角度を指定
          translate(x, y);
          rotate(digree);
          beginShape();
          vertex(13, 13);
          vertex(-13, 0);
          vertex(13, -13);
          vertex(5, 0);
          endShape( CLOSE );
          pop();

          enemy_hit();   //敵とにあたったかどうか
          hitX = x;
          hitY = y;
        } else if (enemy_deth == true) {           //敵が死んだ時

          if (enemy_deth_mode == false) {
            kill_num++;

            try {  //エラーが起きたら音を出さない
              hit_sound.rewind();
              hit_sound.play();
            }
            catch(NullPointerException e) {
            }

            int exp_random_num = int(random(0, 2.99));
            for ( int i = 0; i < exp_random_num; i++) {
              ep.add(new exp(x, y));
            }
            level_exp += enemy_exp;

            vibe = true;

            enemy_deth_mode= true;
          }

          es1.remove(enemy_num);
        }
      }
      if (level_up == true && enemy_deth == false && enemy_level_mode == false) {  //レベルが上がってこのクラスの敵が倒されていない時
        bs.add(new boost(x, y, 100, 1));
        enemy_level_mode = true;
      }
    } else if ( deth == true) {  //死んだ時

      if (time_deth == 160) {
        side = 0;
        hight = 0;
        scine = "gameover";
      }
      time_deth++;

      enemy_boost(hitX, hitY);
    }

    if (x <= 315 || x >= 885) {   //敵が壁にあたった時の反射

      digree = radians(180) - digree;
    }
    if (y <= 10 || y >= 590) {
      digree = radians(360) - digree;
    }
  }

  void enemy_hit() {

    distant = sqrt((playerX - x)* (playerX - x) + (playerY- y)* (playerY - y));  //敵とプレイヤーの最短距離

    if (distant <= 20) {
      try {
        deth_sound.rewind();
        deth_sound.play();
      }
      catch(NullPointerException e) {
      }
      deth = true;
    }
  }
  void enemy_boost(float x, float y) { //プレイヤーが死んだ時に弾かれる
    if (deth == true && enemy_deth == false &&  deth_boost == false) {
      bs.add(new boost(x, y, 50, 1));

      deth_boost = true;
    }
  }

  void enemy_bool() {

    if (enemy_hit == true) {
      enemy1_hp -= bullet_power;
      enemy_hit = false;
    }
    if (enemy_beam_hit == true && level_up == false && deth == false) {
      bs.add(new boost(x, y, 1, 2));
      bs.add(new boost(x, y, 1, 2));


      enemy1_hp -= bullet_power / 20;
      enemy_beam_hit = false;
    }
    if (enemy1_hp <= 0) {
      if (score_up == false) {
        bs.add(new boost(x, y, 40, 1)); //弾く
        score += 1500;
        sc_txt.add(new score_text(1));

        score_up = true;
      }
      enemy_deth = true;
    }
  }

  boolean bullet_hit_several(int kind, int number) {  //同じ弾に2回以上当たったかどうか
    boolean hit = false;
    switch(kind)
    {
    case 0:
      for ( int i = 0; i < bullet_hit_num_list.size(); i++) {
        if ( number == bullet_hit_num_list.get(i)) {
          hit = true;
        } else {
          hit = false;
        }
      }
      bullet_hit_num_list.add(number);
      break;

    case 1:
      for ( int i = 0; i < bullet_hit_num_listR.size(); i++) {
        if ( number == bullet_hit_num_listR.get(i)) {
          hit = true;
        } else {
          hit = false;
        }
      }
      bullet_hit_num_listR.add(number);
      break;

    case 2:
      for ( int i = 0; i < bullet_hit_num_listL.size(); i++) {
        if ( number == bullet_hit_num_listL.get(i)) {
          hit = true;
        } else {
          hit = false;
        }
      }
      bullet_hit_num_listL.add(number);
      break;
    }
    return( hit );
  }
}
