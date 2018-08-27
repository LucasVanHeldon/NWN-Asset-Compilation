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
string sCR8="nw_trollchief,nw_trollwiz";
string sCR9="nw_trollboss,zep_trollboss,toee_trollrngr";
string sCR10="toee_trollbar001";
string sCR11="toee_trollrng001";
string sCR12="toee_trollbar014,toee_trollrng013";
string sCR13="toee_trollbar141,toee_trollrng135,zep_trollwar";
string sCR15="zep_trollwar001";
string sCR14="ogre021,ogre006";
string sCR16="zep_trollwar002";













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
    case 16:

       PopulateVars(o,CR,sCR16);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Trolls");
    PopulateVars(OBJECT_SELF,0,sCR0);
    Spawn();
}


