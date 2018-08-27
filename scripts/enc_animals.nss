#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0_8="bat001,nw_badger,nw_rat001,nw_ratdire001,zep_cougar,zep_flyingsnake,zep_goat_004,zep_ratsewer,zep_tinydesertvi,zep_tinyforestvi,zep_tinyjunglevi,zep_tinyswampvi";
string sCR1_8="mmp_vampbat,nw_dog004,nw_wolf,vampirebat,wolf001,zep_hyenaspot,zep_hyenastripe";
string sCR2_8="giantlizard,giantviper,nw_boar,nw_cat,nw_cragcat,nw_panther,nw_sharkgoblin,nw_sharkhammer,ratdire002,raven001,zep_bearsloth,zep_bearspec,zep_bearsun,zep_bugcloud,zep_catcheetah,zep_catcloudleop,zep_catleopard,zep_croc_001,zep_croc_002,zep_croc_003,zep_dogwild001,zep_meddesertvi,zep_medforestvi,zep_medjunglevi,zep_medswampvi,zep_piranha_01,zep_piranha_02,zep_piranha_03,zep_shark_001,zep_wolverine";
string sCR3_8="giantcrab,giantdirerat,nw_cougar,nw_direbadg,nw_jaguar,nw_lion,nw_sharkmako,zep_ape,zep_direrabbit,zep_shark_004";
string sCR4_8="zep_cattiger,zep_hugedesertvi,zep_hugeforestvi,zep_hugejunglevi,zep_hugeswampvi,zep_tigerwhite";
string sCR5_8="boardire001,hugedirerat,nw_bearblck,nw_bearbrwn,nw_boardire,nw_direwolf,zep_bugcloudl,zep_fsanddog,zep_hippo,zep_rhino,zep_shark_005,zep_shark_006";
string sCR6_8="nw_bearkodiak,zep_warrhino";
string sCR7_8="nw_bearpolar,zep_shark_002,zep_shark_003";
string sCR9_8="nw_beardire,zep_crab3,zep_crab4,zep_elephant,zep_legendan_004,zep_mastodon";
string sCR10_8="zep_legendan_001";
string sCR11_8="nw_diretiger,nw_wolfdireboss,zep_direelephant,zep_legendan_003,zep_sabertooth";
string sCR15_8="zep_legendan_002";
string sCR18_8="nw_beardireboss";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 1:    PopulateVars(o,1,sCR1_8); break;
    case 2:    PopulateVars(o,2,sCR2_8); break;
    case 3:    PopulateVars(o,3,sCR3_8); break;
    case 4:    PopulateVars(o,4,sCR4_8); break;
    case 5:    PopulateVars(o,5,sCR5_8); break;
    case 6:    PopulateVars(o,6,sCR6_8); break;
    case 7:    PopulateVars(o,7,sCR7_8); break;
    case 9:    PopulateVars(o,9,sCR9_8); break;
    case 10:   PopulateVars(o,10,sCR10_8);break;
    case 11:   PopulateVars(o,11,sCR11_8);break;
    case 15:   PopulateVars(o,15,sCR15_8);break;
    case 18:   PopulateVars(o,18,sCR18_8);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Beasts");
    PopulateVars(OBJECT_SELF,0,sCR0_8);
    Spawn();
}


