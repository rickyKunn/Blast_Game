int mine_time;
void mine_up() {
  if (mine_bool == true) {
    mine_time++;

    if (mine_time >= mine_tempo) {

      for (int i = 0; i < mine_level; i++) {
        mn.add(new mine(playerX, playerY));
      }
      mine_time =0;
    }

    if (mn.size() >= 1) {
      for (int i = 0; i < mn.size(); i++) { //弾を順次更新する
        mn.get(i).draw_mine(i);
      }
    }
  }
}
class mine {  //地雷クラス
  float mineX, mineY;
  float digree = random(-180, 180);
  float sp = 1;
  float spx, spy;
  float rad;
  float r;
  float mine_distant;
  boolean mine_hit;

  mine(float playerXpos, float playerYpos) {
    mineX = playerXpos;
    mineY = playerYpos;
  }

  void draw_mine(int mine_num) {
    if (mine_hit == false && level_up == false) {
      spx = sp * cos(digree);
      spy = sp * sin(digree);

      mine_shape(mineX, mineY);

      mineX -= spx;
      mineY -= spy;

      if (mineX <= 310 || mineX >= 890) {   //地雷が壁にあたった時の反射
        digree = radians(180) - digree;
      }
      if (mineY <= 10 || mineY >= 590) {
        digree = radians(360) - digree;
      }
    } else {
      mineX = 10000;
      mineY = 10000;
    }
    for (int i = 0; i < es0.size(); i++) {  //敵0と当たった時
      mine_distant = sqrt((mineX - es0.get(i).x) * (mineX - es0.get(i).x) + (mineY - es0.get(i).y)* (mineY - es0.get(i).y));
      if (mine_distant <= 20) {
        es0.get(i).enemy_hit = true;
        bs.add(new boost(mineX, mineY, 50, 0));
        mine_hit = true;
      }
    }
    for (int i = 0; i < es1.size(); i++) {   //敵1と当たった時
      mine_distant = sqrt((mineX - es1.get(i).x) * (mineX - es1.get(i).x) + (mineY - es1.get(i).y)* (mineY - es1.get(i).y));

      if (mine_distant <= 20) {

        es1.get(i).enemy_hit = true;
        bs.add(new boost(mineX, mineY, 50, 0));

        mine_hit = true;
      }
    }
    for (int i = 0; i < es2.size(); i++) {   //敵1と当たった時
      mine_distant = sqrt((mineX - es2.get(i).x) * (mineX - es2.get(i).x) + (mineY - es2.get(i).y)* (mineY - es2.get(i).y));

      if (mine_distant <= 20) {

        es2.get(i).enemy_hit = true;
        bs.add(new boost(mineX, mineY, 50, 0));

        mine_hit = true;
      }
    }

    if (mine_hit == true) mn.remove(mine_num);
  }

  void mine_shape(float x, float y) {  //地雷の形を形成する
    noStroke();
    fill(255);
    push();
    translate(x, y);
    beginShape();
    rad = radians(r += 6);//地雷の回転
    rotate(rad);

    for (int i = 0; i < 6; i++) {  //地雷（六角形）を描く
      vertex(10*cos(radians(360*i/6)), 10*sin(radians(360*i/6)));
    }
    endShape(CLOSE);
    pop();
  }
}
