#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR1="zep_skeldwarf,zep_skeldwarf2,nw_skeleton,toh_diszombie,wretcher,nw_zombie01,nw_zombie02";
string sCR2="nw_ghoul,zep_shade,desecratesaint";
string sCR3="ghul,zep_iceghoul,toh_evovledshad,nw_shadow,zep_vampireshad,zep_skelflaming,zep_skelpurple,zep_skelgreen,zep_skelyellow,zep_skelogre,zombie004,zombie012,zombie008,zombie010,zombie005,zombie009,zombie011,zombie006,zombie007,zombie002,zombtyrant001,nw_zombtyrant";
string sCR4="ghoul002,toh_nastyghoul,zep_batbattle,zep_batbone,zep_shade001,toh_ghasltysk001,skelmage002,skeletalevoker,skelpriest001,skelpriest010,nw_skelmage,nw_allip,zombie003,zombwarr002,zombwarr003,nw_zombwarr01,nw_zombwarr02";
string sCR5="nw_ghoullord,toh_morbidghoul,nw_mummy,nw_curst003,nw_curst001,toh_shadorcus,zep_skelredeyes,toh_ghasltysk002,toh_ghasltysk004,toh_ghasltyskele,toh_ghasltysk005,toh_ghasltysk006,toh_ghasltysk007,toh_ghasltysk012,toh_ghasltysk042,skeletalconjurer,toh_ghasltysk011,zep_visage,nw_wraith,butchersaint,butchersaint001";
string sCR6="ghasthorde,ghoul001,toh_oozeghast,toh_scumghast,nw_curst004,nw_curst002,x3_curstsword,wight009,shadowconjurer,toh_ghasltysk003,toh_ghasltysk032,nw_skelwarr01,nw_skelwarr02";
string sCR7="blessedorcus,nw_revenant001,wight006,nw_vampire,skelpriest007,skelmage025,toh_ghasltysk008,toh_ghasltysk043,toh_banshee,zep_visagegr,nw_spectre";
string sCR8="toh_demonicghast,toh_corghast,toh_unholyghoul,mummy003,wight003,nw_mohrg,wight004,wight002,zep_wendigo,toh_greatshadow,toh_ghasltysk009,allip002,allip001,toh_haunted,zep_wraith1,zep_wraith2,zep_wraith002,nw_zombieboss";
string sCR9="toee_abhominal,mummy004,mummy001,nw_bodak,zep_quthmaren,wight010,wight001,skelmage003,skelmage255,toh_skeletalaber,skelmage001,toh_unholypriest,groaningspirit,wraith001";
string sCR10="toh_darkghast,nw_ghoulboss,toh_fallenmummy,nw_mumfight,nw_doomkght,skelpriest003,toh_skeletalwiz,spectre002";
string sCR11="nw_mummyboss,mummy002,morbidmohrg001,skelpriest004,zep_skeldyn_002,nw_skelchief";
string sCR12="bastardsaint,ghast001,nw_vampire001,morbidmohrg002,skelwarr002,skelpriest002,fallenone,knightofbaal,skelwarr006,spectre001";
string sCR13="toh_demonic_ghul,mumfight001,nw_skeldevour,nw_vampire004,nw_vampire002,wight007,nw_shfiend,zep_shlor";
string sCR14="mumcleric001,toh_demonicvamp,vampire001,zep_flvampf_001,skelwarr003,skelpriest008,skelpriest009,julian,bellreid";
string sCR15="mumcleric002,vampire004,morbidmohrg003";
string sCR16="zep_reaver_001,nw_mumcleric,mumfight002,wight005,nw_vampire003,vampire002,x3_hagatha,skelwarr005";
string sCR17="nw_lich003,zep_lizlich2,skelpriest005,toh_evilspiri001,toh_evilspirit";
string sCR18="zep_cjguard_001,x2_mindflayer003,nw_lich002,unholyvampmage,zep_skeldyn_003,zep_wraith003,zep_wraith004";
string sCR19="toh_hereticalgha,ghast002,zep_shlord001,toh_morbidsaint,zep_wraith005,toh_haunted001";
string sCR20="toh_darkghast001,mummyboss001,zep_dklord_001,zep_demi_lich,zep_dklord_002";
string sCR21="nw_lichboss,zep_lizlich3,toh_unholypri001";
string sCR22="toh_fallenghoul,wight008";
string sCR23="mumcleric003,toh_morbidsai001";
string sCR24="x2_demilich001,skelwarr004,skeleton001";
string sCR26="toh_spawnoforcus,skeleton002";
string sCR27="skelpriest006";
string sCR28="lich002,lich003,nw_lich001,zep_lizlich1,lich005,vampire003";
string sCR30="toh_fallengho001";
string sCR32="x3_masterius001,x3_masterius002,x3_masterius003,toh_morbidhereti";
string sCR33="toh_champofhell";
string sCR34="toh_lichdemon";
string sCR35="skelwarr007";
string sCR36="lich004";
string sCR40="toh_champofhe001,toh_deathpriest";
string sCR41="lich006";
string sCR42="zep_dracolich";
string sCR43="x2_dracolich001";
string sCR45="tk_demi_lich";
string sCR47="toh_champofhe002,toh_lichking,lich009,toh_deathlich";
string sCR53="lich007";
string sCR54="lich008";
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
    case 25:
    case 26:    PopulateVars(o, 26 ,sCR26 );break;
    case 27:    PopulateVars(o, 27 ,sCR27 );break;
    case 28:    PopulateVars(o, 28 ,sCR28 );break;
    case 29:
    case 30:    PopulateVars(o, 30 ,sCR30 ); break;
    case 31:
    case 32:    PopulateVars(o, 32 ,sCR32 );break;
    case 33:    PopulateVars(o, 33 ,sCR33 );break;
    case 34:    PopulateVars(o, 34 ,sCR34 );break;
    case 35:    PopulateVars(o, 35 ,sCR35 );break;
    case 36:    PopulateVars(o, 36 ,sCR36 );break;
    case 37:
    case 38:
    case 39:
    case 40:    PopulateVars(o, 40 ,sCR40 );break;
    case 41:    PopulateVars(o, 41 ,sCR41 );break;
    case 42:    PopulateVars(o, 42 ,sCR42 );break;
    case 43:    PopulateVars(o, 43 ,sCR43 );break;
    case 45:    PopulateVars(o, 45 ,sCR45 );break;
    case 47:    PopulateVars(o, 47 ,sCR47 );break;
    case 53:    PopulateVars(o, 53 ,sCR53 );break;
    case 54:    PopulateVars(o, 54 ,sCR54 );break;
    case 63:    PopulateVars(o, 63 ,sCR63 );break;
    }
}



void main()
{
    //PopulateVars(o,0,sCR0);
    Spawn();
}


