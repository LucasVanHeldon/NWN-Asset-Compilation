#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="nw_goblina,nw_goblinb,zep_gibber_001,zep_gibber_002";
string sCR1="toee_gobftr,nw_orca,nw_orcb,zep_orc4,berserkclan,berserkclan001,berserkclan002,clovenclan,clovenclan005,clovenclan006,berserkclan003,berserkclan004,talonclan,ulsarkclan,ulsarkclan001";
string sCR2="nw_gnoll001,bugbeara001,bugbearb001,zep_bugbear_001,zep_bugbear_002,zep_bugbear_003,zep_bugbear_004,zep_bugbear_005,zep_bugbear_006,zep_bugbear_007";
string sCR3="nw_ogre01,ogre003";
string sCR4="nw_ogre02";
string sCR5="zep_troll,zep_troll01,mmp_troll,nw_troll";
string sCR6="ogre008,ogre018,nw_ogrechief01,nw_ogrechief02,nw_ogremage01,nw_ogremage02,ogre002";
string sCR7="zep_trollchief,zep_trollwiz";
string sCR8="nw_trollchief,nw_trollwiz,nw_ettin";
string sCR9="nw_trollboss,zep_trollboss,toee_trollrngr";
string sCR10="toee_trollbar001,zep_cyclopsa,zep_cyclops,nw_gnthill,nw_gntmount,nw_gntfrost";
string sCR11="toee_trollrng001,x0_gntfrostfem,zep_gntfrsta_001";
string sCR12="x0_gntfirefem,toee_trollbar014,toee_trollrng013";
string sCR13="gntfire002,toee_trollbar141,toee_trollrng135,zep_trollwar";
string sCR14="zep_gntmntc_001,nw_gntfire";
string sCR15="zep_gnthillc_001,zep_trollwar001";
string sCR16="gntfire004,gntfirefem001,zep_gntfrstc_001,zep_trollwar002";
string sCR18="gntfirefem002,zep_gntfirea_001";
string sCR19="gntfire005,gntfire006,zep_gntfrstw_001";
string sCR20="gntfire007";
string sCR21="zep_gntfirec_001,zep_gntfrsts_001";
string sCR22="zep_gntfirek_005";
string sCR23="zep_gntstone_001,zep_gntfirek_004";
string sCR25="zep_gntfirek_001";
string sCR26="gntfire003,zep_gntfrstj_001";



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
    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:   PopulateVars(o,12,sCR12);break;
    case 13:   PopulateVars(o,13,sCR13);break;
    case 14:   PopulateVars(o,14,sCR14);break;
    case 15:   PopulateVars(o,15,sCR15);break;
    case 16:   PopulateVars(o,16,sCR16);break;
    case 17:
    case 18:   PopulateVars(o,CR,sCR18);break;
    case 19:   PopulateVars(o,19,sCR19);break;
    case 20:   PopulateVars(o,20,sCR20);break;
    case 21:   PopulateVars(o,21,sCR21);break;
    case 22:   PopulateVars(o,22,sCR22);break;
    case 23:   PopulateVars(o,23,sCR23);break;
    case 24:
    case 25:   PopulateVars(o,CR,sCR25);break;
    case 26:   PopulateVars(o,CR,sCR26);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Giants");
    PopulateVars(OBJECT_SELF,0,sCR0);
    Spawn();
}


