
#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="zep_pspiders,zep_pspidert";
string sCR1="x2_deeprothe001,zep_corollax,zep_pspiderm,zep_spidphase";
string sCR2="nw_krenshar";
string sCR3="nw_gargoyle,nw_spidphase,nw_worg,zep_aoskianh1,zep_aoskianh2,zep_pspiderl,zep_thorny,zep_worg";
string sCR4="hydra,x0_basilisk,x0_cockatrice,zep_jagre,zep_thornyrider,zep_thornyridert,zep_thornyriderv";
string sCR5="nw_wolfwint,zep_leucrotta,zep_manticore";
string sCR6="x0_gorgon,x0_manticore,zep_cbaslsk_001";
string sCR7="zep_sphinxhier";
string sCR8="wemic,zep_manticore001";
string sCR9="zep_chimera";
string sCR11="roper,zep_manticore002";
string sCR15="zep_manticore003,zep_pspiderg";
string sCR22="zep_leviathan";

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
    case 11:   PopulateVars(o,11,sCR11);break;
    case 15:   PopulateVars(o,15,sCR15);break;
    case 22:   PopulateVars(o,22,sCR22);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");

    Spawn();
}


