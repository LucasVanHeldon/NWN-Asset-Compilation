#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR1="nw_ochrejellysml";
string sCR2="zep_crystaloozem,zep_crystaloozes,zep_grayoozem,zep_grayoozes,zep_slitheringm";
string sCR3="greenslime,nw_grayooze,nw_ochrejellymed,x2_gelcube,zep_blackpuddm,zep_blackpudds,zep_brownpuddm,zep_brownpudds,zep_crystaloozel,zep_dunpuddingm,zep_dunpuddings,zep_grayoozel,zep_greenslimem,zep_greenslimes,zep_mustardjelm,zep_mustardjels,zep_ochrejellym,zep_ochrejellys,zep_oliveslimem,zep_oliveslimes,zep_slitherings,zep_whitepuddm,zep_whitepudds";
string sCR4="ascomid,violetfungi,zep_blackpuddl,zep_brownpuddl,zep_dunpuddingl,zep_greenslimel,zep_mustardjell,zep_ochrejellyl,zep_oliveslimel,zep_slitheringl,zep_whitepuddl";
string sCR5="nw_ochrejellylrg,ochrejellylrg001,toh_ooze,toh_oozecube";
string sCR6="ascomid001,violetfungi001";
string sCR7="toh_oozelbpuddin";
string sCR8="toy_coz,zep_blackpuddinh";
string sCR9="toh_aberslime";
string sCR15="zep_blackpudding";
string sCR26="zep_blackpudd001";

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
    case 15:   PopulateVars(o,15,sCR15);break;
    case 26:   PopulateVars(o,26,sCR26);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    Spawn();
}


