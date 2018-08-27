#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="nw_tiefling02,zep_mane,zep_mane2,zep_mane3,zep_monodrone,zep_smiley";
string sCR1="x0_form_worker,zep_bladeling,zep_feyri";
string sCR2="azer002,azer003,dretch";
string sCR3="nw_dmquasit,nw_imp,nw_mepair,nw_mepdust,nw_mepearth,nw_mepfire,nw_mepice,nw_mepmagma,nw_mepooze,nw_mepsalt,nw_mepsteam,nw_mepwater,toh_halffiend,zep_bacar,zep_salaflame001,zep_salaflamebro";
string sCR4="nw_hellhound,nw_shmastif,x0_form_warrior,zep_dretch,zep_dretchcook";
string sCR5="drelb,nw_beastxvim,zep_barghest,zep_barghest2,zep_genie_005,zep_tiefling3,zep_tieflingm4,zep_visilight";
string sCR6="nightmare003,nightmare004,nw_sp_slaadred,zep_abishaiw_001,zep_abishaiw_002,zep_aurenthil,zep_genie_002,zep_kocrachn,zep_nightmare,zep_sala,zep_sala001";
string sCR7="nw_dmsucubus,nw_rakshasa,nw_slaadred,x0_form_taskmast,x2_erinyes,zep_flsucc_001,zep_rakshasab,zep_rakshasaw,zep_rakshasaw2,zep_succubus,zep_sucubusa,zep_tieflingf1,zep_tieflingf2";
string sCR8="babau,nw_dmvrock,nw_halffnd001,nw_slaadbl,nw_slaadgrn,slaadbl001,tiefling003,x3_nightmare002,zep_abishaib_001,zep_abishaib_003,zep_barghestg,zep_barghestg2,zep_genie_001,zep_genie_004,zep_nighthag";
string sCR9="nw_slaadgray,vrock,x3_harat2,zep_erinyes,zep_genie_003,zep_hamatula,zep_osyluth1,zep_osyluth2,zep_osyluth3,zep_slaadgrn";
string sCR10="nw_slaadgryboss,x3_harat,zep_abishaig_001,zep_abishaig_002,zep_erinyes2,zep_maelephant,zep_mezzoloth,zep_spidfiend1,zep_spidfiend2,zep_spidfiend3,zep_spidfiend4,zep_spidfiend5,zep_vrock";
string sCR11="hezrou,nw_s_chound,x0_form_myrmarch,zep_bebilithc,zep_cornugon,zep_cornugona,zep_elderxorn001,zep_flerinyes1,zep_primus,zep_salanob";
string sCR12="x2_spiderdemo001,zep_abishaib_002,zep_abishaib_004,zep_demonvorlan,zep_genie_006,zep_hamatula_35e,zep_oschore,zep_salanob001,zep_yagnoloth";
string sCR13="bod_nalfeshne001,demon,glabrezu,zep_gelugon,zep_guardinal";
string sCR14="bod_nalfeshnee,nightmarecauchem,zep_abishair_001,zep_abishair_002,zep_cornugongr,zep_glabrezu,zep_goristro";
string sCR15="nw_demon,nw_devil001,nw_slaaddeth,nw_slaaddthboss,nw_s_balor_evil,x2_pitfiend001,zep_balor_001,zep_balor_002,zep_balor_003,zep_balor_004,zep_balor_005,zep_balor_006,zep_balor_007,zep_balor_008,zep_balor_009,zep_balor_010,zep_balor_011";
string sCR16="nw_balorboss,toh_cbbabau,zep_balrog,zep_pitfiend,zep_ultroloth";
string sCR17="marilith";
string sCR18="demon001";
string sCR19="zep_nabassu,zep_secundus";
string sCR20="x0_form_queen,zep_marilith,zep_merilith2";
string sCR21="bod_balor";
string sCR22="demon002";

string sCR25="x2_slaadwhite001";
string sCR27="demon003";
string sCR28="toh_chaosslaad,zep_marilithbg";
string sCR30="creature,slaadblack002,x2_slaadblack001";
string sCR41="zuggtmoy";
string sCR54="toh_demon_god,zep_qotal";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 0:    PopulateVars(o,0,sCR0); break;
    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;
    case 9:    PopulateVars(o,9,sCR9); break;
    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:   PopulateVars(o,12,sCR12);break;
    case 13:   PopulateVars(o,13,sCR13);break;
    case 14:   PopulateVars(o,14,sCR14);break;
    case 15:   PopulateVars(o,15,sCR15);break;
    case 16:   PopulateVars(o,15,sCR16);break;
    case 17:   PopulateVars(o,17,sCR17);break;
    case 18:   PopulateVars(o,18,sCR18);break;
    case 19:   PopulateVars(o,19,sCR19);break;
    case 20:   PopulateVars(o,20,sCR20);break;
    case 21:   PopulateVars(o,21,sCR21);break;
    case 22:   PopulateVars(o,22,sCR22);break;
    case 25:   PopulateVars(o,25,sCR25);break;
    case 27:   PopulateVars(o,27,sCR27);break;
    case 28:   PopulateVars(o,28,sCR28);break;
    case 30:   PopulateVars(o,30,sCR30);break;
    case 41:   PopulateVars(o,41,sCR41);break;
    case 54:   PopulateVars(o,54,sCR54);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    Spawn();
}

