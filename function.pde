int vibeX, vibeY; //<>//
int vibe_side = 1;
int vibe_time = 5;

class score_text {
  int enemy_kind;
  int score_plus;
  float scoreY = 130;
  int score_fill = 255;
  String rule_skill;
  score_text(int enemy_kindPos) {
    enemy_kind = enemy_kindPos;
    switch(enemy_kind) {
    case 0:
      score_plus = +1000;
      break;
    case 1:
      score_plus = +1500;
      break;
    case 2:
      score_plus = +2500;
      break;
    }
  }
  //オーバーロード(ルール説明でスキルを購入した時
  score_text(String i) {
    score_plus = -100;
    scoreY = 130;
    rule_skill = i;
  }
  void draw_score_text(int score_num) {

    scoreY -= 1.2;
    score_fill-= 5;
    fill(255, score_fill);
    //ルールの時すきるを購入した時か、相手を倒した時か
    if (rule_skill == "kill point") {
      text( score_plus, 1100, scoreY);
    } else {
      text( "+" +  score_plus, 1120, scoreY);
    }

    if (score_fill <= 0) sc_txt.remove(score_num);
  }
}
void vibration() { //画面が揺れる関数
  if (vibe == true) {
    if (vibe_time % 5 == 0) {
      vibe_side++;
    }
    if (vibe_side % 2 == 0) {

      vibeX++;
      vibeY++;
    } else if ( vibe_side % 2 == 1) {

      vibeX--;
      vibeY--;
    }
    vibe_time++;

    translate(vibeX, vibeY);

    if (vibe_time >= 25) {
      vibeX = 0;
      vibeY = 0;
      vibe_side = 1;
      vibe_time = 7;
      vibe = false;
    }
  }
}

