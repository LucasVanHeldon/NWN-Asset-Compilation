#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="nw_skeleton,nw_zombie01,nw_zombie02";
string sCR1="nw_skeleton,nw_zombie02";
string sCR2="nw_ghoul";
string sCR3="nw_shadow,nw_zombtyrant";
string sCR4=",nw_skelmage,nw_allip,nw_zombwarr01,nw_zombwarr02";
string sCR5="nw_ghoullord,toh_nw_mummy,nw_curst003,nw_curst001,nw_wraith";
string sCR6="nw_curst004,nw_curst002,x3_curstsword,nw_skelwarr01,nw_skelwarr02";
string sCR7="nw_revenant001,nw_vampire,nw_spectre";
string sCR8="nw_zombieboss";
string sCR9="nw_bodak,";
string sCR10="nw_ghoulboss,nw_mumfight,nw_doomkght";
string sCR11="nw_mummyboss,nw_skelchief";
string sCR12="nw_vampire001,";
string sCR13="nw_skeldevour,nw_vampire004,nw_vampire002,wight007,nw_shfiend";

string sCR16="nw_vampire003,x3_hagatha,skelwarr005";
string sCR17="nw_lich003,";
string sCR18="x2_mindflayer003,nw_lich002,unholyvampmage";

string sCR21="nw_lichboss";

string sCR24="x2_demilich001";

string sCR28="nw_lich001";

string sCR32="x3_masterius001,x3_masterius002,x3_masterius003";

string sCR43="x2_dracolich001";


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
    case 11:    PopulateVars(o,11,sCR11);break;
    case 12:    PopulateVars(o,12,sCR12);break;
    case 13:    PopulateVars(o,13,sCR13);break;
    case 14:    PopulateVars(o,14,sCR13);break;
    case 15:    PopulateVars(o,15,sCR13);break;
    case 16:    PopulateVars(o,16,sCR16);break;
    case 17:    PopulateVars(o,17,sCR17);break;
    case 18:    PopulateVars(o, 18 ,sCR17 );break;
    case 19:    PopulateVars(o, 18 ,sCR17 );break;
    case 20:    PopulateVars(o, 21 ,sCR21 );break;
    case 21:    PopulateVars(o, 21 ,sCR21 );break;
    case 22:    PopulateVars(o, 22 ,sCR21 );break;
    case 23:    PopulateVars(o, 23 ,sCR21 );break;
    case 24:    PopulateVars(o, 24 ,sCR24 );break;
    case 28:    PopulateVars(o, CR ,sCR28 );break;
    case 32:    PopulateVars(o, CR ,sCR32 );break;
    case 43:
                PopulateVars(o, 43 ,sCR43 );break;
    }
}



void main()
{
    PopulateVars(OBJECT_SELF,0,sCR0);
    Spawn();
}


