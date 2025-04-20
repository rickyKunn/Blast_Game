void enemy() {  //敵を設定する

  if (t % 200 == 0) { //tが200になった時一度だけ
    int es0_add =es0.size();
    for (int i = es0_add; i < es0_add + enemy_num; i++) { //敵0の生成
      es0.add(new enemy0(random(317, 883), random(11, 589)));
    }
  }

  if (t % 200 == 0 && level >= 2) {  //tが200になってレベルが3以上の時に一度だけ
    int es1_add =es1.size();
    for (int i = es1_add; i< es1_add + enemy1_num; i++) {  //敵1の生成
      es1.add(new enemy1(random(317, 883), random(11, 589)));
    }
  }
  if (t % 200 == 0 && level >= 4) {  //tが200になってレベルが4以上の時に一度だけ
    int es2_add =es2.size();
    for (int i = es2_add; i< es2_add + enemy2_num; i++) {  //敵2の生成
      es2.add(new enemy2(random(317, 883), random(11, 589)));
    }
  }

  for (int i = 0; i < es0.size(); i++) { //敵0を順次更新する
    es0.get(i).drawenemy0(i);
  }

  if (level >= 2) {
    for (int i = 0; i< es1.size(); i++) {  //敵1を順次更新する
      es1.get(i).drawenemy1(i);
    }
  }
  if (level >= 4) {
    for (int i = 0; i< es2.size(); i++) {  //敵2を順次更新する
      es2.get(i).drawenemy2(i);
    }
  }

  for (int i = 0; i < ep.size(); i++) {

    ep.get(i).draw_exp(i);
  }
  t++;
}
