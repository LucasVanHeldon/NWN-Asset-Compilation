#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="m1q2aescpris01,m1q2prisoner001,nw_dwarfmerc001";
string sCR1="nw_duecler001,nw_duefight001,nw_duemage001,nw_duerogue001,x3_dwarfmount001";
string sCR2="nw_dwarfmerc002";
string sCR4="nw_duecler005,nw_duefight005,nw_duemage005,nw_duerogue005,nw_dwarfmerc003,x2_duergar002";
string sCR7="nw_duefight010,nw_duemage010,nw_duerogue010,nw_dwarfmerc004,x2_mephduer004,x2_mephduer007";
string sCR8="nw_duecler010,x2_duergar003,x2_mephduer001,x2_mephduer010";
string sCR9="nw_dwarfmerc005";
string sCR10="nw_duerogue015,x2_duergar004";
string sCR11="nw_duecler015,nw_duefight015,nw_duemage015";
string sCR12="x2_mephduer002,x2_mephduer005,x2_mephduer008";
string sCR13="nw_duerogue020,nw_dwarfmerc006,x2_duergar005,x2_mephduer011";
string sCR14="nw_duefight020,nw_duemage020";
string sCR15="nw_duecler020";
string sCR17="x2_mephduer003,x2_mephduer006,x2_mephduer009";
string sCR18="x2_mephduer012";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 0:    PopulateVars(o,0,sCR0); break;
    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;


    case 4:    PopulateVars(o,4,sCR4); break;

    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;
    case 9:    PopulateVars(o,9,sCR9); break;

    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:   PopulateVars(o,12,sCR12);break;
    case 13:   PopulateVars(o,13,sCR13);break;
    case 14:   PopulateVars(o,14,sCR14);break;
    case 15:   PopulateVars(o,15,sCR15);break;
    case 17:   PopulateVars(o,17,sCR17);break;
    case 18:   PopulateVars(o,18,sCR18);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");
    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();
}


