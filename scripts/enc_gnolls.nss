#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="zep_orc,nw_goblina,nw_goblinb";
string sCR1="toee_gobftr,nw_orca,nw_orcb,zep_orc4,berserkclan,berserkclan001,berserkclan002,clovenclan,clovenclan005,clovenclan006,berserkclan003,berserkclan004,talonclan,ulsarkclan,ulsarkclan001";
string sCR2="nw_gnoll001";
string sCR3="mmp_gnollrog,mmp_gnollftr3,mmp_gnolltrickr,toee_gnollbarb";
string sCR4="toee_gnollfighte,toee_gnollranger,mmp_gnollrog001,nw_gnoll002,toee_gnollbar001";
string sCR5="mmp_gnollcleric,toee_gnollfig001,toee_gnollbar002";
string sCR6="toee_gnollfig004,mmp_gnollcler004,toee_gnollran001,gnoll003,toee_gnollbar003";
string sCR7="mmp_gnollcler001,toee_gnollfig002,gnoll004,toee_gnollbar004";
string sCR8="mmp_gnollcler005,toee_gnollfig005,toee_gnollran002,gnoll005,toee_gnollbar005";
string sCR9="mmp_gnollcler002,toee_gnollran003,toee_gnollbar006";
string sCR11="mmp_gnollcler003,toee_gnollbar007";


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
    case 11:
        PopulateVars(o,CR,sCR11);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Gnolls");
    PopulateVars(OBJECT_SELF,0,sCR0);
    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();

}


