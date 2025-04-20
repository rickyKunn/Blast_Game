boolean scine_move = false;

boolean speed_up;
float playersp = 3;

boolean bullet_tempo_up;
float bullet_tempo = 8;

boolean magnet;
int ep_magnet = 50;

float bullet_speed = 6;

boolean mine_bool;
boolean mine_bool_skill;
float mine_tempo = 150;
int mine_level = 0;

int gatling_time;
int gatling_num = 3;
boolean gatling_bool;
boolean gatling;
boolean gatling_mode;

float bullet_power = 10;
boolean bullet_power_bool;

boolean beam_bool;
boolean beam_bool_skill;
int beam_num = 0;

boolean wide_shot_bool;
boolean wide_shot;

boolean line_shot_bool;
boolean line_shot;
int line_num = 1;

boolean perforate_bool;
boolean perforate;
int perforate_num = 0;
boolean skill_selected = false;

void skill() {

  if (speed_up == true) {
    playersp += 1;

    speed_up = false;
  }

  if (bullet_tempo_up == true) {
    bullet_tempo += 2;
    bullet_tempo_up = false;
  }

  if (magnet == true) {
    ep_magnet +=100;
    magnet = false;
  }

  if (mine_bool_skill == true) {
    mine_level++;
    mine_bool = true;
    mine_bool_skill = false;
  }

  if (gatling_bool == true) {
    gatling = true;
    gatling_num += 2;
    bullet_tempo -=1;
    bullet_power -= 3;
    gatling_bool = false;
  }

  if (bullet_power_bool == true) {
    bullet_power += 2;
    bullet_power_bool = false;
  }

  if ( beam_bool_skill == true) {
    bm = new ArrayList<beam>();
    beam_num+= 1;
    for (int i = 0; i < beam_num; i++) {
      bm.add(new beam(i));
    }
    beam_bool = true;
    beam_bool_skill = false;
  }

  if (wide_shot_bool == true) {

    bullet_tempo-= 2;
    wide_shot = true;
    wide_shot_bool = false;
  }

  if (line_shot_bool == true) {

    line_shot = true;
    line_num++;
    line_shot_bool = false;
  }
  
  if(perforate_bool == true){
  
    perforate_num++;
    perforate = true;
    perforate_bool = false;
  }
}
