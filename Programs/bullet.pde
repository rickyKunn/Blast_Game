float point;

void gauge() {  //弾のゲージを司る関数
  fill(255);
  textSize(40);
  text("kill:" + kill_num, 150, 130);  //倒した数のテキスト表示

  if (deth == false) {  //プレイヤーが死んでない時
    if (point >= 200) { //ゲージが溜まったら

      if (gatling == false) {
        point = 0;
        for ( int i = 0; i < line_num; i++) {
          bl.add(new bullet(playerX, playerY, bullet_num, i));
          bullet_num++;
        }
        if (wide_shot == true) {

          wide_bl.add(new wide_bullet(playerX, playerY));
          wide_bullet_num++;
        }
      } else if (gatling == true) {  //ガトリングだったら
        gatling_mode = true;
      }
    } else if (point <= 199 && gatling_mode == false) {
      point+= bullet_tempo;
    }

    if (gatling_mode == true) {
      gatling_time++;
      point -= 200 / (10 * gatling_num); //ゲージを徐々に減らす
      if ( gatling_time % 10 == 0) {
        for (int i = 0; i < line_num; i++) {
          bl.add(new bullet(playerX, playerY, bullet_num, i));
          bullet_num++;
        }
        if (wide_shot == true) {
          wide_bl.add(new wide_bullet(playerX, playerY));
          wide_bullet_num++;
        }
      }

      if (gatling_time == 10 * gatling_num) {
        point = 0;
        gatling_time = 0;
        gatling_mode = false;
      }
    }

    if (bl.size() >= 1) {
      for (int i = 0; i < bl.size(); i++) { //弾を順次更新する
        bl.get(i).draw_bullet(i);
      }
      for (int i = 0; i < wide_bullet_num; i++) { //弾を順次更新する
        if (wide_shot == true) {
          wide_bl.get(i).draw_wide_bulletR();
          wide_bl.get(i).draw_wide_bulletL();
        }
      }
    }
  }
}




class bullet {  //弾クラス
  float bullet_digree;
  int bullet_move;
  int num;
  int line_n;
  int perforate_n;
  float bullet_trans;
  float x;
  float y;
  float mX, mY;
  float playerX, playerY;
  float bulletX = 300, bulletY = 0;
  float bulletX_hit, bulletY_hit;
  float bullet_distant;
  boolean bullet_hit;
  boolean bullet_removed;
  ArrayList<Float> bullet_cirX = new ArrayList<>();
  ArrayList<Float> bullet_cirY = new ArrayList<>();
  int bullet_cir_num = 10;
  bullet(float playerXpos, float playerYpos, int numpos, int line_numpos) {
    playerX = playerXpos;
    playerY = playerYpos;

    mX = mouseX;
    mY = mouseY;
    bullet_digree = atan2(mY - playerY, mX- playerX);
    num = numpos; //クラスの番号
    line_n = line_numpos;
    if (line_n  % 2 == 0) {
      bullet_trans = (line_num - line_n - 1) * 10;
    }
    if (line_n % 2  == 1) {
      bullet_trans = (-line_num + line_n) * 10;
    }
    bulletX = playerX + bullet_trans * cos(bullet_digree + PI / 2);
    bulletY = playerY + bullet_trans * sin(bullet_digree + PI / 2);

    perforate_n = perforate_num;  //貫通する回数

    for (int i = 0; i < 10; i++) {

      bullet_cirX.add(i, bulletX);
      bullet_cirY.add(i, bulletY);
    }
  }


