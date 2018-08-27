#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0_9="nw_stirge,sr_stirge,zep_stirge,zep_stirgecave,zep_stirgeg";
string sCR2_9="giantfrog";
string sCR3_9="zep_owlbear";
string sCR4_9="zep_terradon1";
string sCR5_9="zep_griffon";
string sCR6_9="toee_owlbear2,zep_griffon001";
string sCR7_9="nw_bulette";
string sCR8_9="nw_grayrend,zep_terradon2";
string sCR9_9="zep_purpleworm";
string sCR10_9="toee_owlbear003";
string sCR11_9="zep_razorboar";
string sCR14_9="toee_owlbear004";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 0:    PopulateVars(o,0,sCR0_9); break;
    case 2:    PopulateVars(o,2,sCR2_9); break;
    case 3:    PopulateVars(o,3,sCR3_9); break;
    case 4:    PopulateVars(o,4,sCR4_9); break;
    case 5:    PopulateVars(o,5,sCR5_9); break;
    case 6:    PopulateVars(o,6,sCR6_9); break;
    case 7:    PopulateVars(o,7,sCR7_9); break;
    case 8:    PopulateVars(o,8,sCR8_9); break;
    case 9:    PopulateVars(o,9,sCR9_9); break;
    case 10:   PopulateVars(o,10,sCR10_9);break;
    case 11:   PopulateVars(o,11,sCR11_9);break;
    case 14:   PopulateVars(o,14,sCR14_9);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Beasts");

    Spawn();
}


