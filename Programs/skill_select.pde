boolean sound_bool1 = true, sound_bool2 = true, sound_bool3 = true, sound_bool4 = true, sound_bool5 = true; //<>//


void skill_select() {

  strokeWeight(10);
  fill(100 + clrSkill1, 200);
  stroke(72 + clrSkill1);
  rect(405, 400, 180, 180);

  fill(100 + clrSkill2, 200);
  stroke(72 + clrSkill2);
  rect(600, 400, 180, 180);

  fill(100 + clrSkill3, 200);
  stroke(72 + clrSkill3);
  rect(795, 400, 180, 180);

  if (mouseX >= 315 && mouseX<= 495 && mouseY >= 310 && mouseY <= 490) {

    clrSkill1 = 30;

    if (sound_bool1 == true) {  //カーソルが合ってる時の効果音
      select_sound.rewind();
      select_sound.play();
    }
    sound_bool1 = false;
  } else {
    clrSkill1= 0;
    sound_bool1 = true;
  }
  if (mouseX >= 510 && mouseX<= 690 && mouseY >= 310 && mouseY <= 490) {

    clrSkill2 = 30;
    if (sound_bool2 == true) { //カーソルが合ってる時の効果音
      select_sound.rewind();
      select_sound.play();
    }
    sound_bool2 = false;
  } else {
    clrSkill2= 0;
    sound_bool2 = true;
  }
  if (mouseX >= 705 && mouseX<= 890 && mouseY >= 310 && mouseY <= 490) {

    clrSkill3 = 30;
    if (sound_bool3 == true) { //カーソルが合ってる時の効果音
      select_sound.rewind();
      select_sound.play();
    }
    sound_bool3 = false;
  } else {
    clrSkill3= 0;
    sound_bool3 = true;
  }
  switch(skill1) {   //スキル選択のテキストと絵
  case 1:
    skill1_text = "speed up";
    image(speed_up_img, 305, 320);
    break;

  case 2:
    skill1_text = "tempo up";
    image(bullet_tempo_up_img, 320, 310);
    break;

  case 3:
    skill1_text = "magnet";
    image(magnet_img, 315, 310);
    break;

  case 4:
    skill1_text = "mine";
    image(mine_img, 320, 310);
    break;


  case 5:
    skill1_text = "gatling";
    image(gatling_img, 320, 310);
    break;


  case 6:
    skill1_text = "power up";
    image(bullet_power_img, 320, 310);

    break;


  case 7:
    skill1_text = "beam";
    image(beam_img, 320, 310);
    break;



  case 8:
    skill1_text = "wide shot";
    if (wide_shot == true) skill1 = int(random(1, 10.9));
    image(wide_shot_img, 320, 310);

    break;


  case 9:
    skill1_text = "line shot";
    image(line_shot_img, 320, 310);

    break;


  case 10:
    skill1_text = "perforate";
    image(perforate_img, 320, 310);
    break;
  }

  switch(skill2) {
  case 1:
    skill2_text = "speed up";
    image(speed_up_img, 500, 320);
    break;



  case 2:
    skill2_text = "tempo up";
    image(bullet_tempo_up_img, 510, 310);
    break;


  case 3:
    skill2_text = "magnet";
    image(magnet_img, 510, 310);
    break;

  case 4:
    skill2_text = "mine";
    image(mine_img, 515, 310);
    break;


  case 5:
    skill2_text = "gatling";
    image(gatling_img, 510, 310);
    break;


  case 6:
    skill2_text = "power up";
    image(bullet_power_img, 510, 310);
    break;


  case 7:
    skill2_text = "beam";
    image(beam_img, 510, 310);
    break;


  case 8:
    if (wide_shot == true) skill2 = int(random(1, 10.9));
    skill2_text = "wide shot";
    image(wide_shot_img, 510, 310);
    break;


  case 9:
    skill2_text = "line shot";
    image(line_shot_img, 510, 310);
    break;


  case 10:
    skill2_text = "perforate";
    image(perforate_img, 510, 310);
    break;
  }

  switch(skill3) {
  case 1:
    skill3_text = "speed up";
    image(speed_up_img, 695, 320);
    break;

  case 2:

    skill3_text = "tempo up";
    image(bullet_tempo_up_img, 705, 310);
    break;

  case 3:

    skill3_text = "magnet";
    image(magnet_img, 705, 310);
    break;

  case 4:
    skill3_text = "mine";
    image(mine_img, 710, 310);
    break;

  case 5:
    skill3_text = "gatling";
    image(gatling_img, 705, 310);
    break;

  case 6:
    skill3_text = "power up";
    image(bullet_power_img, 705, 310);
    break;

  case 7:
    skill3_text = "beam";
    image(beam_img, 705, 310);
    break;

  case 8:
    if (wide_shot == true) skill3 = int(random(1, 10.9));

    skill3_text = "wide shot";
    image(wide_shot_img, 705, 310);
    break;

  case 9:
    skill3_text = "line shot";
    image(line_shot_img, 705, 310);

    break;

  case 10:
    skill3_text = "perforate";
    image(perforate_img, 705, 310);
    break;
  }

  textSize(30);
  textAlign(CENTER);
  fill(255);
  text(skill1_text, 405, 550);
  text(skill2_text, 600, 550);
  text(skill3_text, 795, 550);
  //textAlign(CORNER);
  textSize(57);
  if (skill_selected == true) {

    switch(skill_num) {

    case 1:
      speed_up = true;
      skill_list.add(skills, "speed_up_mini.png");
      break;

    case 2:
      bullet_tempo_up = true;
      skill_list.add(skills, "bullet_tempo_up_mini.png");
      break;

    case 3:
      magnet = true;
      skill_list.add(skills, "magnet_mini.png");
      break;

    case 4:
      mine_bool_skill = true;
      skill_list.add(skills, "mine_mini.png");
      break;

    case 5:
      gatling_bool = true;
      skill_list.add(skills, "gatling_mini.png");
      break;

    case 6:
      bullet_power_bool = true;
      skill_list.add(skills, "bullet_power_up_mini.png");
      break;

    case 7:
      beam_bool_skill = true;
      skill_list.add(skills, "beam_mini.png");
      break;

    case 8:
      wide_shot_bool = true;
      skill_list.add(skills, "wide_shot_mini.png");
      break;

    case 9:
      line_shot_bool = true;
      skill_list.add(skills, "line_shot_mini.png");
      break;

    case 10:
      perforate_bool = true;
      skill_list.add(skills, "perforate_mini.png");
      break;
    }
    skills_img.add(skills, loadImage(skill_list.get(skills))); //画像の配列に格納する
    skills++; //選ばれたスキルの数をインクリメント
    skill_selected = false;
  }

  if (scine_move == true) {

    scine = "game";
    scine_move = false;
  }
}

