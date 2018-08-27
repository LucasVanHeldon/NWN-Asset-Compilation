#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="zep_orc,nw_goblina,nw_goblinb";
string sCR1="toee_gobftr,nw_orca,nw_orcb,zep_orc4,berserkclan,berserkclan001,berserkclan002,clovenclan,clovenclan005,clovenclan006,berserkclan003,berserkclan004,talonclan,ulsarkclan,ulsarkclan001";
string sCR2="bugbeara001,bugbearb001,zep_bugbear_001,zep_bugbear_002,zep_bugbear_003,zep_bugbear_004,zep_bugbear_005,zep_bugbear_006,zep_bugbear_007";
string sCR3="nw_bugbeara,nw_bugbearb";
string sCR4="bugbeara010";
string sCR5="bugbeara002,nw_bugchiefa,nw_bugchiefb,nw_bugwiza,nw_bugwizb,mmp_bugbearsorc,bugbeara006";
string sCR6="bugbeara011";
string sCR7="bugbeara003,mmp_bugbearso001,toh_demonicbugbr";
string sCR8="bugbeara004,bugbeara007";
string sCR9="bugbeara012,mmp_bugbearso002,bugbeara008";
string sCR10="bugbeara005,toh_demonicbu001,mmp_bugbearso003";
string sCR12="bugbeara009";
string sCR15="toh_demonicbu003";
string sCR20="toh_demonicbu004";
string sCR25="toh_demonicbu008";









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
    case 11:    PopulateVars(o,11,sCR12);break;
    case 12:    PopulateVars(o,12,sCR12);break;
    case 15:    PopulateVars(o,CR,sCR15);break;
    case 20:    PopulateVars(o, CR ,sCR20 );break;
    case 25:

        PopulateVars(o,CR,sCR25);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Bugbears");
    PopulateVars(OBJECT_SELF,0,sCR0);

    int EL = CalcEL(OBJECT_SELF);
    if(EL > 2)
        SpawnCR(0.5);

    Spawn();

}


