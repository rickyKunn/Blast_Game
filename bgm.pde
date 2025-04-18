int bgm_len;
int bgm_pos;
int waveH = 150;
boolean wave_red = false;
void bgm() {  //bgmを流すか流さないかを決める関数
  bgm_pos = bgm.position();

  if (scine == "game" || scine == "skill") {
    if (bgm_gain <= -4.0) {

      bgm_gain += 1;
      bgm.setGain(bgm_gain);
    }

    if ( bgm.isPlaying() == false && bgm_play == true) {
      //先頭から演奏開始
      bgm.rewind();
      bgm.play();
      bgm_len = bgm.length() - 885;
    }

    if (bgm_pos >= bgm_len) {
      bgm.rewind();
      bgm.play();
    }
  }
  if (bgm.isPlaying() == true && bgm_play == false) {
    bgm.pause();
  }
  if (scine == "title") {
    bgm_play = false;
  } else if (scine == "rule") {
    bgm_play = false;
  } else if (scine == "game") {
    bgm_play = true;
  } else if (scine == "skill") {
    bgm_play = true;
  } else if (scine == "pause") {
    bgm_play = false;
  } else if ( scine == "gameover") {
    bgm_play = false;
  }

  //波形を描く
  for (int i = 0; i < bgm.left.size(); i++) {
    stroke(#1ACBFF);
    if (wave_red == true) {
      stroke(255, 23, 70); //横の線
    }
    strokeWeight(2);
    point(-5 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
    point(1205 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
    stroke(#B0EBFC, 200);
    if (wave_red == true) {
      stroke(255, 140, 150); //横の線
    }
    point(-10 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
    point(1210 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
    stroke(255, 150);
    point(-15 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
    point(1215 +  bgm.left.get(i)*waveH, i);  //左の音声の波形を画面上に描く
  }
}