void backshape() {  //動いている背景
  background(0);
  noStroke();
  for ( six = 3; six >= 0; six--) {     //背景の円の設定
    fill(#171717);
    circle(600, 300, 300 * six + background_r);
    fill(0);
    circle(600, 300, 300 * six - 150 + background_r);
    rect(150, 300, 300, 600);     //プレイ画面のサイドの色のリセット
    rect(1050, 300, 300, 600);
  }
  if ( background_r >= 300) {
    background_r = 0;
  }
  background_r += 3 + level;
}
void backshape_pause() { //静止した背景

  background(0);
  noStroke();
  for (six = 3; six >= 0; six--) {     //背景の円の設定
    fill(#171717);
    circle(600, 300, 300 * six + background_r);
    fill(0);
    circle(600, 300, 300 * six - 150 + background_r);
    rect(150, 300, 300, 600);     //プレイ画面のサイドの色のリセット
    rect(1050, 300, 300, 600);
  }
}

void sideline() {
  stroke(#1ACBFF); //横の線
  if (wave_red == true) {
    stroke(255, 23, 70); //横の線
    background_r += 3; //背景の円のスピードを増やす
    wave_red = false; //波長の線を赤くしない
  }
  strokeWeight( 10 );
  line(295, 0, 295, 800);
  line(905, 0, 905, 600);
}

void mousePressed() {
  if ( scine == "title") {

    if ( clStart == 30 ) {
      reset();
      scine = "rule";
      click_sound.rewind();
      click_sound.play();
    } else if ( clReset == 30) {
      reset_mode = true;
      click_sound.rewind();
      click_sound.play();
    } else if (clReset1 == 30) {
      reset_mode = false;
      file = createWriter("score.csv");
      before_score = 0;
      clReset1 = 0;
      file.print(before_score + "," + kill_point);
      file.flush();
      file.close();

      click_sound.rewind();
      click_sound.play();
    } else if (clReset2 == 30) {
      reset_mode = false;
      before_kill_num = 0;
      kill_point = 0;
      clReset2 = 0;
      file = createWriter("score.csv");
      file.print(before_score + "," + kill_point);
      file.flush();
      file.close();

      click_sound.rewind();
      click_sound.play();
    } else if (clReset3 == 30) {
      reset_mode = false;
      click_sound.rewind();
      click_sound.play();
      clReset3 = 0;
    }
  }

  if ( scine == "pause" || scine == "gameover") {

    if ( clRsm == 30 ) {

      scine = "game";
      click_sound.rewind();
      click_sound.play();
    }
    if ( clRtr == 30) {
      scine = "rule";
      click_sound.rewind();
      click_sound.play();
      reset();
    }
    if ( clMenu == 30) {
      scine = "title";
      click_sound.rewind();
      click_sound.play();
      reset();
    }
    if ( clEnd == 30) {
      exit();
    }
  }

  if (scine == "skill") {

    if (clrSkill1 == 30) {
      skill_num = skill1;
      skill_selected = true;
      level_up_reset();
      scine_move = true;
      try {  //エラーが起きたら音を出さない
        start_sound.rewind();
        start_sound.play();
      }
      catch(NullPointerException e) {
      }
    } else if (clrSkill2 == 30) {
      skill_num = skill2;
      skill_selected = true;
      level_up_reset();
      scine_move = true;
      try {  //エラーが起きたら音を出さない
        start_sound.rewind();
        start_sound.play();
      }
      catch(NullPointerException e) {
      }
    } else if (clrSkill3 == 30) {
      skill_num = skill3;
      skill_selected = true;
      level_up_reset();
      scine_move = true;
      try {  //エラーが起きたら音を出さない
        start_sound.rewind();
        start_sound.play();
      }
      catch(NullPointerException e) {
      }
    }
  }
}



void keyPressed() {     //プレイヤーの操作キーの設定

  if (scine == "rule") {

    if (key == ENTER) {
      scine = "game";
      start_sound.rewind();
      start_sound.play();
    }
  }
  if (scine == "game") {

    if (key== 'w') {

      up = true;
    }
    if (key == 'd') {

      right = true;
    }
    if (key == 's') {

      down = true;
    }
    if (key == 'a') {

      left = true;
    }

    if (key == 'p') {

      scine = "pause";
      click_sound.rewind();
      click_sound.play();
    }
  }
}

void keyReleased() {

  if (scine == "game") {

    if (key== 'w') {

      up = false;
    }
    if (key == 'd') {

      right = false;
    }
    if (key == 's') {

      down = false;
    }
    if (key == 'a') {

      left = false;
    }
  }
}

void level_up_reset() {  //スキルを選んだ後余分な変数をリセットする
  background_r = 0;
  t = 0;
  six = -4;


  left = false;
  right = false;
  up = false;
  down = false;
  deth = false;
  cirX.clear(); //プレイヤーの後ろの跡
  cirY.clear();
  cir_num = 21;
  for (int i = 0; i < 21; i++) {

    cirX.add(i, 600.0);
    cirY.add(i, 300.0);
  }
  tri = 0;
  start_circle = 0;
  start_boost = false;
  playerX = 600;
  playerY = 300;
  rad = 0;
  r = 0;
  boost = 0;
  side = 0;
  hight = 0;
  deth_r = 0;

  wide_bl.clear();
  bl.clear();
  mn.clear();
  mine_time = 0;

  ep.clear();

  es0.clear();

  es1.clear();

  es2.clear();


  min_digree = 0;
  deth = false;
  point = 0;
  enemyX = 0;
  enemyY = 0;
  bullet_num = 0;
  wide_bullet_num = 0;
  hit_num = 0;
  level_exp = 0;

  bs.clear();

  wave_red = false;
}

void reset() {  //restartした時に変数をリセットする

  background_r = 0;
  t = 0;
  six = -4;

  clRsm = 0;
  clRtr = 0;
  clMenu = 0;
  left = false;
  right = false;
  up = false;
  down = false;
  deth = false;

  cirX.clear();
  cirY.clear();
  cir_num = 16;
  for (int i = 0; i < 20; i++) {

    cirX.add(i, 600.0);
    cirY.add(i, 300.0);
  }
  tri = 0;

  start_circle = 0;
  start_boost = false;
  playerX = 600;
  playerY = 300;
  playersp = 3;
  rad = 0;
  r = 0;
  boost = 0;
  side = 0;
  hight = 0;
  deth_r = 0;

  enemy_num = 5;
  enemy1_num = 3;
  enemy2_num = 2;

  wide_bl.clear();
  bl.clear();
  mn.clear();
  mine_time = 0;
  mine_bool = false;
  mine_tempo = 120;
  mine_level = 0;

  gatling_time = 0;
  gatling_num = 3;
  gatling = false;
  gatling_mode = false;

  wide_shot = false;

  line_shot = false;
  line_num = 1;

  perforate_num = 0;
  perforate = false;
  for (int i = 0; i < bm.size(); ) {
    bm.remove(i);
  }



  beam_bool = false;
  beam_bool_skill = false;
  beam_num = 0;


  ep.clear();
  ep_magnet = 50;
  es0.clear();
  es1.clear();
  es2.clear();

  min_digree = 0;
  deth = false;
  point = 0;
  enemyX = 0;
  enemyY = 0;
  bullet_num = 0;
  wide_bullet_num = 0;
  bullet_tempo = 8;
  bullet_speed = 6;
  bullet_power = 10;
  hit_num = 0;
  kill_num = 0;
  level_exp = 0;
  exp_get = 30;
  enemy_exp = 40;
  level = 1;
  score = 0;
  before_score = 0;
  before_kill_num = 0;

  before_file = loadTable("score.csv"); //スコアのcsvの読み取り

  if ( before_file != null ) {  //スコアのファイルが空じゃなかった場合、値を読み取る
    before_score = before_file.getInt(0, 0);
    before_kill_num = before_file.getInt(0, 1);
  }

  kill_point = before_kill_num;

  file_print = false;
  skills_img.clear();
  skill_list.clear();
  skills = 0;

  rule_skill = 0;
  rule_skill_text = "";
  rule_skill_sound = false;
  rule_skill_click = false;

  bs.clear();

  wave_red = false;
}
