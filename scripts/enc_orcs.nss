#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="zep_bsorca,zep_bsorcb,zep_orc,zep_orc2,zep_orcbloodg,zep_orcmerc";
string sCR1="nw_orca,nw_orcb,zep_orc4,zep_urakhai,zep_urakhaisold";
string sCR2="berserkclan,berserkclan001,berserkclan002,berserkclan003,berserkclan004,berserkclan018,clovenclan,clovenclan005,clovenclan006,talonclan,toee_orcbarb,ulsarkclan,ulsarkclan001,zep_ogrillon,zep_ogrillon001,zep_ogrillon3,zep_ogrillon4";
string sCR3="boo_uche,nw_orcchiefa,toee_orcbarb001,toee_orcbarb006,zep_bsorcchiefa,zep_bsorcchiefb,zep_frostorc";
string sCR4="berserkclan007,berserkclan008,berserkclan009,berserkclan012,berserkclan017,clovenclan001,clovenclan004,clovenclan007,nw_orcchiefb,nw_orcwiza,talonclan001,talonclan004,toee_orcbarb002,toee_orcbarb007,toee_orcbarb009,ulsarkclan002,ulsarkclan007,zep_bsorcwiza,zep_bsorcwizb,zep_urakhais";
string sCR5="berserkclan006,berserkclan010,berserkclan013,berserkclan015,berserkclan016,clovenclan002,clovenclan003,clovenclan008,nw_orcwizb,talonclan002,talonclan005,talonclan006,toee_orcbarb003,ulsarkclan003,ulsarkclan005,ulsarkclan006,zep_orc3,zep_urakhaib";
string sCR6="berserkclan011,clovenclan009,orcwiza001,talonclan003,toee_orcbarb008,ulsarkclan004,zep_frostorcch";
string sCR7="berserkclan005,berserkclan014,orcwizb001,toee_orcbarb004,zep_frostorcsh";
string sCR8="orcwizb002,toee_orcbarb005";
string sCR10="zep_orcboss";
string sCR11="nw_orcboss";
string sCR12="zep_urakhaic";


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
    case 8:    PopulateVars(o,CR,sCR8); break;
    case 10:    PopulateVars(o,CR,sCR10); break;
    case 11:    PopulateVars(o,CR,sCR11); break;
    case 12:    PopulateVars(o,CR,sCR12); break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Orcs");
    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();
}


