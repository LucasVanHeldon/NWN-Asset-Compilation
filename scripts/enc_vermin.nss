#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="nw_btlfire,zep_dspiders,zep_dspidert,zep_gantlarva,zep_mscorps,zep_mspiders,zep_mspidert,zep_shrieker,zep_spiderling,zep_sspiders,zep_sspidert";
string sCR1="zep_beetlefiref,zep_beetlefiret,zep_beetleslict,zep_beetlespitf,zep_beetlestnkf,zep_dspiderm,zep_mcenti_003,zep_mspiderm,zep_spidgiant";
string sCR2="giantcentipede,gianttick,nw_btlbomb,zep_beetleslicf,zep_beetlespitt,zep_beetlestagf,zep_beetlestnkt,zep_giantantwork,zep_mcenti_001,zep_mcenti_002,zep_mscorpm,zep_scorp,zep_scorp001,zep_scorp002,zep_scorp003,zep_spiderlingsw,zep_sspiderm";
string sCR3="nw_btlfire02,nw_btlstink,nw_spidgiant,spidgiant001,zep_beetlebomb,zep_beetlestagt,zep_dspiderl,zep_gantfire,zep_gantsoldier,zep_gwasp,zep_leech_s,zep_mspiderl,zep_scorpg,zep_scorpg001,zep_scorpg002,zep_scorpg003,zep_spiddire";
string sCR4="nw_spidswrd,zep_gantqueen,zep_gobspidrider,zep_sspiderl";
string sCR5="zep_ganthvqueen,zep_spidbloodbak,zep_spidice";
string sCR6="zep_beetlefireh,zep_beetleslich,zep_gantguard,zep_leech_m";
string sCR7="nw_btlstag,nw_spiddire,zep_beetlespith,zep_beetlestnkh,zep_scorph,zep_scorph001,zep_scorph002,zep_scorph003,zep_spidredback";
string sCR8="zep_leech_l";
string sCR9="zep_beetlestagh";
string sCR10="zep_mscorph";
string sCR14="nw_spiderboss";
string sCR16="nw_beetleboss,zep_dspiderg,zep_mspiderg,zep_sspiderg";
string sCR19="zep_mscorpg";
string sCR28="x3_maggris";

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
    case 14:   PopulateVars(o,14,sCR14);break;
    case 16:   PopulateVars(o,16,sCR16);break;
    case 19:   PopulateVars(o,19,sCR19);break;
    case 28:   PopulateVars(o,28,sCR28);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    Spawn();
}


