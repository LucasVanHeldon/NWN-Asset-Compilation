#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="nw_wererat,x3_antoine,zep_werefrog,zep_wererata";
string sCR2="nw_werewolf,zep_skulkf,zep_skulkm,zep_wereratg,zep_werewolfr1,zep_werewolfr2,zep_werewolfr3,zep_werewolf_001";
string sCR3="nw_aranea,zep_doppelganger,zep_werebat,zep_werebatb1,zep_werebatb2,zep_wereboar,zep_werecroc";
string sCR5="nw_werecat,zep_werebear,zep_werejag_001,zep_wereleopard,zep_werepuma,zep_werewolf_002";
string sCR6="werewolf001";
string sCR7="nw_beastmalar001";
string sCR9="x3_wereboar001";
string sCR10="werewolf002";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 0:    PopulateVars(o,0,sCR0); break;

    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;

    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;

    case 9:    PopulateVars(o,9,sCR9); break;
    case 10:   PopulateVars(o,10,sCR10);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    Spawn();
}