  void draw_bullet(int bullet_num) {  //弾を描く関数

    if (bullet_hit == false && bulletX >= 270 && bulletX<= 930 && bulletY >= -30 && bulletY <= 630 && level_up == false) {
      bulletX += bullet_speed * cos(bullet_digree);
      bulletY += bullet_speed * sin(bullet_digree);

      noStroke();
      fill(255);
      circle(bulletX, bulletY, 10);
      bullet_move += bullet_speed;

      //後ろの三角形の設定-----------------
      bullet_cirX.add(bullet_cir_num, bulletX);
      bullet_cirY.add(bullet_cir_num, bulletY);
      bullet_cir_num++;
      for (int i = 9; i > 0; i--) {
        fill(255);
        circle(bullet_cirX.get(bullet_cir_num - i), bullet_cirY.get(bullet_cir_num - i), 9 - i);
      }
      //---------------------------------

      bulletX_hit = bulletX;
      bulletY_hit = bulletY;
    } else {
      bullet_hit = true;
    }


    for (int i = 0; i < es0.size(); i++) {  //敵0に弾が当たったか否かを判断する
      bullet_distant = sqrt((bulletX - es0.get(i).x) * (bulletX - es0.get(i).x) + (bulletY - es0.get(i).y)* (bulletY -es0.get(i).y));

      if (bullet_distant <= 15) {
        boolean several_hit = es0.get(i).bullet_hit_several(0, num);
        if (perforate == true && several_hit == false) {
          perforate_n--;
          es0.get(i).enemy_hit = true;
          //enemy0_hit_list.set(i, true);
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate == false) {
          bullet_hit = true;
          es0.get(i).enemy_hit = true;
          //enemy0_hit_list.set(i, true);
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate_n <= -1 && perforate == true) {
          bullet_hit = true;
          bs.add(new boost(bulletX, bulletY, 40, 0));
        }
      }
    }

    for (int i = 0; i < es1.size(); i++) {  //敵1に弾が当たったか否かを判断する
      bullet_distant = sqrt((bulletX - es1.get(i).x) * (bulletX - es1.get(i).x) + (bulletY - es1.get(i).y)* (bulletY - es1.get(i).y));

      if (bullet_distant <= 15) {

        boolean several_hit = es1.get(i).bullet_hit_several(0, num);
        if (perforate == true && several_hit == false) {
          perforate_n--;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate == false) {
          bullet_hit = true;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate_n <= -1 && perforate == true) {
          bullet_hit = true;
          bs.add(new boost(bulletX, bulletY, 40, 0));
        }
      }
    }
    for (int i = 0; i < es2.size(); i++) {  //敵1に弾が当たったか否かを判断する
      bullet_distant = sqrt((bulletX - es2.get(i).x) * (bulletX - es2.get(i).x) + (bulletY - es2.get(i).y)* (bulletY - es2.get(i).y));

      if (bullet_distant <= 15) {

        boolean several_hit = es2.get(i).bullet_hit_several(0, num);
        if (perforate == true && several_hit == false) {
          perforate_n--;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate == false) {
          bullet_hit = true;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletX, bulletY, 20, 0));
        }
        if (perforate_n <= -1 && perforate == true) {
          bullet_hit = true;
          bs.add(new boost(bulletX, bulletY, 40, 0));
        }
      }
    }

    if (bullet_hit == true) {
      bulletX = 10000;
      bulletY = 10000;
    }
  }
}



class wide_bullet {  //弾クラス
  float bullet_digreeR, bullet_digreeL;
  int bullet_moveR, bullet_moveL;
  int numR, numL;
  int  perforate_nR, perforate_nL;
  //float x;
  //float y;
  float mX, mY;
  float playerX, playerY;
  float bulletXR = 300, bulletYR = 0, bulletXL = 300, bulletYL = 0;
  float bulletX_hitR, bulletY_hitR, bulletX_hitL, bulletY_hitL;
  float bullet_distantR, bullet_distantL;
  boolean bullet_hitR, bullet_hitL;


  ArrayList<Float> bullet_cirXR = new ArrayList<>();
  ArrayList<Float> bullet_cirYR = new ArrayList<>();
  int bullet_cir_numR = 10;
  ArrayList<Float> bullet_cirXL = new ArrayList<>();
  ArrayList<Float> bullet_cirYL = new ArrayList<>();
  int bullet_cir_numL = 10;