void skill_images() {
  int pngX = 0;
  if (skills >= 1) {
    for (int i = 0; i < skills_img.size(); i++) {
      if (pngX % 5 == 0) {
        pngX = 0;
      }
      g.removeCache(skills_img.get(i));
      image(skills_img.get(i), 920 + 55 * pngX, 200 + 55 * (i / 5));
      pngX++;
    }
  }
}


int rule_skill_clr;
int rule_skill;
String rule_skill_text;
boolean rule_skill_sound, rule_skill_click;
PImage rule_skill_img;

//ルールの時にスキルを購入する
void rule_skill_select() {

  if (scine == "rule" && mouseX >= 980 && mouseX <= 1120 && mouseY >= 320 && mouseY <= 460 && rule_skill_click == false) {

    rule_skill_clr = 30;
    if ( rule_skill_sound == false) {
      select_sound.rewind();
      select_sound.play();
      rule_skill_sound = true;
    }
  } else {
    rule_skill_sound = false;
    rule_skill_clr = 0;
  }
  if (kill_point >= 100 && rule_skill_clr == 30 && mousePressed == true && rule_skill_click == false) {
    sc_txt.add( new score_text("kill point"));
    rule_skill = int(random(1, 10.99));
    rule_skill_click = true;
    click_sound.rewind();
    click_sound.play();

    //キルスコアが100減ったことをcsvに保存
    file = createWriter("score.csv");
    kill_point -= 100;
    before_kill_num -= 100;
    file.print(before_score + "," + kill_point);
    file.flush();
    file.close();

    switch(rule_skill) {
    case 1:
      speed_up = true;
      skill_list.add("speed_up_mini.png");
      rule_skill_text = "speed up";

      break;
    case 2:
      bullet_tempo_up = true;
      skill_list.add("bullet_tempo_up_mini.png");
      rule_skill_text = "tempo up";

      break;
    case 3:
      magnet = true;
      skill_list.add( "magnet_mini.png");
      rule_skill_text = "magnet";

      break;
    case 4:
      mine_bool_skill = true;
      skill_list.add("mine_mini.png");
      rule_skill_text = "mine";

      break;
    case 5:
      gatling_bool = true;
      skill_list.add("gatling_mini.png");
      rule_skill_text = "gatling";

      break;
    case 6:
      bullet_power_bool = true;
      skill_list.add( "bullet_power_up_mini.png");
      rule_skill_text = "power up";

      break;
    case 7:
      beam_bool_skill = true;
      skill_list.add("beam_mini.png");
      rule_skill_text = "beam";

      break;
    case 8:
      wide_shot_bool = true;
      skill_list.add("wide_shot_mini.png");
      rule_skill_text = "wide shot";

      break;
    case 9:
      line_shot_bool = true;
      skill_list.add("line_shot_mini.png");
      rule_skill_text = "line shot";

      break;
    case 10:
      perforate_bool = true;
      skill_list.add("perforate_mini.png");
      rule_skill_text = "perforate";

      break;
    }
    rule_skill_img = loadImage(skill_list.get(skills).replace("_mini", ""));
    skills_img.add(skills, loadImage(skill_list.get(skills))); //画像の配列に格納する
    skills++; //選ばれたスキルの数をインクリメント
  }

  strokeWeight(10);
  stroke(72 + rule_skill_clr);
  fill(100 + rule_skill_clr, 200);
  rect(1050, 390, 140, 140);

  textSize(80);
  if (rule_skill_click == false) {
    fill(255);
    text("?", 1050, 420);
    textSize(30);
    text("Buy skill!", 1050, 305);
    text("-100Pt", 1050, 500);
  } else {
    image(rule_skill_img, 980, 320, 135, 135);
    fill(255);
    textSize(30);
    text(rule_skill_text, 1050, 500);
  }
}
