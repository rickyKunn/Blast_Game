void beam_up() {  //ビームクラスを実行する関数

  if (beam_bool == true && level_up == false ) {
    for (int i = 0; i < beam_num; i++) { //ビームを順次更新する
      bm.get(i).draw_beam();
    }
  }
}

class beam {  //ビームクラス
  float beamX, beamY, beamY_trans;
  float beamX_end, beamY_end;
  float beam_digree, beamC_digree;
  int beam_n;
  int beam_size;
  int beam_time = 0;
  int beam_side, beam_sideY;

  beam(int this_num) {
    beam_n = this_num;
  }
  void draw_beam() {

    //複数のビーム生成時に規則的に並ぶための計算------------
    if (beam_n  % 2 == 0) {
      beamY_trans = (beam_num - beam_n - 1) * 12;
    }
    if (beam_n % 2  == 1) {
      beamY_trans = (-beam_num + beam_n) * 12;
    }
    //----------------------------------
    
    if (beam_time <= 99) { //ビームが出ていない時
      beamC_digree = atan2(mouseY - playerY, mouseX- playerX);
      push();
      fill(255);
      translate(playerX, playerY);
      rotate(beamC_digree);
      circle(25, 0, 10); //ビームが出ていない時にカーソルの角度に円をおく
      pop();
    }
    if (beam_time >= 100) {
      if (beam_time == 100) {
        beam_digree = atan2(mouseY - playerY, mouseX- playerX);
      }
      if (beam_n == 0) {
        pointA = new Point2D(playerX + 25 * cos(beam_digree), playerY + 25 * sin(beam_digree));
        pointB = new Point2D(playerX + 1000 * cos(beam_digree), playerY + 1000 * sin(beam_digree));
      }
      strokeWeight(20);
      fill(255, 0, 0);
      line(pointA.x, pointA.y, pointB.x, pointB.y);
      noStroke();
      if (beam_time <= 200) {
        if (beam_size <= 20) {

          beam_size+= 2;
        }
        if (beam_time >= 110) {

          if (beam_time % 8 == 0) {
            beam_side++;
          }
          if (beam_side % 2 == 0) {

            beam_sideY++;
          } else if ( vibe_side % 2 == 1) {
            beam_sideY--;
          }
        }
        push();
        translate(playerX, playerY);
        rotate(beam_digree);
        noStroke();
        fill(#0258CE);
        triangle(50.5, beam_size / 2 + beam_sideY + beamY_trans, 50.5, -beam_size / 2 + beam_sideY + beamY_trans, 25, 0 + beam_sideY + beamY_trans);
        rect(550, beamY_trans + beam_sideY, 1000, beam_size);
        fill(255);
        circle(25, beam_sideY + beamY_trans, 10);
        pop();
        if (beam_n == 0) {
          for (int i = 0; i < es0.size(); i++) {  //敵0の当たり判定を順に見ていく
            pointP = new Point2D(es0.get(i).x, es0.get(i).y);
            boolean beam_hit = isCollisionLineCircle( );  //返り値はビームに敵0が当たったか否か
            if ( beam_hit == true ) {
              es0.get(i).enemy_beam_hit = true;
            } else {
            }
          }
          for (int i = 0; i < es1.size(); i++) {  //敵1の当たり判定を順に見ていく
            pointP = new Point2D(es1.get(i).x, es1.get(i).y);
            boolean beam_hit = isCollisionLineCircle( );   //返り値はビームに敵1が当たったか否か
            if ( beam_hit == true ) {
              es1.get(i).enemy_beam_hit = true;
            } else {
            }
          }

          for (int i = 0; i < es2.size(); i++) {  //敵1の当たり判定を順に見ていく
            pointP = new Point2D(es2.get(i).x, es2.get(i).y);
            boolean beam_hit = isCollisionLineCircle( );   //返り値はビームに敵2が当たったか否か
            if ( beam_hit == true ) {
              es2.get(i).enemy_beam_hit = true;
            } else {
            }
          }
        }
      }
      if ( beam_time >= 201) {  //ビームの変数をリセット

        beam_time = 0;
        beam_size = 0;
        beam_side = 0;
        beam_sideY = 0;
      }
    }

    beam_time+= 2;
  }
}
//ビームと敵の距離を測るために使う変数
Point2D pointA, pointB, pointP, pointX;
Vector2D vecAB, vecAP, vecBP;

class Point2D {
  float  x;  //横位置
  float  y;  //縦位置

  //コンストラクタ
  Point2D( float ix, float iy ) {
    x = ix;
    y = iy;
  }
}


class Vector2D {
  float  x;  //横成分
  float  y;  //縦成分
  float  len;

  //コンストラクタ
  Vector2D() {
    x = 0;
    y = 0;
  }

  //オーバロード
  Vector2D( Point2D A, Point2D B ) {
    x = B.x - A.x;
    y = B.y - A.y;
    //長さを計算
    len = dist(A.x, A.y, B.x, B.y );
  }

  //単位ベクトル生成
  Vector2D normalVec( ) {
    Vector2D retV = new Vector2D();

    retV.x = x / len;
    retV.y = y / len;
    return( retV );
  }

  //ベクトル内積計算
  float inner( Vector2D v1 ) {
    return ( x * v1.x + y * v1.y );
  }

  //ベクトル外積計算
  float cross( Vector2D v1 ) {
    return( x * v1.y - v1.x * y );
  }
}


//当たり判定(ビーム)
boolean isCollisionLineCircle( ) {
  //ベクトルを生成
  vecAB = new Vector2D( pointA, pointB );
  vecAP = new Vector2D( pointA, pointP );
  vecBP = new Vector2D( pointB, pointP );

  //ABの単位ベクトルを計算
  Vector2D normalAB = vecAB.normalVec( );

  //AからXまでの距離を
  //単位ベクトルABとベクトルAPの内積で求める
  float lenAX = normalAB.inner( vecAP );

  float shortestDistance;  //線分APとPの最短距離
  if ( lenAX < 0  ) {
    //AXが負なら APが円の中心までの最短距離
    shortestDistance = vecAP.len;
  } else if ( lenAX > vecAB.len ) {
    //AXがAPよりも長い場合は、BPが円の中心
    //までの最短距離
    shortestDistance = vecBP.len;
  } else {
    //PがAB上にあるので、PXが最短距離
    //単位ベクトルABとベクトルAPの外積で求める
    shortestDistance = abs( normalAB.cross( vecAP ));
  }

  //Xの座標を求める(AXの長さより計算）
  pointX = new Point2D( pointA.x + ( normalAB.x * lenAX ),
    pointA.y + ( normalAB.y * lenAX ) );

  boolean hit = false;
  if ( shortestDistance <  20 * beam_num) {
    //最短距離が円の半径よりも小さい場合は、当たり
    hit = true;
  }
  return( hit );
}