  wide_bullet(float playerXpos, float playerYpos) {
    playerX = playerXpos;
    playerY = playerYpos;

    mX = mouseX;
    mY = mouseY;
    bullet_digreeR = atan2(mY - playerY, mX- playerX) - radians(-15);
    bullet_digreeL = atan2(mY - playerY, mX- playerX) - radians(15);
    perforate_nR = perforate_num;  //貫通する回数
    perforate_nL = perforate_num;  //貫通する回数

    //後ろの三角形の設定-----
    for (int i = 0; i < 10; i++) {

      bullet_cirXR.add(i, bulletXR);
      bullet_cirYR.add(i, bulletYR);
    }
    for (int i = 0; i < 10; i++) {

      bullet_cirXL.add(i, bulletXL);
      bullet_cirYL.add(i, bulletYL);
    }

    //--------------------
  }


  void draw_wide_bulletR() {  //右弾を描く関数


    if (bullet_hitR == false && bulletXR >= 270 && bulletXR<= 930 && bulletYR >= -30 && bulletYR <= 630 && level_up == false) {
      bulletXR = playerX + bullet_moveR * cos(bullet_digreeR);
      bulletYR = playerY + bullet_moveR * sin(bullet_digreeR);

      noStroke();
      fill(255);
      circle(bulletXR, bulletYR, 10);
      bullet_moveR += bullet_speed;
      bulletX_hitR = bulletXR;
      bulletY_hitR = bulletYR;

      //後ろの三角形の設定-----------------
      bullet_cirXR.add(bullet_cir_numR, bulletXR);
      bullet_cirYR.add(bullet_cir_numR, bulletYR);
      bullet_cir_numR++;
      for (int i = 10; i > 0; i--) {
        fill(255);
        circle(bullet_cirXR.get(bullet_cir_numR - i), bullet_cirYR.get(bullet_cir_numR - i), 10 - i);
      }
      //---------------------------------
    } else {
      bulletXR = 10000;
      bulletYR = 10000;
    }


    for (int i = 0; i < es0.size(); i++) {  //敵0に弾が当たったか否かを判断する
      bullet_distantR = sqrt((bulletXR - es0.get(i).x) * (bulletXR - es0.get(i).x) + (bulletYR - es0.get(i).y)* (bulletYR -es0.get(i).y));

      if (bullet_distantR <= 15) {

        boolean several_hit = es0.get(i).bullet_hit_several(1, numR);
        if (perforate == true && several_hit == false) {
          perforate_nR--;
          es0.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate == false) {
          bullet_hitR = true;
          es0.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate_nR<= -1 && perforate == true) {
          bullet_hitR = true;
          bs.add(new boost(bulletXR, bulletYR, 40, 0));
        }
      }
    }

    for (int i = 0; i < es1.size(); i++) {  //敵1に弾が当たったか否かを判断する
      bullet_distantR = sqrt((bulletXR - es1.get(i).x) * (bulletXR - es1.get(i).x) + (bulletYR - es1.get(i).y)* (bulletYR -es1.get(i).y));

      if (bullet_distantR <= 15) {

        boolean several_hit = es1.get(i).bullet_hit_several(1, numR);
        if (perforate == true && several_hit == false) {
          perforate_nR--;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate == false) {
          bullet_hitR = true;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate_nR<= -1 && perforate == true) {
          bullet_hitR = true;
          bs.add(new boost(bulletXR, bulletYR, 40, 0));
        }
      }
    }
    for (int i = 0; i < es2.size(); i++) {  //敵2に弾が当たったか否かを判断する
      bullet_distantR = sqrt((bulletXR - es2.get(i).x) * (bulletXR - es2.get(i).x) + (bulletYR - es2.get(i).y)* (bulletYR -es2.get(i).y));

      if (bullet_distantR <= 15) {

        boolean several_hit = es2.get(i).bullet_hit_several(1, numR);
        if (perforate == true && several_hit == false) {
          perforate_nR--;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate == false) {
          bullet_hitR = true;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletXR, bulletYR, 20, 0));
        }
        if (perforate_nR<= -1 && perforate == true) {
          bullet_hitR = true;
          bs.add(new boost(bulletXR, bulletYR, 40, 0));
        }
      }
    }
  }

  void draw_wide_bulletL() {  //左弾を描く関数


    if (bullet_hitL == false && bulletXL >= 270 && bulletXL<= 930 && bulletYL >= -30 && bulletYL <= 630 && level_up == false) {
      bulletXL = playerX + bullet_moveL * cos(bullet_digreeL);
      bulletYL = playerY + bullet_moveL * sin(bullet_digreeL);

      noStroke();
      fill(255);
      circle(bulletXL, bulletYL, 10);
      bullet_moveL += bullet_speed;
      bulletX_hitL = bulletXL;
      bulletY_hitL = bulletYL;

      //後ろの三角形の設定-----------------
      bullet_cirXL.add(bullet_cir_numL, bulletXL);
      bullet_cirYL.add(bullet_cir_numL, bulletYL);
      bullet_cir_numL++;
      for (int i = 10; i > 0; i--) {
        fill(255);
        circle(bullet_cirXL.get(bullet_cir_numL - i), bullet_cirYL.get(bullet_cir_numL - i), 10 - i);
      }
      //---------------------------------
    } else {
      bulletXL = 10000;
      bulletYL = 10000;
    }


    for (int i = 0; i < es0.size(); i++) {  //敵0に弾が当たったか否かを判断する
      bullet_distantL = sqrt((bulletXL - es0.get(i).x) * (bulletXL - es0.get(i).x) + (bulletYL - es0.get(i).y)* (bulletYL -es0.get(i).y));

      if (bullet_distantL <= 15) {

        boolean several_hit = es0.get(i).bullet_hit_several(2, numR);
        if (perforate == true && several_hit == false) {
          perforate_nL--;
          es0.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate == false) {
          bullet_hitL = true;
          es0.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate_nL<= -1 && perforate == true) {
          bullet_hitL = true;
          bs.add(new boost(bulletXL, bulletYL, 40, 0));
        }
      }
    }

    for (int i = 0; i < es1.size(); i++) {  //敵0に弾が当たったか否かを判断する
      bullet_distantL = sqrt((bulletXL - es1.get(i).x) * (bulletXL - es1.get(i).x) + (bulletYL - es1.get(i).y)* (bulletYL -es1.get(i).y));

      if (bullet_distantL <= 15) {

        boolean several_hit = es1.get(i).bullet_hit_several(2, numR);
        if (perforate == true && several_hit == false) {
          perforate_nL--;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate == false) {
          bullet_hitL = true;
          es1.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate_nL<= -1 && perforate == true) {
          bullet_hitL = true;
          bs.add(new boost(bulletXL, bulletYL, 40, 0));
        }
      }
    }

    for (int i = 0; i < es2.size(); i++) {  //敵0に弾が当たったか否かを判断する
      bullet_distantL = sqrt((bulletXL - es2.get(i).x) * (bulletXL - es2.get(i).x) + (bulletYL - es2.get(i).y)* (bulletYL -es2.get(i).y));

      if (bullet_distantL <= 15) {

        boolean several_hit = es2.get(i).bullet_hit_several(2, numR);
        if (perforate == true && several_hit == false) {
          perforate_nL--;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate == false) {
          bullet_hitL = true;
          es2.get(i).enemy_hit = true;
          bs.add(new boost(bulletXL, bulletYL, 20, 0));
        }
        if (perforate_nL<= -1 && perforate == true) {
          bullet_hitL = true;
          bs.add(new boost(bulletXL, bulletYL, 40, 0));
        }
      }
    }
  }
}
