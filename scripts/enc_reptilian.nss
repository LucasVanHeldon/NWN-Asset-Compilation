#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="nw_kobold001,nw_kobold002,zep_koboldfly,zep_koboldfly2";
string sCR2="kobold002,nw_kobold003,nw_kobold004,nw_kobold005,nw_kobold006,nw_oldwarb,nw_oldwarra,nw_sahuagin,nw_sahuaginclr,nw_trog001,x0_asabi_warrior,x3_blckcobra001,x3_hybcobra001,zep_ahuizutl,zep_icekobold,zep_icekoboldnob,zep_koboldfly3,zep_koboldfly4,zep_koboldfly5,zep_koboldfly6,zep_minionenvy,zep_miniongreed,zep_minionmal,zep_minionpain,zep_minionsorrow,zep_minionwrath";
string sCR3="nw_sahuaginldr,x3_spitcobra001,zep_icekoboldsha";
string sCR4="nw_oldchiefa,nw_oldchiefb,nw_oldmagea,nw_oldmageb,nw_trog002,x3_goldcobra001,zep_lizardfolk,zep_lizardshaman";
string sCR5="nw_trog003,nw_yuan_ti001,nw_yuan_ti002,x0_asabi_shaman,x3_grtcobra001";
string sCR6="nw_yuan_ti003,x0_asabi_chief";
string sCR20="zep_phyrexiann1,zep_phyrexiann2";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 0:    PopulateVars(o,0,sCR0); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 20:   PopulateVars(o,20,sCR20);break;

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


