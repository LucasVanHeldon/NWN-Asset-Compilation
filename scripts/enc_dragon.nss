#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR2_11="x0_hatch_evil";
string sCR3_11="x0_wyrmling_blk,x0_wyrmling_wht,zep_dracotaur,zep_drgbkw_001,zep_drgwtw_001";
string sCR4_11="x0_wyrmling_grn,x3_wyvern004,zep_drggrw_001,zep_halfdrgn_001,zep_halfdrgn_002";
string sCR5_11="x0_wyrmling_blu,x0_wyrmling_red,zep_drgblw_001,zep_drgrdw_001";
string sCR6_11="x3_wyvern003";
string sCR8_11="x3_wyvern002";
string sCR9_11="nw_halfdra001,x3_wyvern001,zep_halfdrafnd";
string sCR12_11="nw_drgwhite001,zep_drgwtad_001,zep_drgwtad_002,zep_lwhill";
string sCR13_11="drgblack002,nw_drgblack001,zep_drgbkad_001,zep_drgbkad_002";
string sCR14_11="nw_drgblue001,nw_drggreen001,nw_drgwhite003,x3_dragmist001,zep_drgblad_001,zep_drgblad_002,zep_drggrad_001,zep_drggrad_002";
string sCR15_11="nw_drgblack003,nw_drgred001,zep_drgrdad_001,zep_drgrdad_002,zep_lwtundra";
string sCR16_11="nw_drgblue003,nw_drggreen003,nw_drgwhite002,zep_drgwto_001";
string sCR17_11="nw_drgblack002,zep_drgbko_001,zep_lwjungle";
string sCR18_11="nw_drgblue002,nw_drggreen002,nw_drgred003,zep_drgblo_001,zep_drggro_001";
string sCR19_11="nw_drgred002,zep_drgrdo_001";
string sCR20_11="zep_drgwtan_001";
string sCR21_11="zep_cgdrgo_001,zep_drgbkan_001";
string sCR22_11="x2_dragonshad001,zep_cgdrgc_001,zep_cgdrgc_002,zep_cgdrgs_001,zep_cgdrgs_002,zep_drggran_001,zep_drgrust";
string sCR23_11="zep_cgdrga_001,zep_cgdrga_002,zep_cgdrge_001,zep_cgdrge_002,zep_drgblan_001";
string sCR24_11="x0_wyrm_evil,zep_cgdrgt_001,zep_cgdrgt_002,zep_drgrdan_001";
string sCR37_11="x2_dragonpris001";
string sCR38_11="baal,toh_blackwyrm";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 2:    PopulateVars(o,2,sCR2_11); break;
    case 3:    PopulateVars(o,3,sCR3_11); break;
    case 4:    PopulateVars(o,4,sCR4_11); break;
    case 5:    PopulateVars(o,5,sCR5_11); break;
    case 6:    PopulateVars(o,6,sCR6_11); break;
    case 8:    PopulateVars(o,7,sCR8_11); break;
    case 9:    PopulateVars(o,9,sCR9_11); break;
    case 12:   PopulateVars(o,11,sCR12_11);break;
    case 13:   PopulateVars(o,12,sCR13_11);break;
    case 14:   PopulateVars(o,13,sCR14_11);break;
    case 15:   PopulateVars(o,15,sCR14_11);break;
    case 16:   PopulateVars(o,16,sCR14_11);break;
    case 17:   PopulateVars(o,17,sCR14_11);break;
    case 18:   PopulateVars(o,18,sCR18_11);break;
    case 19:   PopulateVars(o,19,sCR19_11);break;
    case 20:   PopulateVars(o,20,sCR20_11);break;
    case 21:   PopulateVars(o,21,sCR21_11);break;
    case 22:   PopulateVars(o,22,sCR22_11);break;
    case 23:   PopulateVars(o,23,sCR23_11);break;
    case 24:   PopulateVars(o,24,sCR24_11);break;
    case 37:   PopulateVars(o,37,sCR37_11);break;
    case 38:   PopulateVars(o,38,sCR38_11);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Beasts");
    Spawn();
}


