ArrayList<Float> cirX = new ArrayList<>();
ArrayList<Float> cirY = new ArrayList<>();
int cir_num;
boolean file_print;
boolean start_boost = false;
void player() {

  push();
  translate(600, 600);
  rotate(line_rotate);
  pop();
  
  noFill();
  strokeWeight(1);
  stroke(255);
  circle(600, 300, start_circle);
  start_circle+= 25;
  if (start_boost == false) {
    vibe = true;
    bs.add(new boost(playerX, playerY, 200, 0));
    start_boost = true;
  }

  if ( deth == false) {
    if (up) {       //プレイヤーの動作の設定と後ろの三角形の角度設定

      playerdigree = -90;
    }
    if (right) {

      playerdigree = 0;
    }
    if (down) {

      playerdigree = 90;
    }
    if (left) {

      playerdigree = -180;
      tri = 90;
    }
    if (up && right) {
      playerdigree = -45;
    }
    if (down && right) {
      playerdigree = 45;
    }
    if (down && left) {
      playerdigree = 135;
    }
    if (left && up) {
      playerdigree = -135;
    } else {
      playerspX = 0;
      playerspY = 0;
    }
    if (up || right || down || left) {
      playerspX = playersp * cos(radians(playerdigree));
      playerspY = playersp * sin(radians(playerdigree));
    } else {
    }

    if ( playerspX < 0 && playerX >= 315 || playerspX > 0 && playerX <= 885) {


      playerX += playerspX;
    }
    if ( playerspY < 0 && playerY >= 15 || playerspY > 0&& playerY <= 585 ) {


      playerY += playerspY;
    }
    fill(0);
    rectMode(CENTER);
    noStroke();

    cirX.add(cir_num, playerX); //後ろの三角形の設定
    cirY.add(cir_num, playerY);
    cir_num++;
    for (int i = 15; i > 0; i--) {
      fill(#1ACBFF);
      circle(cirX.get(cir_num - i), cirY.get(cir_num - i), 16 - i);
    }
    fill(0);


    rect(150, 300, 300, 600);     //プレイ画面のサイドの色のリセット
    rect(1050, 300, 300, 600);
//-----プレイヤーの回転動作の設定--------
    push();
    fill(255);
    rad += radians(8);
    translate(playerX, playerY);
    rotate(rad);
    rect(0, 0, 20, 20);
    pop();
//------------------------------------
  } else if ( deth == true ) { //プレイヤーが死んだ時

    if (file_print == false) {
      bs.add(new boost(playerX, playerY, 100, 0));
 //-------------csvファイルに値を保存----------------
      file = createWriter("score.csv");
      kill_point = kill_num + before_kill_num;
      if ( before_score >= score) {
        file.print(before_score + "," + kill_point);
      } else if ( score > before_score) {
        file.print(score + "," + kill_point);
      }
      file.flush();
      file.close();
      file_print = true;
//--------------------------------------------------
    }
  }
}
