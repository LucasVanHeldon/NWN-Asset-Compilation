int CalcLvl(object oPC)
{
    int el =0;
    int i;
    for(i = 0; i < 3; i++)
        el = el + GetLevelByPosition(i,oPC);
    return el;
}

int CalcEL(object oE)
{
    int lvl = CalcLvl(oE);
    int total = 1;
    int i;
    for(i = 0; i < 6; i++)
    {
        object oHench = GetHenchman(oE,i);
        if(GetIsObjectValid(oHench))
        {
            total += 1;
            lvl += CalcLvl(oHench);
        }
    }
    lvl = lvl / total;
    return lvl;
}

void main()
{
    object oE = GetEnteringObject();
    int el = 0;


    if(GetIsPC(oE))
    {
        el = CalcEL(oE);
        //SendMessageToPC(oE,"el="+IntToString(el));
    }
    else
    {
        object oMaster = GetMaster(oE);
        if(GetIsObjectValid(oE))
        {
                el = CalcEL(oMaster);
        }
    }
    int x = el+GetLocalInt(GetModule(),"difficulty");
    if(x < 1) x = 1;
    SetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl",x);
}
