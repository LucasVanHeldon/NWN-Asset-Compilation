#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="zep_skeldoll2,zep_skeldolls,zep_wspiders,zep_wspidert";
string sCR1="nw_skeleton,nw_zombie01,nw_zombie02,toh_diszombie,wretcher,zep_skeldwarf,zep_skeldwarf2";
string sCR2="desecratesaint,nw_ghoul,zep_shade,zep_wspiderm";
string sCR3="ghul,nw_shadow,nw_vampire_shad,nw_zombtyrant,toh_evovledshad,zep_iceghoul,zep_skelflaming,zep_skelgreen,zep_skelpurple,zep_skelyellow,zep_vampireshad,zombie002,zombie004,zombie005,zombie006,zombie007,zombie008,zombie009,zombie010,zombie011,zombie012,zombtyrant001";
string sCR4="nw_allip,nw_ghast,nw_skelmage,nw_skelpriest,nw_spidwra,nw_s_wight,nw_wight,nw_zombwarr01,nw_zombwarr02,skeletalevoker,skelmage002,skelpriest001,skelpriest010,toh_ghasltysk001,toh_nastyghoul,zep_batbattle,zep_batbone,zep_ghostpirate,zep_shade001,zep_skelpir1,zep_skelpir2,zep_skelpir3,zep_skelpir4,zep_skelpir5,zep_skelpir6,zep_spidwra,zep_wspiderl,zep_zombpir1,zep_zombpir2,zep_zombpir3,zep_zombpir5,zombie003,zombwarr002,zombwarr003";
string sCR5="butchersaint,butchersaint001,nw_curst001,nw_curst003,nw_ghoullord,nw_mummy,skeletalconjurer,toh_ghasltysk002,toh_ghasltysk004,toh_ghasltysk005,toh_ghasltysk006,toh_ghasltysk007,toh_ghasltysk011,toh_ghasltysk012,toh_ghasltysk042,toh_ghasltyskele,toh_morbidghoul,toh_shadorcus,zep_skelredeyes,zep_visage";
string sCR6="ghoul001,nw_curst002,nw_curst004,nw_skelwarr01,nw_skelwarr02,nw_wraith,shadowconjurer,toh_ghasltysk003,toh_ghasltysk032,toh_oozeghast,toh_scumghast,wight009,x2_s_wraith,x3_curstsword,zep_skeldyn_001";
string sCR7="nw_revenant001,nw_spectre,nw_vampire,skelmage025,skelpriest007,toh_banshee,toh_ghasltysk008,toh_ghasltysk043,wight006,zep_ghostf_001,zep_ghostf_002,zep_ghostf_003,zep_ghostf_004,zep_ghostf_005,zep_ghostf_006,zep_ghostf_007,zep_ghostf_008,zep_ghostf_009,zep_ghostf_010,zep_ghostf_011,zep_ghostf_012,zep_ghostf_013,zep_ghostf_014,zep_ghostf_015,zep_ghostf_016,zep_ghostf_017,zep_ghostf_018,zep_visagegr";
string sCR8="allip001,allip002,mummy003,mummy005,nw_mohrg,nw_zombieboss,toh_corghast,toh_demonicghast,toh_ghasltysk009,toh_greatshadow,toh_haunted,toh_unholyghoul,wight002,wight003,wight004,x2_s_mummy_9,zep_wendigo,zep_wraith002,zep_wraith1,zep_wraith2";
string sCR9="groaningspirit,mummy001,mummy004,nw_bodak,skelmage001,skelmage003,skelmage255,toh_demonicshado,toh_skeletalaber,toh_unholypriest,wight001,wight010,wraith001,zep_quthmaren";
string sCR10="nw_doomkght,nw_ghoulboss,nw_mumfight,skelpriest003,spectre002,toh_darkghast,toh_fallenmummy,toh_skeletalwiz,x2_s_spectre_10";
string sCR11="mummy002,nw_mummyboss,nw_skelchief,skelpriest004,x2_s_bodak_14,x2_s_vamp_10,zep_skeldyn_002";
string sCR12="bastardsaint,fallenone,ghast001,knightofbaal,nw_vampire001,skelpriest002,skelwarr002,skelwarr006,spectre001,zep_beholder_dt";
string sCR13="mumfight001,nw_shfiend,nw_skeldevour,nw_vampire002,nw_vampire004,toh_demonic_ghul,wight007,x2_s_bguard_18,zep_flvampm_001,zep_shlord";
string sCR14="bellreid,julian,mumcleric001,skelpriest008,skelpriest009,skelwarr003,toh_demonicvamp,toh_nightstalker,vampire001,x2_s_ghoul_16,zep_flvampf_001";
string sCR15="mumcleric002,nw_doomkghtboss";
string sCR16="mumfight002,nw_mumcleric,nw_vampire003,skelwarr005,vampire002,wight005,x3_hagatha,zep_reaver_001";
string sCR17="nw_lich003,skelpriest005,toh_evilspiri001,toh_evilspirit,zep_lizlich2";
string sCR18="x2_mindflayer003,x2_s_vamp_18,zep_cjguard_001,zep_skeldyn_003,zep_wraith003,zep_wraith004";
string sCR19="ghast002,toh_haunted001,toh_hereticalgha,toh_morbidsaint,zep_shlord001,zep_wraith005,zep_wspiderg";
string sCR20="mummyboss001,toh_darkghast001,toh_demonicfiend,zep_demi_lich,zep_dklord_001,zep_dklord_002";
string sCR21="nw_lichboss,toh_unholypri001,x2_s_lich_20,zep_lizlich3";
string sCR22="toh_fallenghoul,wight008,x2_s_lich_24";
string sCR23="mumcleric003,toh_morbidsai001,x2_s_lich_26,x2_s_lich_30";
string sCR24="skeleton001,skelwarr004,x2_demilich001";
string sCR25="x2_s_lich_22";
string sCR26="skeleton002,toh_demon,toh_spawnoforcus";
string sCR27="skelpriest006";
string sCR28="lich002,lich003,lich005,nw_lich001,vampire003,zep_lizlich1";
string sCR29="voidwraith";
string sCR30="toh_fallengho001";
string sCR32="toh_morbidhereti,x3_masterius001,x3_masterius002,x3_masterius003";
string sCR33="toh_champofhell";
string sCR34="toh_lichdemon";
string sCR35="skelwarr007";
string sCR36="lich004";
string sCR40="toh_champofhe001,toh_deathpriest";
string sCR41="lich006";
string sCR42="zep_dracolich";
string sCR43="x2_dracolich001";
string sCR45="tk_demi_lich";
string sCR47="lich009,toh_champofhe002,toh_deathlich,toh_lichking";
string sCR53="lich007";
string sCR54="lich008,zep_vecna";
string sCR63="toh_eldritchlich";






