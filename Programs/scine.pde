int score_time; //スコアが点滅する周期を決めるための変数
int score_clr; //スコアが点滅するための変数
boolean reset_mode; //リセットするために使う変数
void title_() {
  playerX = 0;
  playerY = 0;//背景の敵に当たらないようにするため
  if ( mouseX >= 475 && mouseX <= 725 && mouseY >= 435 && mouseY <= 525) { //スタートボタン
    clStart = 30;
    if (sound_bool1 == true) {
      select_sound = minim.loadFile("select_sound.mp3");
      select_sound.play();
    }
    sound_bool1 = false;
  } else {
    clStart = 0;
    sound_bool1 = true;
  }

  if (mouseX >= 950 && mouseX <= 1150 && mouseY >= 200 && mouseY <= 250 && reset_mode == false) {  //スコアcsvをリセットするボタン
    clReset = 30;
    if (sound_bool2 == true) {
      select_sound = minim.loadFile("select_sound.mp3");
      select_sound.play();
    }
    sound_bool2 = false;
  } else {
    clReset = 0;
    sound_bool2 = true;
  }

  backshape();
  sideline();
  enemy();  //スタート画面に投影する敵
  boost_up();

  noStroke();

  if (reset_mode == false) {
    strokeWeight(10);
    stroke(72 + clReset);
    fill(82 + clReset, 85 + clReset, 85 + clReset);
    rect(1050, 225, 200, 50);
    textSize(30);
    fill(255);
    text("RESET", 1050, 235);
  }

  if (reset_mode == true) {
    strokeWeight(5);
    stroke(72 + clReset1);
    fill(82 + clReset1, 85 + clReset1, 85 + clReset1);
    rect(980, 200, 130, 40);
    stroke(72 + clReset2);
    fill(82 + clReset2, 85 + clReset2, 85 + clReset2);
    rect(1120, 200, 130, 40);
    stroke(72 + clReset3);
    fill(82 + clReset3, 85 + clReset3, 85 + clReset3);
    rect(1050, 250, 150, 40);

    if (mouseX >= 915 && mouseX <= 1045 && mouseY >= 180 && mouseY <= 220) {  //最高スコアリセット
      clReset1 = 30;
      if (sound_bool3 == true) {
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      sound_bool3 = false;
    } else {
      clReset1 = 0;
      sound_bool3 = true;
    }

    if (mouseX >= 1055 && mouseX <= 1185 && mouseY >= 180 && mouseY <= 220) {  //キルポイントリセット
      clReset2 = 30;
      if (sound_bool4 == true) {
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      sound_bool4 = false;
    } else {
      clReset2 = 0;
      sound_bool4 = true;
    }

    if (mouseX >= 975 && mouseX <= 1125 && mouseY >= 230 && mouseY <= 270) {  //キャンセルボタン
      clReset3 = 30;
      if (sound_bool5 == true) {
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      sound_bool5 = false;
    } else {
      clReset3 = 0;
      sound_bool5 = true;
    }

    fill(255);
    textSize(25);
    text("SCORE", 980, 210);
    textSize(18);
    text("KILL POINT", 1120, 205);
    textSize(25);
    text("CANCEL", 1050, 260);
  }

  fill(82 + clStart, 85 + clStart, 85 + clStart);
  strokeWeight(10);
  stroke(72 + clStart);
  rect(600, 475, 250, 90);

  fill(255);
  textSize(65);
  text("START", 600, 500);
  textSize(73);
  text("BLAST GAME", 600, 300);

  textSize(27);
  text("HIGH SCORE:" + before_score, 1050, 100);  //最高スコアの表示
  text("KILL POINT:" + kill_point, 1050, 150); //キルポイントの表示
}

void rule_() {

  background(0);
  backshape();
  sideline();
  rule_skill_select();
  for ( int i = 0; i < sc_txt.size(); i++) sc_txt.get(i).draw_score_text(i); //スキルを購入した時にエフェクトを表示する

  image(explain_img, 300, 0);

  fill(255);
  textSize(56);
  //text("KILL THE ENEMY!", 600, 60);

  textSize(27);
  text("HIGH SCORE:" + before_score, 1050, 100);
  text("KILL POINT:" + kill_point, 1050, 150); //キルポイントの表示
}

void game_() {
  vibration();
  backshape();
  beam_up();
  boost_up();
  gauge();
  player();
  sideline();
  enemy();
  mine_up();
  level_up();
  skill_images();
  textSize(30);
  text("SCORE:" + score, 1050, 150);
  for ( int i = 0; i < sc_txt.size(); i++) sc_txt.get(i).draw_score_text(i); //敵を倒した時のスコアアップのエフェクトの表示
  if (deth == true) {
    backshape();
    boost_up();
    player();
    sideline();
    enemy();
  }
}

void skill_() {

  backshape();
  sideline();
  skill_images();
  fill(255);
  textSize(80);
  textAlign(CENTER);
  text("Select Skill!", 600, 200);
  //textAlign(CORNER);
  textSize(40);

  text("Lv" + level, 150, 300);
  noStroke();
  fill(#788186);
  rectMode(CENTER);
  rect(220, 280, 30, 380);
  fill(255);

  textSize(30);
  text("SCORE:" + score, 1050, 150);

  textSize(57);

  skill_select();
}

void pause_() {
  backshape_pause();
  sideline();
  skill_images();
  noStroke();

  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 195 && mouseY <= 285) {
    clRsm = 30;

    if (sound_bool1 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool1 = false;
  } else {
    clRsm = 0;
    sound_bool1 = true;
  }
  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 345 && mouseY <= 435) {

    clRtr = 30;

    if (sound_bool2 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool2 = false;
  } else {

    clRtr = 0;
    sound_bool2 = true;
  }
  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 495 && mouseY <= 585) {

    clMenu = 30;

    if (sound_bool3 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound = minim.loadFile("select_sound.mp3");
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool3 = false;
  } else {

    clMenu = 0;
    sound_bool3 = true;
  }
  strokeWeight(10);
  stroke(72 + clRsm);
  fill(82 + clRsm, 85 + clRsm, 85 + clRsm);
  rect(600, 240, 300, 90);

  stroke(72 + clRtr);
  fill(82 + clRtr, 85 + clRtr, 85 + clRtr);
  rect(600, 390, 300, 90);

  stroke(72 + clMenu);
  fill(82 + clMenu, 85 + clMenu, 85 + clMenu);
  rect(600, 540, 300, 90);

  fill(255);
  textSize(100);
  text("PAUSE", 600, 120);

  textSize(50);
  text("RESUME", 600, 260);
  text("RETRY", 600, 410);
  text("MENU", 600, 560);

  textSize(30);
  text("SCORE:" + score, 1050, 150);
}

void gameover_() {

  backshape_pause();
  sideline();
  noStroke();

  fill(255);
  textSize(70);
  textAlign(CENTER);
  text("GAME OVER", 600, 120);
  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 195 && mouseY <= 285) {

    clEnd = 30;

    if (sound_bool1 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound.rewind();
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool1 = false;
  } else {

    clEnd = 0;
    sound_bool1 = true;
  }
  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 345 && mouseY <= 435) {

    clRtr = 30;

    if (sound_bool2 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound.rewind();
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool2 = false;
  } else {

    clRtr = 0;
    sound_bool2 = true;
  }
  if ( mouseX >= 450 && mouseX <= 750 && mouseY >= 495 && mouseY <= 585) {

    clMenu = 30;

    if (sound_bool3 == true) { //カーソルが合ってる時の効果音

      try {  //エラーが起きたら音を出さない
        select_sound.rewind();
        select_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
    sound_bool3 = false;
  } else {

    clMenu = 0;

    sound_bool3 = true;
  }

  fill(82 + clEnd, 85 + clEnd, 85 + clEnd);
  rect(600, 240, 300, 90);

  fill(82 + clRtr, 85 + clRtr, 85 + clRtr);
  rect(600, 390, 300, 90);

  fill(82 + clMenu, 85 + clMenu, 85 + clMenu);
  rect(600, 540, 300, 90);

  fill(255);
  textSize(100);

  textSize(50);
  text("END", 600, 260);
  text("RETRY", 600, 410);
  text("MENU", 600, 560);

  textSize(25);
  if ( before_score >= score) {
    fill(255);
    text("HIGH SCORE:" + before_score, 1050, 100);
    text("SCORE:" + score, 1050, 130);
  } else if ( score > before_score) {
    fill(255, 70 + score_clr, 70 + score_clr); //赤く点滅
    text("HIGH SCORE:" + score, 1050, 100);
    fill(255);
    text("SCORE:" + score, 1050, 150);
  }
  text("KILL POINT:" + kill_point, 1050, 200);
  fill(255, 70 + score_clr, 70 + score_clr);
  text("+" + kill_num, 1150, 230); //キルポイントの加点

  score_time++;
  if (score_time == 30) { //赤く点滅
    score_clr = 60;
  } else if (score_time == 60) {
    score_clr = 0;
    score_time = 0;
  }
}
