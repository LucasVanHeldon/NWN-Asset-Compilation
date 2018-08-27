
#include "x0_i0_stringlib"
#include "nw_i0_generic"

void Fill(int nCR,object o = OBJECT_SELF);

/// calcs num monsters of CR for party of 4 at EL
float CalcNumFromELCR(int el, float CR)
{

    if(el <= 0) el = 1;
    if(CR <= 0.0) CR = 1.0;

    float n =  IntToFloat(el) / (CR);
    if(n - IntToFloat(abs(FloatToInt(n))) >= 0.5)
        n=n+1.0;

    int difficulty = GetLocalInt(GetModule(),"difficulty");
    if(difficulty == -2) n = n / 4;
    else if(difficulty == -1) n = n / 2;
    else if(difficulty == 1) n = n + n/2;
    else if(difficulty == 2) n = 2*n;

    if(n < 1.0) n= 1.0;
    if(n > 12.0) n = 12.0;
    int x = FloatToInt(n);
    return IntToFloat(Random(x)+1);

}

void DoPop(object oC, int CR, string list)
{
    //SendMessageToPC(GetFirstPC(),"Populating="+IntToString(CR));

    struct sStringTokenizer toks = GetStringTokenizer(list,",");
    int cnt = 0;

    while( HasMoreTokens(toks) )
    {
        toks = AdvanceToNextToken(toks);

        string r = GetNextToken(toks);
        //SendMessageToPC(GetFirstPC(),"Token="+r);
        cnt = cnt+1;

        string bp = "BP"+IntToString(CR)+"_"+IntToString(cnt);
        SetLocalString(oC,bp,r);

    }
    SetLocalInt(oC,"nNum"+IntToString(CR),cnt);
}
void PopulateVars(object oC,int CR,string list)
{
    if(GetLocalInt(oC,"nNum"+IntToString(CR)) == 0)
    {
        DoPop(oC,CR,list);
    }

}

int CalcEL(object oC)
{
    object oX = GetFirstObjectInShape(SHAPE_SPHERE,120.0,GetLocation(oC));
    int total = 0;
    int cnt = 0;

    while(GetIsObjectValid(oX))
    {
        if(GetIsEnemy(oX,oC) || GetIsPC(oX))
        {
            total += GetCharacterLevel(oX);
            cnt++;
        }
        oX = GetNextObjectInShape(SHAPE_SPHERE,120.0,GetLocation(oC));
    }
    //SendMessageToPC(GetFirstPC(),"total="+IntToString(total)+",cnt="+IntToString(cnt));
    if(cnt == 0) return 0;
    return total/cnt;
}

void ENC_Spawner(object oS, int EL, float CR, int dontlvl=0)
{
    int   num = FloatToInt(CalcNumFromELCR(EL,CR));
    int   nCR = FloatToInt(CR);
    int i;
    string sTag;
    int d = GetLocalInt(GetModule(),"difficulty");
    Fill(nCR);
    int   nNum = Random(GetLocalInt(oS,"nNum"+IntToString(nCR)))+1;
    int nTemp = nCR;
    if(nNum == 0)
    {
        do
        {
            nCR = nCR - 1;
            nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)))+1;
        }
        while(nNum == 0 && nCR > 0);

        if(nNum != 0 )
        {
            CR = IntToFloat(nCR);
            if(CR < 0.5) CR = 0.5;
            Fill(nCR);
        }

    }


    int c = 0;
    if(nNum > 0)
    {
        sTag = GetLocalString(oS,"BP"+IntToString(nCR)+"_"+IntToString(nNum));

        num = FloatToInt(CalcNumFromELCR(EL,CR));

        for(i = 0; i < num; i++)
        {
            object o = CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oS));
            if(GetIsObjectValid(o))
            {
                c++;
                if(dontlvl == 1) SetLocalInt(o,"bNeverLvlUp",1);
                AssignCommand(o,ActionRandomWalk());
            }
        }
    }
    // else try spawning some other thing
    if(c== 0)
    {
        switch(Random(12)+1)
        {
        case 1: CreateObject(OBJECT_TYPE_CREATURE,"enc_aberrations",GetLocation(OBJECT_SELF)); break;
        case 2: CreateObject(OBJECT_TYPE_CREATURE,"enc_undead",GetLocation(OBJECT_SELF)); break;
        case 3: CreateObject(OBJECT_TYPE_CREATURE,"enc_orcs",GetLocation(OBJECT_SELF)); break;
        case 4: CreateObject(OBJECT_TYPE_CREATURE,"enc_goblins",GetLocation(OBJECT_SELF)); break;
        case 5: CreateObject(OBJECT_TYPE_CREATURE,"enc_gnolls",GetLocation(OBJECT_SELF)); break;
        case 6: CreateObject(OBJECT_TYPE_CREATURE,"enc_ogres",GetLocation(OBJECT_SELF)); break;
        case 7: CreateObject(OBJECT_TYPE_CREATURE,"enc_trolls",GetLocation(OBJECT_SELF)); break;
        case 8: CreateObject(OBJECT_TYPE_CREATURE,"enc_hobgoblins",GetLocation(OBJECT_SELF)); break;
        case 9: CreateObject(OBJECT_TYPE_CREATURE,"enc_aberrate",GetLocation(OBJECT_SELF)); break;
        case 10: CreateObject(OBJECT_TYPE_CREATURE,"enc_undead",GetLocation(OBJECT_SELF)); break;
        case 11: CreateObject(OBJECT_TYPE_CREATURE,"enc_minotaur",GetLocation(OBJECT_SELF)); break;
        case 12: CreateObject(OBJECT_TYPE_CREATURE,"enc_beasts",GetLocation(OBJECT_SELF)); break;
        case 13: CreateObject(OBJECT_TYPE_CREATURE,"enc_construct",GetLocation(OBJECT_SELF)); break;
        }
    }
}

void Spawn(object oS=OBJECT_SELF)
{
    int   EL = CalcEL(oS)+GetLocalInt(GetModule(),"difficulty");
        //GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");
    if(EL < 0) EL = 0;
    float CR = IntToFloat(EL);
    CR += GetLocalFloat(GetModule(),"fCR");
    if(CR == 0.0) CR = 0.5;


    ENC_Spawner(oS,EL,CR);
    /*
    if(CR > 1.0 && GetLocalInt(GetModule(),"difficulty") > 0)
    {
        CR = CR / 2.0;
        ENC_Spawner(oS,EL,CR);
    }
    */
    DestroyObject(oS);
}

void SpawnCR(float CR, int difMod=-4, object oS=OBJECT_SELF)
{
    int   EL = CalcEL(oS)+GetLocalInt(GetModule(),"difficulty")+difMod;
    if(EL < 0) return;
    CR += GetLocalFloat(GetModule(),"fCR");

    ENC_Spawner(oS,EL,CR);


    DestroyObject(oS);
}

void SpawnMinions(float CR,object oS = OBJECT_SELF)
{
    int   EL = CalcEL(oS);

    ENC_Spawner(oS,EL,CR,1);
    DestroyObject(oS);
}