void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;
    case 9:    PopulateVars(o,9,sCR9); break;
    case 10:     PopulateVars(o,10,sCR10);break;
    case 11:    PopulateVars(o,11,sCR11);break;
    case 12:    PopulateVars(o,12,sCR12);break;
    case 13:    PopulateVars(o,13,sCR13);break;
    case 14:    PopulateVars(o,14,sCR14);break;
    case 15:    PopulateVars(o,15,sCR15);break;
    case 16:    PopulateVars(o,16,sCR16);break;
    case 17:    PopulateVars(o,17,sCR17);break;
    case 18:    PopulateVars(o, 18 ,sCR18 );break;
    case 19:    PopulateVars(o, 19 ,sCR19 );break;
    case 20:    PopulateVars(o, 20 ,sCR20 );break;
    case 21:    PopulateVars(o, 21 ,sCR21 );break;
    case 22:    PopulateVars(o, 22 ,sCR22 );break;
    case 23:    PopulateVars(o, 23 ,sCR23 );break;
    case 24:    PopulateVars(o, 24 ,sCR24 );break;
    case 25:    PopulateVars(o, CR ,sCR25 );break;
    case 26:    PopulateVars(o, CR ,sCR26 );break;
    case 27:    PopulateVars(o, 27 ,sCR27 );break;
    case 28:    PopulateVars(o, 28 ,sCR28 );break;
    case 29:    PopulateVars(o, CR ,sCR29 );break;
    case 30:    PopulateVars(o, CR ,sCR30 ); break;
    case 32:    PopulateVars(o, 32 ,sCR32 );break;
    case 33:    PopulateVars(o, 33 ,sCR33 );break;
    case 34:    PopulateVars(o, 34 ,sCR34 );break;
    case 35:    PopulateVars(o, 35 ,sCR35 );break;
    case 36:    PopulateVars(o, 36 ,sCR36 );break;
    case 40:    PopulateVars(o, CR ,sCR40 );break;
    case 41:    PopulateVars(o, 41 ,sCR41 );break;
    case 42:    PopulateVars(o, 42 ,sCR42 );break;
    case 43:    PopulateVars(o, 43 ,sCR43 );break;
    case 45:    PopulateVars(o, 45 ,sCR45 );break;
    case 47:    PopulateVars(o, 47 ,sCR47 );break;
    case 53:    PopulateVars(o, 53 ,sCR53 );break;
    case 54:    PopulateVars(o, 54 ,sCR54 );break;
    case 63:    PopulateVars(o, CR ,sCR63 );break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Undead");
    PopulateVars(OBJECT_SELF,0,sCR0);
    Spawn();

}


