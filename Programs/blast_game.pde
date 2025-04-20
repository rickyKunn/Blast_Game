import ddf.minim.*; //<>//
PrintWriter file;  //スコアcsvを作るための変数
Table before_file; //前回までのスコアcsvのデータを読み込むための変数
PFont font;

PImage explain_img;
//スキルの画像
PImage speed_up_img;
PImage mine_img;
PImage bullet_tempo_up_img;
PImage magnet_img;
PImage gatling_img;
PImage bullet_power_img;
PImage beam_img;
PImage wide_shot_img;
PImage line_shot_img;
PImage perforate_img;

ArrayList<boost> bs = new ArrayList<boost>(); //弾けるエフェクト

ArrayList<bullet> bl = new ArrayList<bullet>(); //弾
ArrayList<wide_bullet> wide_bl = new ArrayList<wide_bullet>(); //ワイドショット

ArrayList<mine> mn = new ArrayList<mine>();

ArrayList<enemy0> es0 = new ArrayList<enemy0>();
ArrayList<enemy1> es1 = new ArrayList<enemy1>();
ArrayList<enemy2> es2 = new ArrayList<enemy2>();

ArrayList<exp> ep = new ArrayList<exp>();
ArrayList<beam> bm = new ArrayList<beam>();

ArrayList<score_text> sc_txt = new ArrayList<score_text>();

ArrayList<String> skill_list = new ArrayList<>(); //選ばれたスキルの画像名を格納するリスト
int skills; //選ばれたスキルの数
ArrayList<PImage> skills_img = new ArrayList<>();

int background_r = 0;
int six = -4;
String scine = "title";
int clStart, clReset, clReset1, clReset2, clReset3, clRsm, clRtr, clMenu, clEnd;  //ボタンにカーソルがあった時に色を変えるための変数
boolean left, right, up, down;  //プレイヤーの操作に使う変数
boolean deth = false;  //プレイヤーの生死を確かめる変数
boolean player_deth_boost; //プレイヤーが死んだ時に弾かれたか確かめる変数
float tri; //
float playerX;   //プレイヤーの座標
float playerY;   //
int enemy_num = 5;  //1度の敵0作成に作られる数
int enemy1_num = 3; //1度の敵1作成に作られる数
int enemy2_num = 2;
float playerspX;
float playerspY;



float rad;
float side, hight, deth_r;
int r;
float playerdigree;
int boost;
int t;
float min_digree;
int bullet_num;
int wide_bullet_num;
int hit_num;
float enemyX, enemyY;
int before_kill_num;
int kill_num; //キル数を計る変数
int kill_point;
int start_circle;

int line_rotate;
float level_exp;  //expを得た時に上がる経験値数(レベルによって減少)
float exp_get = 20;
float enemy_exp = 30;  //敵を倒した時に上がる経験値(レベルによって減少)
int level = 1;
boolean level_up = false;
int level_up_time = 0;
int skill_num;

int skill1, skill2, skill3;
String skill1_text, skill2_text, skill3_text;
int clrSkill1, clrSkill2, clrSkill3;   //スコア選択のボタンにカーソルがあった時に色を変える変数　
int before_score;  //最高スコアを格納する変数
int score;  //今のスコアを格納する変数

boolean vibe = false;

float bgm_gain = -40; //bgmのゲイン(音量)を格納する変数(最小-80)
boolean bgm_play;  //bgmが流されるべきか否かを格納する変数
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer bgm;  // bgmデータの格納用の変数
AudioPlayer start_sound;  //サウンドデータ格納用の変数
AudioPlayer click_sound;  //
AudioPlayer deth_sound;   //
AudioPlayer hit_sound;    //
AudioPlayer select_sound; //
AudioPlayer level_up_sound;//

void setup() {
  cursor(HAND);
  before_file = loadTable("score.csv"); //スコアのcsvの読み取り

  if ( before_file != null ) {  //スコアのファイルが空でない場合、値を読み取る
    before_score = before_file.getInt(0, 0);
    before_kill_num = before_file.getInt(0, 1);
  }

  kill_point = before_kill_num;
  for (int i = 0; i < 21; i++) {  //プレイヤーの後ろの跡

    cirX.add(i, 600.0);
    cirY.add(i, 300.0);
  }
  minim = new Minim(this);            //初期化
  bgm = minim.loadFile( "bgm.mp3" );  //bgm
  start_sound = minim.loadFile( "start_sound.mp3" );  //サウンドデータ格納用の変数
  click_sound = minim.loadFile( "click_sound.mp3" );  //
  deth_sound = minim.loadFile( "deth_sound.mp3" );   //
  hit_sound = minim.loadFile( "hit_sound.mp3" );    //
  select_sound = minim.loadFile( "select_sound.mp3" ); //
  level_up_sound = minim.loadFile( "level_up_sound.mp3" );//

  explain_img = loadImage("explain.png");

  speed_up_img = loadImage("speed_up.png");
  mine_img = loadImage("mine.png");
  bullet_tempo_up_img = loadImage("bullet_tempo_up.png");
  magnet_img = loadImage("magnet.png");
  gatling_img = loadImage("gatling.png");
  bullet_power_img = loadImage("bullet_power_up.png");
  beam_img = loadImage("beam.png");
  wide_shot_img= loadImage("wide_shot.png");
  line_shot_img= loadImage("line_shot.png");
  perforate_img = loadImage("perforate.png");

  font = loadFont("ChakraPetch-SemiBold-48.vlw");
  textFont(font);

  size(1200, 600);
  background(0);
  textAlign(CENTER);
  rectMode(CENTER);
}


void draw() {

  if (scine == "title") {
    title_();
  } else if (scine == "rule") {
    rule_();
  } else if (scine == "game") {
    game_();
  } else if (scine == "skill") {
    skill_();
  } else if (scine == "pause") {
    pause_();
  } else if ( scine == "gameover") {
    gameover_();
  }
  skill();
  bgm();
}
