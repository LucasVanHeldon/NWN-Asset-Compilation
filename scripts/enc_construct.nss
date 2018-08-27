#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="zep_animtome1,zep_animtome2,zep_animtome3,zep_animtome4,zep_animtome5,zep_animtome6,zep_twigblight";

string sCR2="zep_animwheel";
string sCR3="zep_animchest,zep_animchestf,zep_animcutter";
string sCR4="zep_animtable,zep_maug";
string sCR5="zep_mechspider";
string sCR6="juggernaut,zep_maughserg,zep_scarecr";
string sCR7="zep_golemame,zep_golemcitr,zep_golemobs,zep_golemsapph,zep_pumpkin";
string sCR8="nw_golflesh,nw_minogon,zep_minogon,zep_spiker";

string sCR10="nw_golclay,zep_golmaztica,zep_mauglieu";
string sCR11="nw_helmhorr,zep_golemrub";
string sCR12="nw_golbone,x3_emgolem001,x3_rubygolem001,zep_golatlantis,zep_golememer,zep_icefiend1";
string sCR13="nw_bathorror,nw_golstone,nw_shguard";
string sCR14="x3_diagolem001,zep_icefiend2,zep_maugcap";
string sCR15="zep_golem_dam2,zep_sguard_001,zep_shguard_002,zep_shguard_003,zep_shguard_004,zep_shguard_005,zep_shguard_006,zep_shguard_007,zep_shguard_008,zep_shguard_009,zep_shguard_010,zep_shguard_011,zep_shguard_012";
string sCR16="nw_goliron,zep_icefiend3";

string sCR19="zep_golem_dam1";
string sCR20="zep_maugcom";
string sCR21="x2_goliron_huge";

string sCR23="zep_golem_weath";
string sCR25="nw_goldmflesh001";
string sCR27="zep_dragongolem";
string sCR28="zep_golblackrock";
string sCR35="x2_golem001,x2_golem002";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 0:    PopulateVars(o,0,sCR0); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;

    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:   PopulateVars(o,12,sCR12);break;
    case 13:   PopulateVars(o,13,sCR13);break;
    case 14:   PopulateVars(o,14,sCR14);break;
    case 15:   PopulateVars(o,15,sCR15);break;
    case 16:   PopulateVars(o,16,sCR16);break;

    case 19:   PopulateVars(o,19,sCR19);break;
    case 20:   PopulateVars(o,20,sCR20);break;
    case 21:   PopulateVars(o,21,sCR21);break;

    case 23:   PopulateVars(o,23,sCR23);break;
    case 25:   PopulateVars(o,25,sCR25);break;
    case 27: PopulateVars(o,27,sCR27);break;
    case 28: PopulateVars(o,28,sCR28);break;
    case 35: PopulateVars(o,35,sCR35);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    PopulateVars(OBJECT_SELF,0,sCR0);
    Spawn();
}


